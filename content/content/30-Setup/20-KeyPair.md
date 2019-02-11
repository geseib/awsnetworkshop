---
title: "Create KeyPair"
chapter: true
weight: 20
---

# Getting Started and Deleting Default VPC

For our simulated Datacenter Router we will need to use a SSH keypair to access. When you create a KeyPair in AWS, the public key is stored in your account in the region you create it. The Private key is immediately downloadable. In fact its the only time its available, so download and store it safely.

## Create Key Pair in AWS Console

1. In the AWS Management Console change to the region you are working in. This is in the upper right hand drop down menu.

1. In the AWS Management Console choose **Services** then select **EC2**.

1. From the left-hand menu select **Key Pairs**. _It's half way down, in the **Network & Security** section._

1. Click **Create Key Pair** in the main panel and give your new key a name. Click **Create**.

1. Save the keypair to your local machine for easy access later. _note: we will need this key to access the Cisco CSR router that is in our Simulated Datacenter VPC_.
