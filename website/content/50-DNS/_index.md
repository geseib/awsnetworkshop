+++
title = "DNS Setup"
menutitle = "DNS Setup"
chapter = false
weight = 50
+++

## DNS between On-Prem and the Cloud

We want to be able to allow systems in our datacenter and our VPCs to use DNS to lookup addresses without having to manage DNS servers on EC2 instances.

## Datacenter to VPC DNS lookup flow diagram

![DNS DC to DCS](../images/dns-dc1tonp1.png)

## VPC to Datacenter DNS lookup flow diagram

![DNS NP1 to DC](../images/dns-np1todc.png)
