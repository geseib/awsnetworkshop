+++
title = "Verify VPC Endpoint DNS Resolution"
menutitle = "Verify VPC Endpoint"
chapter = false
weight = 40
+++

1. In the AWS Management Console choose **Services** then select **Systems Manager**.

1. From the menu on the left, Scroll down and select **Session Manager**. Session Manager allows us to use IAM role and policies to determine who has console access without having to manage ssh keys for our instances.

1. In the main pane, click the **Start session** button. Pick The NP2 Instance to shell into. You will now enter a bash shell prompt for that instance.

1. Lets dig kms._your_region_.amazonaws.com. you should get a response with two 10.0.x.x addresses.

![NP2 to KMS Endpoint](../images/kms-endpoint.png)

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

1. Since we only applied this to the NP2 , lets test by using **Session Manager** to shell to NP1, and using dig to lookup kms._your_region_.amazonaws.com. It should return the public ip address of the KMS API.

![NP1 to KMS Public Endpoint](../images/kms-noendpoint-np1.png)

```

; <<>> DiG 9.9.4-RedHat-9.9.4-61.amzn2.1.1 <<>> kms.us-east-2.amazonaws.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 7263
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;kms.us-east-2.amazonaws.com.   IN      A

;; ANSWER SECTION:
kms.us-east-2.amazonaws.com. 44 IN      A       52.95.18.38

;; Query time: 1 msec
;; SERVER: 10.16.0.2#53(10.16.0.2)
;; WHEN: Thu Mar 14 11:40:34 UTC 2019
;; MSG SIZE  rcvd: 72

sh-4.2$

```
