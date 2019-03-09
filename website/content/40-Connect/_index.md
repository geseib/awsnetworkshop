+++
title = "Connecting the Datacenter to AWS "
chapter = true
weight = 40
+++

## Transit Gateway Setup and VPN to Datacenter

Using a predefined CloudFormation template, we will deploy either a Juniper or Cisco Router into the Simulated Datacenter VPC, and the Transit Gateway will be deployed with a couple of Transit Gateway route tables.

You need to pick either Cisco or Juniper at this point.

![Specify Details Screenshot](/images/hybrid-tgw-diagram.png)
