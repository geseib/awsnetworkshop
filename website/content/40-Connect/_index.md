+++
title = "Connecting the Datacenter to AWS "
chapter = false
weight = 40
+++

## Transit Gateway Setup and VPN to Datacenter

Using a predefined CloudFormation template, we will deploy either a Juniper, Cisco or Strong Swan/Quagga Router into the Simulated Datacenter VPC, and the Transit Gateway will be deployed with a couple of Transit Gateway route tables.

You need to pick either Cisco, Juniper or Strong Swan/Quagga at this point.

![Specify Details Screenshot](/images/hybrid-tgw-diagram.png)
