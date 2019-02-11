---
title: "Deploy VPCs"
chapter: true
weight: 40
---

# Deploy Our Five VPCs

### Run CloudFormation template 1.tgw-vpcs.yaml to deploy the VPCs.

1. Click on the CloudFormation Launch link below that corresponds to the AWS Region in which you want to deploy the workshop. _note: if you are sharing an account with someone else be sure to pick differnt regions._

   [![US East (N. Virginia)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/us-east-1.svg)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/create/review?stackName=tgwworkshop&templateURL=https://s3.amazonaws.com/net-workshop-us-east-1/1.tgw-vpcs.yaml&param_AvailabilityZoneA=us-east-1a&param_AvailabilityZoneB=us-east-1b)

   [![US East (OHIO)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/us-east-2.svg)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/create/review?stackName=tgwworkshop&templateURL=https://s3.amazonaws.com/net-workshop-us-east-2/1.tgw-vpcs.yaml&param_AvailabilityZoneA=us-east-2a&param_AvailabilityZoneB=us-east-2b)

1. If you are shareing the account with someone else doing the workshop, add your initals to the **Stack name**. This will make any IAM roles or other global resource unique.

1. Scroll down to the bottom of the **Review name_of_your_stack** and check the **I acknowledge that AWS CloudFormation might create IAM resources with custom names.** Click the **Create** button in the lower right.
   ![Create Stack](../images/createStack-VPCiam.png)

1. wait for the Stack to show **Create_Complete**.
   ![Stack Complete](../images/createStack-VPCComplete.png)
