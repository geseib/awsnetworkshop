---
title: "Change VPC Endpoint"
chapter: true
weight: 50
---

# Associate NP1 VPC with the KMS Private Hosted Zone

Currently, the server in NP1 is resolving the public IP address for the KMS API. THis means it will communicate to it through the NAT Gateway and Internet Gateway (IGW) in the Datacenter Services VPC.
Lets change that to use the VPC endpoints with 10.0.x.x addresses in the Datacenter Services VPC.

## Associate NP1 VPC with the Route53 Private Hosted Zone

1. In the AWS Management Console choose **Services** then select **Route53**.

1. In the main panel, click circle to the left of the Domain Name **kms._your_region_.amazonaws.com**

1. In the far right panel, click the text box **VPC ID** and find the NP1 VPC in the list under the region you created your VPCs.

1. Click the bottom-right button, **Associate VPC**

## Verify DNS communication

1. In the AWS Management Console choose **Services** then select **Systems Manager**.

1. From the menu on the left, Scroll down and select **Session Manager**. Session Manager allows us to use IAM role and policies to determine who has console access without having to manage ssh keys for our instances.

1. In the main pane, click the **Start session** button. Pick The NP1 Instance to shell into. You will now enter a bash shell prompt for that instance.

1. Lets dig kms._your_region_.amazonaws.com. you should no longer get the public IP address and instead get a response with two 10.0.x.x addresses.

![NP1 to VPC Endpoint](../images/kms-endpoint-np1.png)

```

sh-4.2$ dig kms.us-east-2.amazonaws.com

; <<>> DiG 9.9.4-RedHat-9.9.4-61.amzn2.1.1 <<>> kms.us-east-2.amazonaws.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 37063
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;kms.us-east-2.amazonaws.com.   IN      A

;; ANSWER SECTION:
kms.us-east-2.amazonaws.com. 60 IN      A       10.0.20.149
kms.us-east-2.amazonaws.com. 60 IN      A       10.0.13.161

;; Query time: 3 msec
;; SERVER: 10.17.0.2#53(10.17.0.2)
;; WHEN: Thu Mar 14 11:26:44 UTC 2019
;; MSG SIZE  rcvd: 88
```
