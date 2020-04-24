+++
title = "Share VPC"
chapter = false
weight = 70
+++

## Share a VPC with another account

_note: VPCs (or more specifically a VPCs Subnets) can only be shared with AWS accounts in the same organization. To complete this lab use AWS Organizations. If you are given access by AWS at an AWS Event this is take care of for you._

Attaching VPCs in other Accounts is super useful and has its place. But many times, we don't need things to be in separate networks, we just need to separate out who can manage the resources we put in the network. Customer's in the past often created this isolation by using Resource Tags, IAM polices, and IAM roles. Many times, creating a new account and VPC just for this separation. Now with Resource Access Manager and the ability to share Subnets in a VPC, multiple accounts can place resources into the same VPC. Each account having the ability to define its own account limits, security policy, and IAM roles. It also makes the for a cleaner and easier to use network. To be clear, having multiple VPCs still has its place such as isolating security tiers, limiting audit scope, etc.) Lets take a look.

## Share Subnets in a VPC with other Accounts

1. In the AWS Management Console change to the region you plan to work in and change. This is in the upper right-hand drop-down menu.

1. Lets determine the scope of the share. If you are pairing up with someone, choose **Option 1** below, we will use their Account number. If you are working in your Organization, you can also use **Option 2** and share with all of the account in your AWS organization.

   **OPTION 1**

   - Pair up with someone else completing this walkthrough and share your account number with them, and jot their account number down as well. You will use this when identifying **Principals** later. _note: AWS account must be in the same AWS Organizations_
     You will deploy and EC2 instance in the other accounts NP-2 VPC and from their ping the server in NP1 VPC.

   **OPTION 2**

   - Just to the left of the Region Drop down, click on your login drop-down menu and select **My Organization**. On **Your account belongs to the following organization:** screen, make a note of the **Organization ID** (it will start with an **o-**)

1. In the AWS Management Console choose **Services** then select **Resource Access Manager**.

1. From the left-hand menu select **Resource Shares** (you may have to open the Burger menu). Click the **Create a resource share** button in the upper right of the main panel.

1. Fill out the **Create Resource Share** details:

   - **Name** - give it a Descriptive name for the Share
   - **Select Resource type** - from the drop down select **Subnets**.
   - **ID** - from the list, select the two private subnets in NP2 VPC (their **Names** are NP2-_vpc_stack_name_-Priv-A and NP2-_vpc_stack_name_-Priv-B)
   - **Principals - optional** - in the search box, paste the account number or organization ID you recorded a few steps up (depending on which option you picked above). Click the **add** button to the right.
     Verify you have everything entered correctly and click the **Create resource share** in the bottom right of the main panel.
