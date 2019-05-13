+++
title = "Testing Attachment"
date = 2019-03-24T01:29:10-04:00
weight = 61
chapter = true
+++

# Testing

After creating the attachment on your cross account VPC, it's time to test it out.

**Perform this step on the account that host the VPC NP3**

1. In the AWS Management Console choose **Services** then select **Systems Manager**.

1. From the menu on the left, Scroll down and select **Session Manager**. Session Manager allows us to use IAM role and policies to determine who has console access without having to manage ssh keys for our instances.

1. In the main pane, click the **Start session** button. Pick NP3-<StackName>-server to shell into. You will now enter a bash shell prompt for that instance.

1. Let's ping the **IP address** of NP1 (e.g: 10.16.18.220). Every one second or so, you should see a new line showing the reply and roundtrip time.

```
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
--- 10.16.18.220 ping statistics ---
7 packets transmitted, 7 received, 0% packet loss, time 6042ms
rtt min/avg/max/mdev = 0.673/0.824/1.096/0.130 ms
```

Great! It's working, can we reach our simulated the datacenter?

1. Let's ping the IP for DC1-<StackName>-Server. Every one second or so, you should see a new line showing the reply and roundtrip time.

```
sh-4.2$ ping 10.4.22.62
PING 10.4.22.62 (10.4.22.62) 56(84) bytes of data.
64 bytes from 10.4.22.62: icmp_seq=1 ttl=254 time=1.09 ms
64 bytes from 10.4.22.62: icmp_seq=2 ttl=254 time=0.763 ms
64 bytes from 10.4.22.62: icmp_seq=3 ttl=254 time=0.807 ms
64 bytes from 10.4.22.62: icmp_seq=4 ttl=254 time=0.891 ms
64 bytes from 10.4.22.62: icmp_seq=5 ttl=254 time=0.736 ms
64 bytes from 10.4.22.62: icmp_seq=6 ttl=254 time=0.673 ms
64 bytes from 10.4.22.62: icmp_seq=7 ttl=254 time=0.806 ms
^C
--- 10.4.22.62 ping statistics ---
7 packets transmitted, 7 received, 0% packet loss, time 6042ms
rtt min/avg/max/mdev = 0.673/0.824/1.096/0.130 ms
```

Great! Now let's the if our custom DNS and our on-premisse DNS name resolution works:

1. Let's ping np1.aws._your_domain_name_. Doesn't look like it's resolving, can you figure out why?

 <details>
   <summary>SPOLIER Fixing Mysterious DNS resolution issue</summary><p>

      While we do have a route between the NP3 and our simulated Datacenter, NP3 VPC does not know where to resolve names for our custom DNS name. We have shared the resolver with this account but never associated with the VPC. Go to Route 53 Resolvers -> Rules and associate dccorpdomain with NP3 VPC.

1. Let's ping np1.aws._your_domain_name_. Every one second or so, you should see a new line showing the reply and roundtrip time.

```
sh-4.2$ ping np1.aws.kneetoe.com
PING 10.16.18.220 (10.16.18.220) 56(84) bytes of data.
64 bytes from 10.16.18.220: icmp_seq=1 ttl=254 time=1.09 ms
64 bytes from 10.16.18.220: icmp_seq=2 ttl=254 time=0.763 ms
64 bytes from 10.16.18.220: icmp_seq=3 ttl=254 time=0.807 ms
64 bytes from 10.16.18.220: icmp_seq=4 ttl=254 time=0.891 ms
64 bytes from 10.16.18.220: icmp_seq=5 ttl=254 time=0.736 ms
64 bytes from 10.16.18.220: icmp_seq=6 ttl=254 time=0.673 ms
64 bytes from 10.16.18.220: icmp_seq=7 ttl=254 time=0.806 ms
^C
--- 10.16.18.220 ping statistics ---
7 packets transmitted, 7 received, 0% packet loss, time 6042ms
rtt min/avg/max/mdev = 0.673/0.824/1.096/0.130 ms
```

1. Now, lets try to ping P1-<StackName>-Server, lets see if we can reach it:

```
sh-4.2$ ping 10.8.16.88
PING 10.8.16.88 (10.8.16.88) 56(84) bytes of data.
^C
--- 10.8.16.88 ping statistics ---
10 packets transmitted, 0 received, 100% packet loss, time 9223ms
```

Just like we wanted. It's not reaching the P1 VPC.

1. Final test, lets see if we can reach the internet, run the following command:

```
sh-4.2$ curl https://ifconfig.co/
3.18.207.101
```

This IP should be the same as returned from an instance in NP1. That means you've reached the internet through the NAT Gateway in the **Data Center Services VPC** on your main account.

## Congratulations

You now have **completed** this section. You managed to share the Transit Gateway with another account and traverse traffic between them, on all environments including our simulated datacenter.
