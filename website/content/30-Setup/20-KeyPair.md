+++
title = "Create KeyPair"
chapter = false
weight = 20
+++

## Getting Started and Deleting Default VPC

For our simulated Datacenter Router we will need to use a SSH key pair for secure access. When you create a key pair in AWS, the public key is stored in your account in the region in which you create it. The private key is immediately downloadable; in fact, this is the only time the private key will be available, so download it and store it safely, as you won't get another chance.

### Create Key Pair in AWS Console

1. In the AWS Management Console, change to the region you wish to work in. This is in the upper right-hand drop-down menu.

1. In the AWS Management Console choose **Services** then select **EC2**.

1. From the left-hand menu select **Key Pairs**. _It's half way down, in the **Network & Security** section._

1. Click **Create Key Pair** in the main panel and give your new key a name. Click **Create**.

1. Save the private key to your local machine for easy access later. _note: we will need this key to access the Cisco CSR router that is in our Simulated Datacenter VPC_.
