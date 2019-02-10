---
title: "Deploy DNS Server"
chapter: true
weight: 30
---

# Build out DNS Infrastructure

Run CloudFormation template 3.tgw-dns.yaml to deploy the Bind server in the Datacenter as well as add AWS Route53 Resolver endpoints in the Datacenter Services VPC.

## HOW TO Deploy the Bind Server

1. In the AWS Management Console change to the region you are working in. This is in the upper right-hand drop-down menu.

1. In the AWS Management Console choose **Services** then select **CloudFormation**.

1. In the main panel select **Create Stack** in the upper right hand corner.<p>

   ![Create Stack button](../images/createStack.png)

1. Make sure **Template is ready** is selected from Prepare template options.

1. At the **Create stack** screen, for **Template source** select **Upload a template file** and click **Choose file** from **Upload a Template file**. from your local files select **3.tgw-dns.yaml** and click **Open**.

1. Back at the **Create stack** screen, clcik **Next** in the lower right.

1. For the **Specify stack details** give the stack a name, enter the name of your first stack (must be entered exactly to work), and select DNS compliant domain name, such as **kneetoe.com**. Click **Next**.
   ![Stack Parameters](../images/createStack-DNSparameters.png)

1. For **Configuration stack options** we don't need to change anything, so just click **Next** in the bottom right.

1. Scroll down to the bottom of the **Review name_of_your_stack** and check the **I acknowledge that AWS CloudFormation might create IAM resources with custom names.** Click the **Create** button in the lower right.
   ![Create Stack](../images/createStack-VPCiam.png)

1. wait for the Stack to show **Create_Complete**.
   ![Stack Complete](../images/createStack-DNSprogress.png)
