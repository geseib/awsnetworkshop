+++
title = "Create NP2 Endpoint Service"
menutitle = "Create Endpoint Service"
chapter = false
weight = 50
+++

## Create Endpoint Service
As the Service Provider, you want to enable your NLB to be shared with other VPCs. You Can whitelist AWS accounts that can create Endpoints in their VPCs if they explicitly know the name of your new Endpoint Service. if with the Whitelisting, you also have the ability to require explicit acknowledgement from the service provider side, before their PrivateLink becomes active.

1. In the AWS Management Console choose **Services** then select **VPC**.

1. From the menu on the left, Scroll down and select **Endpoint Services**. EndPoint Services allows us to make a Network Load Balancer available to other VPCs, even in other AWS Accounts.

1. In the main pane, click the **Create Endpoint Service** button. 

1. On the **Create Endpoint Service** page Select your ***your-stack*- NP2-NLB** Load Balancer for **Associate Network Load Balancers**

1. You will see the included Availability Zones listed out. If you selected All-AZs from the cloudformation template, all AZs for the region should be listed, as the NLB was deployed in a new set of subnets.

1. Uncheck the **Require acceptance for Endpoint**. *note: other AWS account still will not be able to connect to your Endpoint Service. Only VPCs in your AWS account have access until you add AWS Account numbers to a whitelist.

![Create Endpoint Service](../images/pl-createEndpointSvc.png)

1. Click the **Create service** button at the bottom of the page.

1. In a few minutes, the **Status** should show **Available** in the **Endpoint Services** list. Make a note of the **Service name** in the **Details** tab. It will start with **com.amazonaws.vpce.*region_name*.vpce-svc-...**. You will need to paste this **Service name** in the next module.
