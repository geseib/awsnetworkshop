+++
title = "Delete Default VPC"
chapter = false
weight = 30
+++

## Getting Started and Deleting Default VPC

First, we need to get our infrastructure in place. The following CloudFormation template will build out _five_ VPCs. In order to do that we will first remove the default VPC. \*note: if you ever remove you default VPC in your own account, you can recreate it via the console or the CLI see the [documentation](https://docs.aws.amazon.com/vpc/latest/userguide/default-vpc.html#create-default-vpc "AWS Default VPC Documentation").

### Pick Region

Since we will be deploying Cloud9 into our Datacenter VPC, we need to pick one of the following Regions:

- N. Virginia (us-east-1)
- Ohio (us-east-2)
- Oregon (us-west-2)
- Ireland (eu-west-1)
- Singapore (ap-southeast-1)

### Delete Default VPC

A default VPC is automatically created for each region in your account. Some customers choose to remove the Default VPC and replace with ones they have planned out to keep things simple and secure. We are going to remove the default VPC for another reason: the number of VPCs per region in an account is soft limited to 5 and our Lab uses five VPCs. If you require more than five in your own accounts, its easy to increase them by making a limit request through the support console, while logged into your account: https://console.aws.amazon.com/support/cases#/create.

1. In the AWS Management Console change to the region you plan to work in and change. This is in the upper right hand drop down menu.

1. In the AWS Management Console choose **Services** then select **VPC**.

1. From the left-hand menu select **Your VPCs**.

1. In the main panel, the checkbox next to only VPC (the default VPC) should be highlighted. You can verify this is the Default VPC by scrolling to the right. The _Default VPC_ column will be maked with **Yes**.

1. With our Default VPC checked select the **Actions** dropdown above it and select **Delete VPC**.

1. In the _Delete VPC_ Panel, check the box 'I Acknowledge that I want to delete my default VPC.' and click the **Delete VPC** button in the bottom right.

1. You should get a green highlighted Dialog stating 'The VPC was deleted' and you can click **Close**. _If it is red, then likely something is deployed into this VPC and you will have to remove those resources (could be EC2 instances, NAT Gateway, VPC endpoints, etc). You could also consider another region from the list above._
