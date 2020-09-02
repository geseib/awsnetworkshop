+++
title = "Clean up"
weight = 90
chapter = false
+++

After you have completed the workshop, in order to keep charges to a minimum, always delete resources you no longer need.

1. Before deleting the CloudFormation templates, delete the following resources created during the workshop:
   - Site-to-Site VPNs from the VPC services console
   - Transit Gateway attachment in NP3
   - Endpoint and Endpoint service
   - web.np1.aws.kneetoe.com DNS record to endpoint
   - VPC peering connection
   - RAM share

1. Delete the CloudFormation templates in reverse order:
   - 4.tgw-vpc-cross.yaml
   - 3.tgw-dns.yaml
   - 2.tgw-csr.yaml (be sure you removed the Site-to-Site VPN form the VPC services first or it will fail to remove and you will have to do it again!)
   - 1.tgw-vpcs.yaml (this will also removed the cloud9 stack, no need to manual delete that stack)
