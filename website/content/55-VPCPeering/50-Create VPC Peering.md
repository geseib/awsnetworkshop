+++
title = "Create NP2 Peering Request"
chapter = false
weight = 50
+++

## Create VPC Peering Request in NP1
As the Service Provider, you want to enable your NLB to be shared with other VPCs. You Can whitelist AWS accounts that can create Endpoints in their VPCs if they explicitly know the name of your new Endpoint Service. if with the Whitelisting, you also have the ability to require explicit aknowledgement from the service provider side, before their PrivateLink becomes active.

1. In the AWS Management Console choose **Services** then select **VPC**.

1. From the menu on the left, Scroll down and select **Peering Connections**. Peering Connections allow us to connect two VPCs, even in other AWS Accounts. We will focus on local region, but you can also create cross-region VPC peering.

1. In the main pane, click the **Create Peering Connection** button. 

1. On the **Create Peering Connection** page: Give your connection a **Peering connection name tag**, Select your **NP1-*your-stack*** VPC for **VPC (Requester)**, keep Account and Region at defaults, and Select **NP2-*your-stack*** VPC for **VPC (Accepter)**.

1. You will see the CIDR ranges for each listed out. Peering will not succeed if there is an overlap IP CIDRs between the two VPC.


![Create Peering Connection](../images/peer-createPeer.png)

1. Click the **Create Peering Connection** button at the bottom of the page.

1. You should get a Success Page, click **ok**.

![Create Peering Success](../images/peer-createSuccess.png)

1. In the main pane, Verify you have the box next to the peering line item checked, and from the **Actions** button, select **Accept Request**.

![Accept Peering Request](../images/peer-pending.png)

1. In the main pane, The peering connection line item should now show **Active** in the **Status** column.

![Active Peering Connection](../images/peer-active.png)

## Configure VPC Routing in NP1 Public Subnets

1. In the AWS Management Console choose **Services** then select **VPC**.

1. From the menu on the left, Scroll down and select **Route Tables**. Route Tables are associated with Subnets. In this case We are interested in the NP1 Public Subnets and the route table associated with those two subnets.

1. In the main pane, type in a filter **NP1** and check the box next to the **NP1-*Stack_Name*-Public Route Table** line item. *Be sure to select the Public route table for the NP1 VPC*

![Edit Route Table](../images/peer-routeTable.png)

1. From the **Actions** button, select **Edit Routes**. We are going to add a route to just the two NP2 Public Subnets, which can be summerized as 10.17.0.0/21 (10.17.0.0/22 + 10.17.4.0/22)

1. From the **Edit Routes** pane, Click the **Add Route** button and add the following entry:
Desitnation: 10.17.0.0/21  
Target: *Select **Peering Connection**  and from the drop down list select the peering connection (should only be one in the lab)*

1. Click **Save Routes** in the bottom right.

![NP1 Routes](../images/peer-np1Routing.png)

## Configure VPC Routing in NP2 Public Subnets

1. In the AWS Management Console choose **Services** then select **VPC**.

1. From the menu on the left, Scroll down and select **Route Tables**. Route Tables are associated with Subnets. In this case We are interested in the NP2 Public Subnets and the route table associated with those two subnets.

1. In the main pane, type in a filter **NP2** and check the box next to the **NP2-*Stack_Name*-Public Route Table** line item. *Be sure to select the Public route table for the NP1 VPC*

![Edit Route Table](../images/peer-routeTable.png)

1. From the **Actions** button, select **Edit Routes**. We are going to add a route to just the two NP1 Public Subnets, which can be summerized as 10.16.0.0/21 (10.16.0.0/22 + 10.16.4.0/22)

1. From the **Edit Routes** pane, Click the **Add Route** button and add the following entry:
Desitnation: 10.16.0.0/21  
Target: *Select **Peering Connection**  and from the drop down list select the peering connection (should only be one in the lab)*

1. Click **Save Routes** in the bottom right.

![NP1 Routes](../images/peer-np2Routing.png)



