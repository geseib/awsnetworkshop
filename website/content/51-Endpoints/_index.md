+++
title = "VPC Endpoints"
chapter = true
weight = 51
+++

# VPC Endpoints

We can use VPC endpoints if we require communications between services in our VPCs and supported AWS services without travesing an Internet Gateway, NAT Gateway, VPN connection, or AWS Direct Connect.

Endpoints are virtual devices. They are horizontally scaled, redundant, and highly available VPC components. See the [AWS Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-endpoints.html "external link") for more info.

In a multi-VPC envornment, such as this workshop, we have a choice to make where these VPC Endpoints reside: In the local VPC that is accessing the AWS Service, or in a common, shared VPC. Such as the DCS1 in this workshop.

## Public Endpoint

![public Endpoint](../images/kms-noendpoint.png)

## Central VPC Endpoint

![Central VPC Endpoint](../images/kms-endpoint.png)
