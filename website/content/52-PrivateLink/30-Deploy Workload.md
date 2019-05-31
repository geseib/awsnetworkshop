---
title: "Deploy Network Load Balancer and Autoscaling Group"
chapter: true
weight: 30
---

## Deploy a LoadBalanced Web in the NP2 VPC

Run CloudFormation template 6.tgw-privatelink.yaml to deploy a Network LoadBalancer in either new subnets or the private subnets. The template will also deploy a Web Application using an Autoscaling Group in the NP2 private subnets.

## HOW TO Deploy the NLB and Autoscaling Group

1. Click on the CloudFormation Launch link below that corresponds to the AWS Region in which you deploy the first stack.

   [![US East (N. Virginia)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/us-east-1.svg)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/create/review?stackName=tgw1-dns&templateURL=https://s3.amazonaws.com/{{<codebucket>}}/6.tgw-privatelink.yaml&param_ParentStack=tgw1)
   [![US East (Ohio)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/us-east-2.svg)](https://console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks/create/review?stackName=tgw1-dns&templateURL=https://s3.amazonaws.com/{{<codebucket>}}/6.tgw-privatelink.yaml&param_ParentStack=tgw1)
   [![US West (Oregon)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/us-west-2.svg)](https://console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/create/review?stackName=tgw1-dns&templateURL=https://s3.amazonaws.com/{{<codebucket>}}/6.tgw-privatelink.yaml&param_ParentStack=tgw1)
   [![EU West (Ireland)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/eu-west-1.svg)](https://console.aws.amazon.com/cloudformation/home?region=eu-west-1#/stacks/create/review?stackName=tgw1-dns&templateURL=https://s3.amazonaws.com/{{<codebucket>}}/6.tgw-privatelink.yaml&param_ParentStack=tgw1)
   [![AP Southeast (Singapore)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/ap-southeast-1.svg)](https://console.aws.amazon.com/cloudformation/home?region=ap-southeast-1#/stacks/create/review?stackName=tgw1-dns&templateURL=https://s3.amazonaws.com/{{<codebucket>}}/6.tgw-privatelink.yaml&param_ParentStack=tgw1)
   [![AP Northeast (Tokyo)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/ap-northeast-1.svg)](https://console.aws.amazon.com/cloudformation/home?region=ap-northeast-1#/stacks/create/review?stackName=tgw1-dns&templateURL=https://s3.amazonaws.com/{{<codebucket>}}/6.tgw-privatelink.yaml&param_ParentStack=tgw1)

1) For the **Specify stack details** give the stack a name, leave **AllAZs** set to **yes** , for **ParentStack** enter the name of your first stack (must be entered exactly to work). Click **Next**.
   ![Stack Parameters](../images/createStack-PLparameters.png)

1) For **Configuration stack options** we don't need to change anything, so just click **Next** in the bottom right.

1) Scroll down to the bottom of the **Review name_of_your_stack** and check the **I acknowledge that AWS CloudFormation might create IAM resources with custom names.** Click the **Create** button in the lower right.
   ![Create Stack](../images/createStack-VPCiam.png)

1) wait for the Stack to show **Create_Complete**.
   ![Stack Complete](../images/createStack-DNSprogress.png)
