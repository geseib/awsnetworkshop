+++
title = "Clean up"
weight = 90
chapter = true
+++

# Clean up

After you have completed the workshop, in order to keep charges to a minimum, always delete resources you no longer need.

1. Before deleting the CloudFormation templates, Delete the Site-to-Site VPN from the VPC services console.

1. Delete the CloudFormation templates in reverse order:
   - 4.tgw-vpc-cross.yaml
   - 3.tgw-dns.yaml
   - 2.tgw-csr.yaml (be sure you removed the Site-to-Site VPN form the VPC services first or it will fail to remove and you will have to do it again!)
   - 1.tgw-vpcs.yaml (this will also removed the cloud9 stack, no need to manual delete that stack)
