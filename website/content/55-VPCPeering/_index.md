+++
title = "VPC Peering"
chapter = true
weight = 55
+++

# VPC Peering

Amazon Virtual Private Cloud (Amazon VPC) enables you to launch AWS resources into a virtual network that you've defined.

A VPC peering connection is a networking connection between two VPCs that enables you to route traffic between them using private IPv4 addresses or IPv6 addresses. Instances in either VPC can communicate with each other as if they are within the same network. You can create a VPC peering connection between your own VPCs, or with a VPC in another AWS account. The VPCs can be in different regions (also known as an inter-region VPC peering connection).

While we could choose to provide connectivity to an application via the Transit Gateway, there may be times where we want to share access to an VPC from another VPC when there is not a route between them. 

## A couple of Scenarios:
1. multiple applications in a VPC that has no VPN or TGW access to other VPCS.

1. you need more bandwidth that Transit Gateway provides. While TGW provides over 40Gbps per Availability Zone, Peering within the same regions is nearly unlimited, only limited by the individual Instances and services bandwidth limits. **i.e. you could have 100 instances of i3.8xlarge with 10Gbps each talking to 100 instances i3.8xlarge in another VPC. Over VPC peering, they could be running at near line rate to each other.

##Caveats
1. The two VPCs cannot have overlapping IP address spaces in their CIDRs. 
1. You are limited to 50 VPC peering conections per VPC. However, this limit can be raised to 125.



The most important factor in deciding to use PrivateLink is "Do I want to provide application connectivity where Broader networking connectivty is not available, possible, or desirable by security

PrivateLink is composed of two components: Endpoint Services and Endpoints. Endpoint Services are on the provider side (where our application is to be shared from.) This requires a Network LoadBalancer (NLB)


Endpoints are virtual devices. They are horizontally scaled, redundant, and highly available VPC components. See the [AWS Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-endpoints.html "external link") for more info.

In a multi-VPC envornment, such as this workshop, we have the path to access applications via the Transit Gateway, so we can see how accessing an application via PrivateLink differs from TGW.

## VPC Peer

![VPC peering](../images/peer-np1tonp2diagram.png)


