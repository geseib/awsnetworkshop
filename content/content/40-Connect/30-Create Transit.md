---
title: "Deploy Transit Gateway"
chapter: true
weight: 30
---

Deploy Transit Gateway and Datacenter Router

We now are ready to start our connectivity and routing policy.
Run CloudFormation template 2.tgw-csr.yaml to deploy the Transit Gateway, route Tables, and the Datacenter Router (Cisco CSR).

1. In the AWS Management Console change to the region you are working in. This is in the upper right hand drop down menu.

1. In the AWS Management Console choose **Services** then select **EC2**.

1. From the left-hand menu select **Key Pairs**. _It's half way down, in the **Network & Security** section._

1. Click **Create Key Pair** in the main panel and give your new key a name. Click **Create**.

1. Save the keypair to your local machine for easy access later. _note: we will need this key to access the Cisco CSR router that is in our Simulated Datacenter VPC_.

1. In the AWS Management Console choose **Services** then select **CloudFormation**.

1. In the main panel select **Create Stack** in the upper right hand corner.<p>
   ![Create Stack button](../images/createStack.png)

1. Make sure **Template is ready** is selected from Prepare template options.

1. At the **Create stack** screen, for **Template source** select **Upload a template file** and click **Choose file** from **Upload a Template file**. from your local files select **2.tgw-csr.yaml** and click **Open**.

1. Back at the **Create stack** screen, clcik **Next** in the lower right.

1. For the **Specify stack details** give the stack a name (compounded names work well. i.e. if the VPC stack created in the setup module was named **TGW1** name this stack **TGW1-CSR**), pick the keypair you created earlier, and enter the name of your first stack (must be entered exactly to work). Click **Next**.
   ![Stack Parameters](../images/createStack-CSRparameters.png)

1. For **Configuration stack options** we dont need to change anything, so just click **Next** in the bottom right.

1. Scroll down to the bottom of the **Review name_of_your_stack** and check the **I acknowledge the AWS CloudFormation might create IAM resources with custom names.** Click the **Create** button in the lower right.
   ![Create Stack](../images/createStack-VPCiam.png)

1. wait for the Stack to show **Create_Complete**.
   ![Stack Complete](../images/createStack-CSRcomplete.png)
