#!/usr/bin/env bash

set -eou pipefail

TARGET_NS="openshift-logging"

#
# Step 1: Delete kafka consumer deployment
#
oc -n "$TARGET_NS" delete deployment kafka-consumer

#
# Step 2: Delete kafka statefulset and resources
#
oc -n "$TARGET_NS" delete statefulset kafka
oc -n "$TARGET_NS" delete svc kafka
oc -n "$TARGET_NS" delete configmap kafka
oc -n "$TARGET_NS" delete clusterrolebinding kafka-node-reader-binding
oc -n "$TARGET_NS" delete clusterrole kafka-node-reader

#
# Step 3: Delete zookeeper statefulset and resources
#
oc -n "$TARGET_NS" delete statefulset zookeeper
oc -n "$TARGET_NS" delete svc zookeeper
oc -n "$TARGET_NS" delete configmap zookeeper

#
# Step 4: Delete logging.openshift.io custom resources
#
oc -n "$TARGET_NS" delete logforwardings.logging.openshift.io instance
oc -n "$TARGET_NS" delete clusterloggings.logging.openshift.io instance
