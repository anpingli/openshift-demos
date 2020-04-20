# Sprint 182: Log Forwarding support for Kafka

## Goals
- Provide support to forward logs from OpenShift to a Kafka cluster
- Provide support to separate log per type and Kafka Topic

## Non-Goals
- Expose full-blown tuning and peformance options for Kafka in Log Fowarding API

## Demo

### Prequisites
- Cluster Logging Operator 4.5.x installed & running

### Limitations
- Cluster Logging, Kafka cluster and consumer running on the same cluster
- Not HA Kafka setup
- Using logforwarding/v1alpha1 API due to a bug blocker
