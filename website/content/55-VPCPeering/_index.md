+++
title = "VPC Peering"
chapter = false
weight = 55
+++

# VPC Peering

Amazon Virtual Private Cloud (Amazon VPC) enables you to launch AWS resources into a virtual network that you've defined.

A VPC peering connection is a networking connection between two VPCs that enables you to route traffic between them using private IPv4 addresses or IPv6 addresses. Instances in either VPC can communicate with each other as if they are within the same network. You can create a VPC peering connection between your own VPCs, or with a VPC in another AWS account. The VPCs can be in different regions (also known as an inter-region VPC peering connection).

While we could choose to provide connectivity to an application via the Transit Gateway, there may be times where we want to share access to an VPC from another VPC when there is not a route between them. 

## A couple of Scenarios:

1. Multiple applications in a VPC that has no VPN or TGW access to other VPCS.

1. The need for more bandwidth that Transit Gateway provides. While TGW provides over 40Gbps per Availability Zone, Peering within the same regions is nearly unlimited, only limited by the individual Instances and services bandwidth limits. *i.e. you could have 100 instances of i3.8xlarge with 10Gbps each talking to 100 instances i3.8xlarge in another VPC. Over VPC peering, they could be running at near line rate to each other. Note: each TCP flow is limited to 5Gbps, so to achieve >5Gbps you need to have multiple flows between two hosts. For example, to get 25Gbps between two m5.24xlarge instances, you weill need 25/5 = 5 TCP flows.*

## Caveats

1. The two VPCs cannot have overlapping IP address spaces in their CIDRs. 

1. You are limited to 50 VPC peering connections per VPC. However, this limit can be raised to 125.


## VPC Peer

![VPC peering](../images/peer-np1tonp2diagram.png)


