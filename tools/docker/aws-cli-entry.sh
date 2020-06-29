#!/bin/bash
sleep 40
aws --endpoint http://local-stack:4576 sqs create-queue --attributes file://aws-cli-attributes.json --queue-name service1-queue
aws --endpoint http://local-stack:4576 sqs create-queue --attributes file://aws-cli-attributes.json --queue-name service2-queue
aws --endpoint http://local-stack:4576 sqs create-queue --attributes file://aws-cli-attributes.json --queue-name notification-queue
aws --endpoint-url http://local-stack:4575 sns create-topic --name application-notifications
aws --endpoint-url http://local-stack:4576 sqs create-queue --attributes file://aws-cli-attributes.json --queue-name communications-queue
aws --endpoint-url http://local-stack:4575 sns subscribe --topic-arn arn:aws:sns:ap-southeast-2:000000000000:application-notifications --protocol sqs --notification-endpoint arn:aws:sns:ap-southeast-2:000000000000:communications-queue --attributes "{\"RawMessageDelivery\":\"true\",\"FilterPolicy\":\"{\\\"event_type\\\":[\\\"PersonSettingsChanged\\\"],\\\"region\\\":[\\\"NZ\\\"]}\"}"
aws --endpoint-url http://local-stack:4576 sqs create-queue --attributes file://aws-cli-attributes.json --queue-name state-change-notifications-queue
aws --endpoint-url http://local-stack:4575 sns subscribe --topic-arn arn:aws:sns:ap-southeast-2:000000000000:application-notifications --protocol sqs --notification-endpoint arn:aws:sns:ap-southeast-2:000000000000:state-change-notifications-queue --attributes "{\"RawMessageDelivery\":\"true\",\"FilterPolicy\":\"{\\\"event_type\\\":[\\\"StateChange\\\"],\\\"region\\\":[\\\"NZ\\\",\\\"AU\\\"]}\"}"
aws --endpoint-url http://local-stack:4576 sqs create-queue --attributes file://aws-cli-attributes.json --queue-name person-deleted-notifications-queue
aws --endpoint-url http://local-stack:4575 sns subscribe --topic-arn arn:aws:sns:ap-southeast-2:000000000000:application-notifications --protocol sqs --notification-endpoint arn:aws:sns:ap-southeast-2:000000000000:person-deleted-notifications-queue --attributes "{\"RawMessageDelivery\":\"true\",\"FilterPolicy\":\"{\\\"event_type\\\":[\\\"PersonDeleted\\\"],\\\"region\\\":[\\\"NZ\\\",\\\"AU\\\"]}\"}"
aws --endpoint-url http://local-stack:4575 sns list-subscriptions
sleep 1800
