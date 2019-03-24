+++
title = "Access the Datacenter Router"
chapter = false
weight = 40
+++

## Access CSR using AWS Cloud9 Environment

In order to access and work on the Datacenter router, we will use AWS Cloud9. Cloud 9 is an IDE platform that is managed as a service for us. We will be using just a fraction of its capability. But this intro should give you some ideas how you can provide a shared environment for managing your Infrastructure as code development.

1. In the AWS Management Console change to the region you are working in. This is in the upper right hand drop down menu.

1. In the AWS Management Console choose **Services** then select **Cloud9**.

1.From **Your Environments** page click the **Open IDE** button on the Workshop Environment Box.
![Cloud 9 Environments](/images/cloud9-environments.png)

1. This will bring up the Cloud9 Console and download the github repo to your working folder.

1. From the **file** menu select **Upload Local Files...** and click **Select files** button, navigate to the key file you created earlier. _note: it should have a .pem extension_. In the Cloud9 console, the file will show up in the left-hand folder list.
   ![Upload file to Cloud9](/images/cloud9-uploadfile.png)

1. In the main panel click the **x** sign next to the **welcome** tab to close this tab.

1. In the main panel click the **+** sign and launch a **New Terminal**. This is a bash shell on the Cloud9 Instance.

1. move the key to the .ssh folder: `mv _key_name_.pem ~/.ssh/`

1. restrict access to the key file: `chmod 400 ~/.ssh/_key_name_.pem`

1.From another browser tab, again navigate to the Management Console and choose **Services** then select **CloudFormation**.

1. From the left-hand menu, select **Exports** in the left hand menu and find the export for ssh to the CSR: DC1-_stack-name_-CSRssh and copy the **Export value**
   ![ssh key and ssh to CSR](/images/cloudformation-csrssh.png)

1. Back on the **Cloud9** Browser tab paste this into the bash shell. _note: in the command you will notice the -i reference to the pem file you just copied, this is the private half of the key pair. The public key is on the Cisco CSR_. Answer **yes** to **Are you sure you want to continue connecting (yes/no)?**

1. You now are connected to the Cisco CSR in the Datacenter VPC. We will be configuring the Cisco CSR.

1. Lets look at the Interfaces by typing a the #prompt: **show ip interface brief** or **sh ip int br** for short. You will see the GigabitEhternet1 which is the interface our ipsec tunnel were traverse.

1. Take a look at the route table on the CSR by typing at the #prompt: **sh ip route**. You will see S\* 0.0.0.0/0 which is a static default route pointing to the 10.4.0.1 address. This is the local VPC router which will connect the Interface to the Internet Gateway and use an Elastic IP address (The Elastic IP will be used as the Customer Gateway IP address when we setup the VPN between the datacenter and the Transit Gateway). The public Elastic IP is a one-to-one mapping to the private 10.4.x.x IP address you just SSHed to.
