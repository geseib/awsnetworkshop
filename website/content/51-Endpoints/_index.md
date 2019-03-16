+++
title = "VPC Endpoints"
chapter = false
weight = 51
+++

We can use VPC endpoints if we require communications between services in our VPCs and supported AWS services without travesing an Internet Gateway, NAT Gateway, VPN connection, or AWS Direct Connect.

Endpoints are virtual devices. They are horizontally scaled, redundant, and highly available VPC components. See the [AWS Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-endpoints.html "external link") for more info.

In a multi-VPC envornment, such as this workshop, we have a choice to make where these VPC Endpoints reside: In the local VPC that is accessing the AWS Service, or in a common, shared VPC. In some case, you may decide to have some in a central VPC and some in the local VPCs. In this workshop, we already have the AWS Systems Manager VPC endpoints in the local VPCs. We now will add a KMS VPC endpoint that is in the DCS1 VPC, and the other VPC will be able to use this central endpoint.

## Public Endpoint

![public Endpoint](../images/kms-noendpoint.png)

## Local VPC Endpoint

_add diagram with SSM endspoint_

## Central VPC Endpoint

![Central VPC Endpoint](../images/kms-endpoint.png)
