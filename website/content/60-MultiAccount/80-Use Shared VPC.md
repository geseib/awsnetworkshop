+++
title = "Use Shared VPC"
chapter = false
weight = 80
+++

## Place an EC2 instance in another AWS account's VPC

We will spin up an EC2 instance in the other Accounts NP2 VPC and test ping their NP1 Server.

<details>
<summary>Launch an EC2 Instance in NP2 VPC</summary></p>
*INCOMPLETE*
1. Launch EC2 instance in the Shared VPC subnet.
2. Use Session manager to access the new server's shell
3. ping np1.aws.*corp_domain_name
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
      +++ 10.16.18.220 ping statistics +++
      7 packets transmitted, 7 received, 0% packet loss, time 6042ms
      rtt min/avg/max/mdev = 0.673/0.824/1.096/0.130 ms
      ```
</p>
</details>

# Congratulations

#### You now have **completed** this Workshop. Feel free to look around at what you have created. When you are finished be sure to clean up the resources that you have created.
