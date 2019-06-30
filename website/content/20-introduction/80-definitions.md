+++
title = "Definitions"
chapter = false
weight = 80
+++

**Key Definitions**

- **attachment** — You can attach a VPC or VPN connection to an AWS Transit Gateway.

- **transit gateway route table** — A Transit Gateway has a default route table and can optionally have additional route tables. A route table includes dynamic and static routes that decide the next hop based on the destination IP address of the packet. The target of these routes could be a VPC or a VPN connection. By default, the VPCs and VPN connections that you attach to a Transit Gateway are associated with the default Transit Gateway route table.

- **associations** — Each attachment is associated with exactly one route table. Each route table can be associated with zero-to-many attachments.

- **route propagation** — A VPC or VPN connection can dynamically propagate routes to a Transit Gateway route table. With a VPC, you must create static routes to send traffic to the Transit Gateway. With a VPN connection, routes are propagated from the Transit Gateway to your on-premises router using Border Gateway Protocol (BGP).
