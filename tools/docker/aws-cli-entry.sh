#!/bin/bash
sleep 40
aws --endpoint http://local-stack:4576 sqs create-queue --attributes file://aws-cli-attributes.json --queue-name tax-compliance-service-queue
aws --endpoint http://local-stack:4576 sqs create-queue --attributes file://aws-cli-attributes.json --queue-name forms-engine-notifications-queue
aws --endpoint http://local-stack:4576 sqs create-queue --attributes file://aws-cli-attributes.json --queue-name tos-notification-queue
aws --endpoint-url http://local-stack:4575 sns create-topic --name compliance-notifications
aws --endpoint-url http://local-stack:4576 sqs create-queue --attributes file://aws-cli-attributes.json --queue-name nz-compliance-settings-change-notifications-queue
aws --endpoint-url http://local-stack:4575 sns subscribe --topic-arn arn:aws:sns:ap-southeast-2:000000000000:compliance-notifications --protocol sqs --notification-endpoint arn:aws:sns:ap-southeast-2:000000000000:nz-compliance-settings-change-notifications-queue --attributes "{\"RawMessageDelivery\":\"true\",\"FilterPolicy\":\"{\\\"event_type\\\":[\\\"NzClientComplianceSettingsChanged\\\"],\\\"region\\\":[\\\"NZ\\\"]}\"}"
aws --endpoint-url http://local-stack:4576 sqs create-queue --attributes file://aws-cli-attributes.json --queue-name compliance-state-change-in-review-notifications-queue
aws --endpoint-url http://local-stack:4575 sns subscribe --topic-arn arn:aws:sns:ap-southeast-2:000000000000:compliance-notifications --protocol sqs --notification-endpoint arn:aws:sns:ap-southeast-2:000000000000:compliance-state-change-in-review-notifications-queue --attributes "{\"RawMessageDelivery\":\"true\",\"FilterPolicy\":\"{\\\"event_type\\\":[\\\"ComplianceStateChangeToInReview\\\"],\\\"region\\\":[\\\"NZ\\\",\\\"AU\\\"]}\"}"
aws --endpoint-url http://local-stack:4576 sqs create-queue --attributes file://aws-cli-attributes.json --queue-name compliance-state-change-lodge-notifications-queue
aws --endpoint-url http://local-stack:4575 sns subscribe --topic-arn arn:aws:sns:ap-southeast-2:000000000000:compliance-notifications --protocol sqs --notification-endpoint arn:aws:sns:ap-southeast-2:000000000000:compliance-state-change-lodge-notifications-queue --attributes "{\"RawMessageDelivery\":\"true\",\"FilterPolicy\":\"{\\\"event_type\\\":[\\\"ComplianceStateChangeToLodged\\\"],\\\"region\\\":[\\\"NZ\\\",\\\"AU\\\"]}\"}"
aws --endpoint-url http://local-stack:4576 sqs create-queue --attributes file://aws-cli-attributes.json --queue-name compliance-deleted-notifications-queue
aws --endpoint-url http://local-stack:4575 sns subscribe --topic-arn arn:aws:sns:ap-southeast-2:000000000000:compliance-notifications --protocol sqs --notification-endpoint arn:aws:sns:ap-southeast-2:000000000000:compliance-deleted-notifications-queue --attributes "{\"RawMessageDelivery\":\"true\",\"FilterPolicy\":\"{\\\"event_type\\\":[\\\"ComplianceDeleted\\\"],\\\"region\\\":[\\\"NZ\\\",\\\"AU\\\"]}\"}"
aws --endpoint-url http://local-stack:4575 sns list-subscriptions
sleep 1800
