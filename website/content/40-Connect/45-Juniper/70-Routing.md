+++
title = "Transit Gateway Routing"
chapter = false
weight = 70
+++

## Routing in the VPCs

![Specify Details Screenshot](/images/hybrid-routes-diagram.png)

## Create Routes in the VPC to the Transit Gateway Attachments

While the CloudFormation Template created attachments to the VPCs and route tables for the transit gateway. We need to setup routing within the VPC. What traffic do we want going from each subnet to the Transit Gateway.

1. In the AWS Management Console change to the region you are working in. This is in the upper right hand drop down menu.

1. In the AWS Management Console choose **Services** then select **VPC**.

1. From the menu on the left, Scroll down and select **Route Tables**.

1. You will see the Route Tables listed in the main pane. Lets Start with NP1-_stack_name_-Private route table, Check the box next to it. Let take a look toward the bottom of the panel and click the **Routes** tab. Currently, there is just one route, the local VPC route. Since the only way out is going to be the Transit Gateway, lets make our life simple and point a default route to the Transit Gateway Attachment. Click the **Edit Routes** in the **Routes** tab.

1. On the **Edit routes** page, Click the **Add route** button and enter a default route by setting the destination of **0.0.0.0/0**. In the Target drop-down, select **Transit Gateway** and pick your Transit Gateway create for this project. It should be the only one.
   ![Stack Complete](/images/vpc-defaultroute.png)

1. Repeat the above step for the following route tables:

   - NP2-_stack_name_-Private
   - P1-_stack_name_-Private

1. For the **DCS1-_stack_name_-Public** and **DCS1-_stack_name_-Private** where our NAT Gateway is, we need a special route. We already have a default route pointed at the Internet Gateway(IGW) for the public and to the Nat Gateway(NGW) for the private to get to the internet, so we need a more specific entry to route internally. Lets use the rfc 1918 10.0.0.0/8 CIDR as that can only be internal and allows for future expansion without changes. Follow the steps above for both Route tables. Be sure not to alter the **0.0.0.0/0** route pointed to the IGW org NGW for these route tables.

1. Because the CloudFormation template setup a Security Group to allow ICMP traffic from 10.0.0.0/8, we should now be able to test pings from lots of place.

1. In the AWS Management Console choose **Services** then select **EC2**.

1. From the menu on the left, Scroll down and select **Instances**.

1. In the main pane, select the NP1 EC2 instance from the list and copy its ip address down. You can repeat for other servers (NP2, P1, and DC1) if you want to test connectivity to other VPCs as well. First, we want to test connectivity to the P1 server. Remember, we do not want our non prod instances to be able to reach our production servers or vice-versa.

- You can also get a list of IPs using the AWS CLI which you can run from the Cloud9 Instance. Here's one that extracts out all of them. The 10.16.x.x is the NP1, the 10.8.x.x is the P1 instance.

```
 aws ec2 describe-instances | grep "PrivateIpAddress" | cut -d '"' -f 4 | awk 'NR == 0 || NR % 4 == 0'
```

1. In the AWS Management Console choose **Services** then select **Systems Manager**. Systems Manager Gain Operational Insight and Take Action on AWS Resources. We are going to take a look a just one of seven capabilities of Systems Manager.

1. From the menu on the left, Scroll down and select **Session Manager**. Session Manager allows us to use IAM role and policies to determine who has console access without having to manage ssh keys for our instances.

1. In the main pane, click the **Start session** button. Pick an Instance to shell into. You will now enter a bash shell prompt for that instance.

1. Let Ping a server. Every one second or so, you should see a new line showing the reply and roundtrip time.

```
ping 10.16.18.220
sh-4.2$ ping 10.16.18.220
PING 10.16.18.220 (10.16.18.220) 56(84) bytes of data.
64 bytes from 10.16.18.220: icmp_seq=1 ttl=254 time=1.09 ms
64 bytes from 10.16.18.220: icmp_seq=2 ttl=254 time=0.763 ms
64 bytes from 10.16.18.220: icmp_seq=3 ttl=254 time=0.807 ms
64 bytes from 10.16.18.220: icmp_seq=4 ttl=254 time=0.891 ms
64 bytes from 10.16.18.220: icmp_seq=5 ttl=254 time=0.736 ms
64 bytes from 10.16.18.220: icmp_seq=6 ttl=254 time=0.673 ms
64 bytes from 10.16.18.220: icmp_seq=7 ttl=254 time=0.806 ms
^C
+++ 10.16.18.220 ping statistics +++
7 packets transmitted, 7 received, 0% packet loss, time 6042ms
rtt min/avg/max/mdev = 0.673/0.824/1.096/0.130 ms
```

      Troubleshooting: if you are unable to ping a server here are a few things to check:
      - Go to the EC2 service and reverify the private IP address of the device you want to ping from
      - Go to the       VPC service and verify that you have the 0.0.0.0/0 route point to the TGW for VPCs NP1,NP2, and P1. Verify that you have the 10.0.0.0/8 route in the DCS VPC for both public and private subnets while you are here.
      - Finally, Verify that you went through the check for the TGW route tables propagation and the SRX is receiving routes (see the **VPN Setup Between Datacenter and Transit Gateway** section above)

1. You can also verify Internet access by using the curl command on the NP1, NP2 or P1 (the Datacenter Server wont use the Transit Gateway to get to the internet, but should still work). If you curl https://cloudformation.us-east-1.amazonaws.com it should return healthy.
