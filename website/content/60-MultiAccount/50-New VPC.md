+++
title = "Create A new VPC for Non-Production"
menutitle = "Create VPC"
chapter = false
weight = 50
+++

Run CloudFormation template 4.tgw-vpcs.yaml to deploy the VPC in the Same Region as the other accounts Transit Gateway was built in.

_note: this should be done in another account. not in the Account with the TGW._

## HOW TO Deploy the VPC

1. In the AWS Management Console change to the region the VPCs and Transit Gateway were created **IN THE OTHER ACCOUNT**. This is in the upper right-hand drop-down menu. _note: Today, AWS Transit Gateway can only attach to VPCs in the same region as the Transit Gateway. There are architectures that allow for a multi-region design, for example using VPN and a Transit VPC. This is out of scope for this lab._

1. Click on the CloudFormation Launch link below that corresponds to the AWS Region in which your partner deployed their Transit Gateway.

   [![US East (N. Virginia)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/us-east-1.svg)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/create/review?stackName=tgw1-dns&templateURL=https://s3.amazonaws.com/{{<codebucket>}}/4.tgw-vpc-cross.yaml&param_AvailabilityZoneA=us-east-1a&param_AvailabilityZoneB=us-east-1b)
   [![US East (Ohio)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/us-east-2.svg)](https://console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks/create/review?stackName=tgw1-dns&templateURL=https://s3.amazonaws.com/{{<codebucket>}}/4.tgw-vpc-cross.yaml&param_AvailabilityZoneA=us-east-2a&param_AvailabilityZoneB=us-east-2b)
   [![US West (Oregon)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/us-west-2.svg)](https://console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/create/review?stackName=tgw1-dns&templateURL=https://s3.amazonaws.com/{{<codebucket>}}/4.tgw-vpc-cross.yaml&param_AvailabilityZoneA=us-west-2a&param_AvailabilityZoneB=us-west-2b)
   [![EU West (Ireland)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/eu-west-1.svg)](https://console.aws.amazon.com/cloudformation/home?region=eu-west-1#/stacks/create/review?stackName=tgw1-dns&templateURL=https://s3.amazonaws.com/{{<codebucket>}}/4.tgw-vpc-cross.yaml&param_AvailabilityZoneA=eu-west-1a&param_AvailabilityZoneB=eu-west-1b)
   [![EU West (Singapore)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/ap-southeast-1.svg)](https://console.aws.amazon.com/cloudformation/home?region=ap-southeast-1#/stacks/create/review?stackName=tgw1-dns&templateURL=https://s3.amazonaws.com/{{<codebucket>}}/4.tgw-vpc-cross.yaml&param_AvailabilityZoneA=ap-southeast-1a&param_AvailabilityZoneB=ap-southeast-1b)

1. For the **Specify stack details** give the stack a name and Select two Availability Zones (AZs) to deploy to. _We will be deploying all of the VPCs in the same AZs, but that is not required by AWS Transit Gateway_. Click **Next**.
   ![Stack Parameters](../images/createStack-CROSSparameters.png)

1. For **Configuration stack options** we don't need to change anything, so just click **Next** in the bottom right.

1. Scroll down to the bottom of the **Review name_of_your_stack** and check the **I acknowledge that AWS CloudFormation might create IAM resources with custom names.** Click the **Create** button in the lower right.
   ![Create Stack](../images/createStack-VPCiam.png)

1. Wait for the Stack to show **Create_Complete**.
   ![Stack Complete](../images/createStack-CROSScomplete.png)
