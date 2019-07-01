+++
menutitle = "Deploy VPCs"
chapter = false
weight = 40
+++

## We will deploy five VPCs:

- One each for our Development, Test, and Production environments, for a total of three.
- One for our shared services, such as VPC Endpoints, Hybrid DNS, and NAT Gateway.
- One emulating our Datacenter.

## Run CloudFormation template 1.tgw-vpcs.yaml to deploy the VPCs.

1. Click on the CloudFormation Launch link below that corresponds to the AWS Region in which you want to deploy the workshop. _note: if you are sharing an account with someone else be sure to pick differnt regions._

   [![US East (N. Virginia)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/us-east-1.svg)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/create/review?stackName=tgw&templateURL=https://s3.amazonaws.com/{{<codebucket>}}/1.tgw-vpcs.yaml&param_AvailabilityZoneA=us-east-1a&param_AvailabilityZoneB=us-east-1b)

   [![US East (Ohio)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/us-east-2.svg)](https://console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks/create/review?stackName=tgw&templateURL=https://s3.amazonaws.com/{{<codebucket>}}/1.tgw-vpcs.yaml&param_AvailabilityZoneA=us-east-2a&param_AvailabilityZoneB=us-east-2b)
   [![US West (Oregon)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/us-west-2.svg)](https://console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/create/review?stackName=tgw&templateURL=https://s3.amazonaws.com/{{<codebucket>}}/1.tgw-vpcs.yaml&param_AvailabilityZoneA=us-west-2a&param_AvailabilityZoneB=us-west-2b)
   [![EU West (Ireland)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/eu-west-1.svg)](https://console.aws.amazon.com/cloudformation/home?region=eu-west-1#/stacks/create/review?stackName=tgw&templateURL=https://s3.amazonaws.com/{{<codebucket>}}/1.tgw-vpcs.yaml&param_AvailabilityZoneA=eu-west-1a&param_AvailabilityZoneB=eu-west-1b)
   [![EU West (Singapore)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/ap-southeast-1.svg)](https://console.aws.amazon.com/cloudformation/home?region=ap-southeast-1#/stacks/create/review?stackName=tgw&templateURL=https://s3.amazonaws.com/{{<codebucket>}}/1.tgw-vpcs.yaml&param_AvailabilityZoneA=ap-southeast-1a&param_AvailabilityZoneB=ap-southeast-1b)
   [![AP Northeast (Tokyo)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/ap-northeast-1.svg)](https://console.aws.amazon.com/cloudformation/home?region=ap-northeast-1#/stacks/create/review?stackName=tgw&templateURL=https://s3.amazonaws.com/{{<codebucket>}}/1.tgw-vpcs.yaml&param_AvailabilityZoneA=ap-northeast-1a&param_AvailabilityZoneB=ap-northeast-1c)

1. If you are shareing the account with someone else doing the workshop, add your initals to the **Stack name**. This will make any IAM roles or other global resource unique.

1. Scroll down to the bottom of the **Review name_of_your_stack** and check the **I acknowledge that AWS CloudFormation might create IAM resources with custom names.** Click the **Create** button in the lower right.
   ![Create Stack](../images/createStack-VPCiam.png)

1. wait for the Stack to show **Create_Complete**.
   ![Stack Complete](../images/createStack-VPCComplete.png)
