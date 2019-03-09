---
title: "IP Addressing"
chapter: true
weight: 60
---

# IP Addressing

![Speficy Details Screenshot](../images/hybrid-subnets-diagram.png)

Carving up and assigning private IP address (RFC 1918 addresses) space is big subject and can be daunting of you have a large enterprise today, especially with mergers. Even when you have a centralized IP address management system (IPAM), you will find undocumented address space being used and sometimes finding useable space is difficult. However we want to find large non-fragmented spaces so we can create a well-summarized network. Don't laugh, we all like a challenge, right?
In our case we found that the 10.0.0.0/11 space was available (I know, fiction, right?). So, we are going to carve up /13's for our production and non-production and we will grab a /16's for our shared service and a /16 for our simulated datacenter.
What does that mean?

1. **Non-Production CIDR: 10.16.0.0/13** is 10.16.0.0 - 10.23.255.255. which we can carve into eight /16 subnets, one for each of our VPCs.
1. **Production CIDR: 10.8.0.0/13** is 10.8.0.0 - 10.15.255.255. which we can also carve into eight /16 subnets.
1. **Shared Service CIDR: 10.0.0.0/16** - 10.0.0.0 - 10.0.255.255. which we will use for 1 Datacenter Services VPC.

##Datacenter IP Addresses
We also will carve out a /16 CIDR for our Datacenter. In the real world this will likely be a list of many summarized CIDRs, both rfc 1918(private address space) and public IP CIDRs (addresses typically assigned to your organization from the Internet Assigned Numbers Authority (IANA) )

- **Simulated Datacenter CIDR: 10.4.0.0/16** - 10.4.0.0 - 10.4.255.255. which will be our Datacenter VPC.
