---
title: "Verify DNS"
chapter: true
weight: 40
---

# Verify DNS communication

1. In the AWS Management Console choose **Services** then select **Systems Manager**.

1. From the menu on the left, Scroll down and select **Session Manager**. Session Manager allows us to use IAM role and policies to determine who has console access without having to manage ssh keys for our instances.

1. In the main pane, click the **Start session** button. Pick The Datacenter Instance to shell into. You will now enter a bash shell prompt for that instance.

1. Let Ping np1.aws._your_domain_name_. Every one second or so, you should see a new line showing the reply and roundtrip time.

![DNS DC to DCS](../images/dns-dc1tonp1.png)

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

1. Since we dont allow pings the other way, lets test by using **Session Manager** to shell to NP1, and using dig to lookup a name provided by the Bind server in the Datacenter (test._your_domain_name_). It should return the private ip address of the Bind Server.

![DNS NP1 to DC](../images/dns-np1todc.png)

```
sh-4.2$ dig test.kneetoe.com

; <<>> DiG 9.9.4-RedHat-9.9.4-61.amzn2.0.1 <<>> test.kneetoe.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 59048
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;test.kneetoe.com.                  IN      A

;; ANSWER SECTION:
test.kneetow.com.           60      IN      A       10.4.12.187

;; Query time: 5 msec
;; SERVER: 10.16.0.2#53(10.16.0.2)
;; WHEN: Fri Feb 01 16:33:27 UTC 2019
;; MSG SIZE  rcvd: 57
```
