---
title: "Share TGW"
chapter: true
weight: 40
---

# Share the Transit Gateway for Cross-Account Access

The first scenario we want to walk through is sharing the Transit Gateway so that we can easily route between VPCs that are in other accounts but still in our organization. We can share outside of our organization too through invitations. In this case we are going to share with the organization.

## Determine who to share the Transit Gateway with

1. In the AWS Management Console change to the region you plan to work in and change. This is in the upper right hand drop down menu.

1. Lets determine the scope of the share. If you are pairing up with someone, choose **Option 1** below, we will use their Account number. If you are working in your Organziation, you can also use **Option 2** and share with all of the accounts in your AWS organization.

   **OPTION 1**

   - Pair up with someone else completing this walkthrough and share your account number with them, and jot their account number down as well. You will use this when identifying **Principals** later.
     You will connect a new VPC to their Transit Gateway and they will connect a new VPC to your Accounts Transit Gateway

   **OPTION 2**

   - Just to the left of the Region Drop down, click on your login drop-down menu and select **My organization**. On **Your account belongs to the following organization:** screen, make a note of the **Organization ID** (it will start with an **o-**)
   
   *note: in order for organziation sharing to work, you must change your Resource Access Manger Settings from the master account. login to the master account and change this setting as shown below.*

   ![Org Sharing](../images/ram-orgSettings.png)

## HOW TO Share the Transit Gateway

1. In the AWS Management Console choose **Services** then select **Resource Access Manager**.

1. From the left-hand menu select **Resource Shares** (you may have to open the Burger menu). Click the **Create a resource share** button in the upper right of the main panel.

1. Fill out the **Create Resource Share** details:

- **Name** - give it a Descriptive name for the Share
- **Seclect Resource type** - from the drop down select **Transit Gateways**.
- **ID** - from the list, select the Transit Gateway you created for the Lab
- **Principals - optional** - in the search box, paste the account number or organization ID you recorded a few steps up (depending on which option you picked above). Click the **add** button to the right.
  Verify you have everything entered correctly and click the **Create resource share** in the bottom right of the main panel.
