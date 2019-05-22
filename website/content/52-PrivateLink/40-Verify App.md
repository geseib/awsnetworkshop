+++
title = "Verify NLB App"
menutitle = "Verify DNS"
chapter = false
weight = 40
+++

## Verify connectivity to the new app
If you deployed to new subnets you will only be able to test in the NP2 VPC. if you used exisiting 

1. In the AWS Management Console choose **Services** then select **Systems Manager**.

1. From the menu on the left, Scroll down and select **Session Manager**. Session Manager allows us to use IAM role and policies to determine who has console access without having to manage ssh keys for our instances.

1. In the main pane, click the **Start session** button. Pick The NP2 Instance to shell into. You will now enter a bash shell prompt for that instance.

1. Let's curl web.np2.aws._your_domain_name_. You should get a response from one of the two instances in the Autoscaling Group which is in the Target Group

```
Welcome to my web server. Server private IP is 10.17.23.165
Availability Zone: us-west-2b
Stack Name: tgw2
your ip is 10.17.18.25
```

![Curl web.np2.aws...](../images/plnp2tonp2flow.png)

## Routing Boundaries

If you chose add new subnets and tested between the NP1 server and the web service host on the NLB, the command will sit for a few seconds and then return no results. Think about what is preventing that from working since if you tested pings earlier from NP1 Server to NP2 Server that worked fine.

 <details>
   <summary>SPOLIER Diving deeper into VPC routing</summary><p>

      If you take a look athe addresses resolved when doing a DIG or looking in the console at the new subents that were created, you should have a pretty good hint.

Is it the Transit Gateway Routes?

1. In the AWS Management Console choose **Services** then select **VPC**.

1. From the menu on the left, Scroll down and select **Transit Gateway Routes Tables**.

1. From the table in the main panel select **Red Route Table**. Let's take a look toward the bottom, and click the **Routes** tab.

1. Take a look at the existing routes and see the 0.0.0.0/0 route that is sending data destined for the Non-prod address to the **Datacenter Services VPC**. 

<details>
  <summary>Is it the Transit Gateway Routes?</summary>

  Partially it is. The 0.0.0.0/0 route would send the traffic to the Datacenter Services VPC and then to the NAT gateway, but after that it would get lost, as 100.64.0.0/10 is not a valid Internet route, and we have no internal route that covers it.
</details>

<details>
  <summary>Is it the Subnet Route Table?</summary>

  Nope, the 0.0.0.0/0 route would send the traffic to the Transit Gateway and thats the direction we want it to go.
</details>

1. In the AWS Management Console choose **Services** then select **Systems Manager**.

1. From the menu on the left, Scroll down and select **Session Manager**. Session Manager allows us to use IAM role and policies to determine who has console access without having to manage ssh keys for our instances.

1. In the main pane, click the **Start session** button. Pick The NP1 Instance to shell into. You will now enter a bash shell prompt for that instance.

1. Let's dig web.np2.aws._your_domain_name_. You should get a response with the IP addresses of the Network Load Balancer.

Request:
```
dig web.np2.aws.seib.com
```

Results:
```
sh-4.2$ dig web.np2.aws.seib.com

; <<>> DiG 9.9.4-RedHat-9.9.4-61.amzn2.1.1 <<>> web.np2.aws.seib.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 37550
;; flags: qr rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;web.np2.aws.seib.com.          IN      A

;; ANSWER SECTION:
web.np2.aws.seib.com.   60      IN      A       100.64.3.101
web.np2.aws.seib.com.   60      IN      A       100.64.4.229
web.np2.aws.seib.com.   60      IN      A       100.64.1.18
web.np2.aws.seib.com.   60      IN      A       100.64.2.246

;; Query time: 2 msec
;; SERVER: 10.16.0.2#53(10.16.0.2)
;; WHEN: Mon May 13 15:14:49 UTC 2019
;; MSG SIZE  rcvd: 113
```


