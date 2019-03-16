+++
title = "Overview"
menutitle = "Overview"
chapter = false
weight = 40
+++

## Considerations

When building a multi-VPC and/or multi-account architecture there are several services that we need to consider to provide seamless integration between our AWS environment and the existing infrastrucutre in our datacenter.
Foundationally, we need to provide robust connectivity and routing between the datacenter and all of the VPCs. But we also need to provide and control routing between those VPCs. For example we may have a 'Shared Services' VPC that every other VPC needs access to where we place common resources that everyone needs, such as a NAT Gateway Service to access the internet. At the same time, we dont want just any VPC talking to any other VPC. In this case, we don't want our 'Non-Production' VPCs talking to our 'Production' VPCs.

## The Connectivity

In the past, customers used third-party solutions and/or transit VPCs that they built and managed. In order to remove much of that undifferentiated heavy lifting, we will use **AWS Transit Gateway** Service to provide this connectivty and routing. **AWS Transit Gateway** is a service that enables customers to connect their Amazon Virtual Private Clouds (VPCs) and their on-premise networks to a highly-available gateway. **AWS Transit Gateway** provides easier connectivity, better visibility, more control, and on-demand bandwidth.

## DNS Resolution

After we have connectivity and routing, we need to provide seamless DNS resolution between our Datacenter to the VPCs. Our on-prem devices will want to reach out to our resources in the cloud using DNS names, not IP addresses, and the resources in the cloud will want to do the same for servers back in our datacenter. To do this we will use **Amazon Route53 Resolver**. **Amazon Route53 Resolver** for hybrid clouds allows us to create highly available endpoints in our VPCs to integrate with the Amazon Provided DNS (sometimes referred to as the .2 resolver, since it is always 2 addresses up from the VPC CIDR block, i.e. 172.16.0.2 for VPC CIDR 172.16.0.0/24)
