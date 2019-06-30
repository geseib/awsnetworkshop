+++
title = "Connectivity"
chapter = false
weight = 70
+++

For connectivity between VPCs, AWS Transit Gateway makes life easy, or at least much easier than past solutions. It will form the core of our VPC-to-VPC and VPC-to-Datacenter communication.

AWS Transit Gateway is a service that enables customers to connect their Amazon Virtual Private Clouds (VPCs) and their on-premises networks through a single gateway. As you grow the number of workloads running on AWS, you will find it important to be able, in as simple a fashion as possible, to scale your networks across multiple accounts and Amazon VPCs to keep up with the growth. Today you can connect pairs of Amazon VPCs using VPC Peering; however, managing point-to-point connectivity across many Amazon VPCs, without the ability to centrally manage the connectivity policies, can be operationally costly and cumbersome. For on-premises connectivity, you need to attach your AWS VPN to each individual Amazon VPC. This solution can be time-consuming to build and harder to manage when the number of VPCs grows into the hundreds.
