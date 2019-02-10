---
title: "Create VPC"
chapter: true
weight: 50
---

# Create A new VPC for Non-Production

Run CloudFormation template 4.tgw-vpcs.yaml to deploy the VPC in the Same Region as the other accounts Transit Gateway was built in.

## HOW TO Deploy the VPC

1. In the AWS Management Console change to the region the VPCs and Transit Gateway were created **IN THE OTHER ACCOUNT**. This is in the upper right-hand drop-down menu. _note: Today, AWS Transit Gateway can only attach to VPCs in the same region as the Transit Gateway. There are architectures that allow for a multi-region design, for example using VPN and a Transit VPC. This is out of scope for this lab._

1. In the AWS Management Console choose **Services** then select **CloudFormation**.

1. In the main panel select **Create Stack** in the upper right-hand corner.<p>

   ![Create Stack button](../images/createStack.png)

1. Make sure **Template is ready** is selected from Prepare template options.

1. At the **Create stack** screen, for **Template source** select **Upload a template file** and click **Choose file** from **Upload a Template file**. from your local files select **1.tgw-vpcs.yaml** and click **Open**.

1. Back at the **Create stack** screen, click **Next** in the lower right.

1. For the **Specify stack details** give the stack a name and Select two Availability Zones (AZs) to deploy to. _We will be deploying all of the VPCs in the same AZs, but that is not required by AWS Transit Gateway_. Click **Next**.
   ![Stack Parameters](../images/createStack-CROSSparameters.png)

1. For **Configuration stack options** we don't need to change anything, so just click **Next** in the bottom right.

1. Scroll down to the bottom of the **Review name_of_your_stack** and check the **I acknowledge that AWS CloudFormation might create IAM resources with custom names.** Click the **Create** button in the lower right.
   ![Create Stack](../images/createStack-VPCiam.png)

1. Wait for the Stack to show **Create_Complete**.
   ![Stack Complete](../images/createStack-CROSScomplete.png)
