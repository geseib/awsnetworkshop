---
title: "VPC Layout"
chapter: true
weight: 50
---

# VPC layout

![Speficy Details Screenshot](../images/hybrid-vpcs-diagram.png)

There are lots of choices for VPC and Account Architectures, and this is mostly out-of-scope for this workshop. Take a look at what Androski Spicer presented at re:invent 2018 in his [From One to Many: Evolving VPC Design](https://www.youtube.com/watch?v=8K7GZFff_V0 "youtube video") session.
In our case, we are going to provide three types of VPCs:

1. **Non-production VPCs**: We might create several of these to house our training environments, development, and QA resources.
1. **Prodcution VPCs**: This is for our live production systems.
1. **Shared Resources**: For resources and services that we want shared across all VPCs.

Also, we need a VPC to represent our on-premise environment, a simulated datacenter.

1. **Datacenter**: In this workshop we need to simulate a datacenter. In the real world, this would be our existing datacenter or colo and the hardware it contains. But we are going to make our own version in the cloud!
