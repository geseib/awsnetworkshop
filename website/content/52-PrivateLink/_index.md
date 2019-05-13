+++
title = "VPC PrivateLink"
chapter = true
weight = 52
+++

# VPC PrivateLink

AWS PrivateLink simplifies the security of data shared with cloud-based applications by eliminating the exposure of data to the public Internet. AWS PrivateLink provides private connectivity between VPCs, AWS services, and on-premises applications, securely on the Amazon network. AWS PrivateLink makes it easy to connect services across different accounts and VPCs to significantly simplify the network architecture.

While we could choose to provide connectivity to an application via the Transit Gateway, there may be times where we want to share access to an application to clients that do not have a route that application. 

A couple of Scenarios:
1. application in a VPC that has no VPN or TGW access to other VPCS.
1. application in a VPC which has overlapping IP addresses with the VPC you want to share with
1. Sharing an applilcation with partners or cusotmers that should only have access to a single application.
1. limit the firewall rules for access to an on premise application by using Privatelink as a single point of access for all VPCs in a region

The most important factor in deciding to use PrivateLink is "Do I want to provide application connectivity where Broader networking connectivty is not available, possible, or desirable by security

PrivateLink is composed of two components: Endpoint Services and Endpoints. Endpoint Services are on the provider side (where our application is to be shared from.) This requires a Network LoadBalancer (NLB)


Endpoints are virtual devices. They are horizontally scaled, redundant, and highly available VPC components. See the [AWS Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-endpoints.html "external link") for more info.

In a multi-VPC envornment, such as this workshop, we have the path to access applications via the Transit Gateway, so we can see how accessing an application via PrivateLink differs from TGW.

## Endpoint Service (Service Provider)

![public Endpoint](../images/pl-createService.png)

## Endpoint (Service Consumer)

![Central VPC Endpoint](../images/pl-createEndpoint.png)
