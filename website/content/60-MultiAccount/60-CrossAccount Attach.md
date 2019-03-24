---
title: "Attach VPC"
chapter: true
weight: 60
---

# Create a Transit Gateway Attachment to the Shared Transit Gateway

In the earlier deployment of our Transit Gateway, we allowed CloudFormation to deploy our Attachments to the VPCs. This time we will walk through the install manually.

## HOW TO Attach VPC to Transit Gateway

**Switch to the other account (from which one you shared the Transtit gateway**
1. In the AWS Management Console change to the region you are working in. This is in the upper right hand drop down menu.

1. In the AWS Management Console choose **Services** then select **VPC**.

1. From the menu on the left, Scroll down and select **Transit Gateway Attachments**.

1. You will see the VPC Attachments listed, but we want to add one to connect our Datacenter. Click the **Create Transit Gateway Attachment** button above the list.

1. Fill out the **Create Transit Gateway Attachment** form.

   - **Transit Gateway ID** select the TGW from the list that is from the other account.
   - **Attachment Type** is **VPC**
   - **Attachment name tag** give it a descriptive name.
   - **DNS support** leave enabled.
   - **IPv6 support** leave unchecked
   - **VPC ID** select the ID that has the name: NP3-_stack_name_ from the list
   - **Subnet IDs** check the two subnets that end in **Attach-A Subnet** and **Attach-B Subnet**.
     Verify you have everything entered correctly and click the **Create attachment** in the bottom right of the main panel.

1. Click **close**

1. Still on the **VPC** Service console, from the menu on the left Scroll up and select **Route Tables**

1. You will see the Route Tables listed in the main pane. Select NP3-_stack_name_-Private route table, Check the box next to it. Let's take a look toward the bottom of the panel and click the **Routes** tab. Currently, there is just one route, the local VPC route. Since the only way out is going to be the Transit Gateway, lets make our life simple and point a default route to the Transit Gateway Attachment. Click the **Edit Routes** in the **Routes** tab.

1. On the **Edit routes** page, Click the **Add route** button and enter a default route by setting the destination of **0.0.0.0/0**. In the Target drop-down, select **Transit Gateway** and pick your Transit Gateway create for this project. Make sure its the one in the other account, not the account you are currently logged into.
   ![Stack Complete](../images/vpc-defaultroute.png)

## Now we need to manage the routing in Transit Gateway account.

1. From the Menu on the Left Select **Transit Gateway Attachments** to give the VCP attachment a name. Scan down the **Resource type** column for the Attachment with the **Name** blank. You can verify this Attachment is from the other Account by looking at the **Details** tab at the bottom of the main panel. The **Resource owner account ID** will be the other AWS account ID. \*note: Back at the top, if you click the pencil that appears when you mouse over the **Name** column, you can enter a name that is different than the first VPN. Be sure to click the _check_ mark to save the name.

1. From the Menu on the Left Select **Transit Gateway Route Tables**. From the table in the main panel select **Red Route Table**. Lets take a look toward the bottom, and click the **Associations** tab. Associations mean that traffic coming from the outside toward the Transit gateway will use this route table to know where the packet will go after routing through the TGW. _note: An attachment can only be Associated with one route table. But a route table can have multiple associations_. Here in the **Red Route Table**, click **Create associations** in the **Associations** tab. From the drop-down list, select the NP3 vpc . _note:it should be the only one in the list without a **Association route table** ._ Click **Create association**.
   ![Associate VPN](../images/tgw-vpnassocationspending.png)

1. While at the **Transit Gateway Route Tables**, take a look at the **Propagations** tab. These are the Resources that dynamically inform the route table. An attachment can propagate to multiple route tables. For the New Non-Production (NP3) VPC, we want to propagate to the Non-Prod(Red) route table and the Datacenter/Datacenter Services ROute table (Green) route table. Lets start with the **Red Route Table**. We can see all of the VPCs are propagating their CIDR to the route table.

1. Click in **Create Propagation** on the field "chose attachment to propagate" select the attachment with "Name Tag" NP3Attac and click in **create propagation**.

1. Repeat the above step on the propagations tab for the **Green Route Table**.
