#!/usr/bin/env bash

set -eou pipefail

TARGET_NS="openshift-logging"

pushd ./kafka || exit 1

#
# Step 1: Deploy zookeeper
#
echo "Deploying zookeeper..."
oc -n "$TARGET_NS" create -f zookeeper-config-map.yaml
oc -n "$TARGET_NS" create -f zookeeper-svc.yaml
oc -n "$TARGET_NS" create -f zookeeper-statefulset.yaml

echo "Waiting zookeeper statefulset to be available..."
oc -n "$TARGET_NS" wait pod -l app=zookeeper --timeout=180s --for=condition=ready
echo "...done"

#
# Step 2: Deploy kafka
#
echo "Deploying kafka statefulset..."
oc -n "$TARGET_NS" create -f kafka-clusterrole.yaml
oc -n "$TARGET_NS" create -f kafka-clusterrolebinding.yaml
oc -n "$TARGET_NS" create -f kafka-config-map.yaml
oc -n "$TARGET_NS" create -f kafka-svc.yaml
oc -n "$TARGET_NS" create -f kafka-statefulset.yaml

echo "Waiting for kafka statefulset to be available..."
oc -n "$TARGET_NS" wait pod -l app=kafka --timeout=180s --for=condition=ready
echo "...done"

#
# Step 3: Deploy a simple kafka consumer for demo purposes
#
oc -n "$TARGET_NS" create -f kafka-consumer-deployment.yaml

echo "Deploying kafka-consumer deployment..."
oc -n "$TARGET_NS" wait deploy kafka-consumer --timeout=120s --for=condition=available
echo "...done"

popd || exit 1
