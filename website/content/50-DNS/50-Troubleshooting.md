+++
menutitle = "Troublshooting DNS"
chapter = false
weight = 50
+++

## Troubleshooting DNS

If you are not able to successfully use **dig** and **ping** using the DNS names, make sure you completed all of the routing changes in the previous module.

### DCS1 Private Subnet Routing Problem

If you did not add a 10.0.0.0/8 route to the TGW for the DCS1 Private subnet, Route53 Resolver Endpoints will return traffic through the NAT gateway instead of directly back. Since the requester did not also go through the NAT gateway traffic will be dropped by the requesting host without looking at the response. You can see that here:
`dig np1.aws.farout.com @10.0.8.11 ;; reply from unexpected source: 10.0.2.48#60358, expected 10.0.8.11#53`

### Bind Server

If you want to see what requests are passing through the bind server, you can monitor the log messages. First turn on query logging and then tail the the log messages file.

```
# sudo rndc querylog

# sudo tail -f /var/log/messages
```

Now, leave that session up in a browser tab. From another tab, use session manager to have the DC1 Server attempt to ping np1.aws._your_domain_name_ and check back at this screen

```
eb  7 11:30:50 ip-10-4-15-234 named[3689]: client 10.4.14.53#42094 (np1.aws.farout.com): query: np1.aws.farout.com IN A +ED (10.4.15.234)
```

### Next Steps

You now have **completed** this section. Continue to the next section to connect in another AWS account to our Transit Gateway.
