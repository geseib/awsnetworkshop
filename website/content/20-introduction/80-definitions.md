+++
title = "Definitions"
chapter = false
weight = 80
+++

**Key Definitions**

- **attachment** — You can attach a VPC or VPN connection to a transit gateway.

- **transit gateway route table** — A transit gateway has a default route table and can optionally have additional route tables. A route table includes dynamic and static routes that decide the next hop based on the destination IP address of the packet. The target of these routes could be a VPC or a VPN connection. By default, the VPCs and VPN connections that you attach to a transit gateway are associated with the default transit gateway route table.

- **associations** — Each attachment is associated with exactly one route table. Each route table can be associated with zero to many attachments.

- **route propagation** — A VPC or VPN connection can dynamically propagate routes to a transit gateway route table. With a VPC, you must create static routes to send traffic to the transit gateway. With a VPN connection, routes are propagated from the transit gateway to your on-premises router using Border Gateway Protocol (BGP).
