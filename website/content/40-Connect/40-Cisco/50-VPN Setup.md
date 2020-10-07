+++
title = "VPN Setup"
chapter = false
weight = 50
+++

## Setup VPN Between Datacenter and Transit Gateway

Ipsec tunnels can be setup over the internet or over Direct Connect (using a Public Virtual Interface). In this case we are connecting over the public backbone of AWS.
We will create two VPN tunnels from the Transit Gateway and connect them into a single instance of the Cisco CSR in the Datacenter.
In a real production environment we would setup a second router for redundancy and for added bandwidth setup multiple tunnels from each Cisco CSR (or whichever ipsec device you use). Each ipsec tunnel provides up to 1.25Gbps. This is called Equal cost multipath routing. On the AWS side, up to 50 parallel (ECMP) paths are supported. Many vendors support 4-8 ECMP paths, so check with your vendor)

1. In the AWS Management Console change to the region you are working in. This is in the upper right hand drop down menu.

1. In the AWS Management Console choose **Services** then select **VPC**.

1. From the menu on the left, Scroll down and select **Transit Gateway Attachments**.

1. You will see the VPC Attachments listed, but we want to add one to connect our Datacenter. Click the **Create Transit Gateway Attachment** button above the list.

1. Fill out the **Create Transit Gateway Attachment** form. exactly as below (_note: these choices will match our config of the router on the other side of the VPN tunnels_)

- **Transit Gateway ID** will have a name Tag matching your first CloudFormation Stack name.
- **Attachment Type** is **VPN**
- **Customer Gateway** (CGW) will be **Existing**. _note: the CloudFormation template created the CGW. it is the IP address of our Datacenter VPN device and in the lab matches the EIP of EC2 Instance running the Cisco CSR._
- Leave **Routing options** set to **Dynamic(requires BGP)**. _note: BGP is required if you want traffic to balance across more than one VPN tunnel at a time (ECMP or Equal Cost Multipathing)_
- For **Inside IP CIDR for Tunnel 1** use **169.254.10.0/30** for CIDR.

- For **Pre-Shared Key for Tunnel 1** use **awsamazon**
- For **Inside IP CIDR for Tunnel 2** use **169.254.11.0/30**for CIDR.
- For **Pre-Shared Key for Tunnel 2** use **awsamazon**
- Once the page is filled out, click **Create attachment** at the bottom right.
  ![Create VPN Attachment](/images/tgw-createvpnattach.png)

1.  While we are on the **Transit Gateway Attachments** page, lets go back to the top and give the VPN connection a name. Scan down the **Resource type** column for the VPN Attachment. \*note: you may have to hit the refresh icon in the upper right above the table to get the new VPN to show. If you click the pencil that appears when you mouse over the **Name** column, you can enter a name. Be sure to click the _check_ mark to save the name.

1.  From the Menu on the Left Select **Site-to-Site VPN Connections**. From the main panel, you likely will see the VPN is in State **pending**. That fine. Lets take a look toward the bottom, and click the **Tunnel Details** tab. Record the two **Outside IP Address**es. We want to record them in the order of the one pairing up with the **Inside IP CIDR** range 169.254.**10**.0/30 first. _note: You can use cloud9 as a scratch pad, by clicking the + in the main panel and selecting **New file**. be sure to paste them in the right order!_

1.  From the menu on the left, Scroll down and select **Transit Gateway Attachments**. We need to verify that the attachment we created above is no longer in status **pending**. Instead it should be is state **available** like all of the VPC attachments in the list.

    ![VPN Attachment Available](/images/vpn-available.png)

1.  From the Menu on the Left Select **Transit Gateway Route Tables**. From the table in the main panel select **Green Route Table**. Lets take a look toward the bottom, and click the **Associations** tab. Associations mean that traffic coming from the outside toward the Transit gateway will use this route table to know where the packet will go after routing through the TGW. _note: An attachment can only be Associated with one route table. But a route table can have multiple associations_. Here in the **Green Route Table**, We already have one association, The **Datacenter Services VPC**. Click **Create associations** in the **Associations** tab. From the drop-down list, select the vpn. _note:it should be the only one in the list without a **Association route table** ._ Click **Create association**.
    ![Associate VPN](/images/tgw-vpnassocationspending.png)

1.  While at the **Transit Gateway Route Tables**, take a look at the **Propagations** tab. These are the Resources that Dynamically inform the route table. An attachment can propagate to multiple route tables. For the Datacenter, we want to propagate to all of the route tables so the VPC associated with each route table can route back to the datacenter. Lets start with the **Green Route Table**. We can see all of the VPCs are propagating their CIDR to the route table. Since the **Datacenter Services VPC** is also associated with this route table, we need to propagate the VPN routes to the **Green Route Table**.

1.  Click in **Create Propagation** on the field “chose attachment to propagate”, select the attachment of the VPN (previously named by you) and click in **Create propagation**.

1.  Repeat the above step on the propagations tab for the **Red Route Table** and the **Blue Route Table**.

1.  Take a look at each of the route tables and notice the tab **Routes**. You can see the routes that are propagated, as well as a static route table that was created for you by the CloudFormation template. That's the default route (0.0.0.0/0) that will direct traffic destined for the internet to the **Datacenter Services VPC** and ultimately through the NAT Gateway in that VPC. _note: there is also a route table with no name. This is the default route table. In this lab we do not intend to use the default route table_.

1.  Back on the Cloud9 browser tab, using the two VPN tunnel endpoint address generated from the step above, cd to tgwwalk on the Cloud9 bash console and run the bash script, ./createcsr.sh. _note: Be sure to put the address that lines up with Inside IP CIDR address 169.254.10.0/30 for ip1_.
    Example from Site-to-Site VPN
    ![VPN tunnel Addresses](/images/vpn-tunneladdresses.png)

    ```
    cd tgwwalk
    ##./createcsr.sh ip1 ip2 outputfile
    ./createcsr.sh 35.166.118.167 52.36.14.223 mycsrconfig.txt
    ```

    _note: AWS generates starter templates to assist with the configuration for the on-prem router. For your real world deployments, you can get a starter template from the console for various devices (Cisco, Juniper, Palo Alto, F5, Checkpoint, etc). Word of Caution is to look closely at the routing policy in the BGP section. you may not want to send a default route out. You likely also want to consider using a route filter to prevent certain routes from being propagated to you._

1.  On the left hand panel, the output file should be listed. You may have to open the tgwwalk folder to see the txt file. Select all text (ctrl-a on pc/command-a on mac). Then copy the text to buffer (Select andy copy all text (ctrl-a and then ctrl-c on pc/command-a and then command-c on mac))

1.  using a bash tab in cloud9, ssh back into the CSR. note: the **ssh** command for the CSR is given for you from the **Exports** menu in **CloudFormation**.

1.  enter configuration mode by entering **config t**, which will take you to a config prompt

    ```
    ip-10-4-0-17#conf t
    Enter configuration commands, one per line.  End with CNTL/Z.
    ip-10-4-0-17(config)#
    ```

1.  Once in Configuration mode _note: you should see (config)# prompt_, paste all text (ctrl-v on pc/command-v on mac) from the outputfile created in step 4. This will slowly paste into the configuration.

1.  Once, the paste is finished, if you are still at the (config)# or (config-router) prompt, type **end** and press enter.

1.  Now lets look at the new interfaces: **sh ip int br**. You should see new interfaces: Tunnel1 and Tunnel2 and they both should show up. \*note: if they do not change from down to up after a minute, likely cause is the ip addresses were flipped in the createcsr script.
    ![ssh key and ssh to CSR](/images/csr-showtunnel.png)

1.  Lets make sure we are seeing the routes on the Cisco CSR. first we can look at what BGP is seeing: **show ip bgp summary**. The most important thing to see is the State/PfxRcd (Prefixes received). If this is in Active or Idle (likely if neighbor statement is wrong: IP address, AS number) there is a configuration issue. What we want to see is a number. In fact if everything is setup correctly we should see 4 for each neighbor.

    ```
    ip-10-4-0-17#sh ip bgp summ
    BGP router identifier 169.254.10.2, local AS number 65001
    BGP table version is 6, main routing table version 6
    5 network entries using 1240 bytes of memory
    9 path entries using 1224 bytes of memory
    2/2 BGP path/bestpath attribute entries using 560 bytes of memory
    1 BGP AS-PATH entries using 24 bytes of memory
    0 BGP route-map cache entries using 0 bytes of memory
    0 BGP filter-list cache entries using 0 bytes of memory
    BGP using 3048 total bytes of memory
    BGP activity 5/0 prefixes, 9/0 paths, scan interval 60 secs

    Neighbor        V           AS MsgRcvd MsgSent   TblVer  InQ OutQ Up/Down  State/PfxRcd
    169.254.10.1    4        65000      40      43        6    0    0 00:06:03        4
    169.254.11.1    4        65000      40      44        6    0    0 00:06:04        4
    ip-10-4-0-17#
    ```

1.  We can also see what those routes are and how many paths we have with the **show ip routes** or **sh ip ro** command.

    ```
    ...<output omitted>
    Gateway of last resort is 10.4.0.1 to network 0.0.0.0

    S*    0.0.0.0/0 [1/0] via 10.4.0.1, GigabitEthernet1
          10.0.0.0/8 is variably subnetted, 7 subnets, 3 masks
    B        10.0.0.0/16 [20/100] via 169.254.11.1, 00:00:04
    S        10.4.0.0/16 is directly connected, GigabitEthernet1
    C        10.4.0.0/22 is directly connected, GigabitEthernet1
    L        10.4.0.17/32 is directly connected, GigabitEthernet1
    B        10.8.0.0/16 [20/100] via 169.254.11.1, 00:00:04
    B        10.16.0.0/16 [20/100] via 169.254.11.1, 00:00:04
    B        10.17.0.0/16 [20/100] via 169.254.11.1, 00:00:04
          169.254.0.0/16 is variably subnetted, 4 subnets, 2 masks
    C        169.254.10.0/30 is directly connected, Tunnel1
    L        169.254.10.2/32 is directly connected, Tunnel1
    C        169.254.11.0/30 is directly connected, Tunnel2
    L        169.254.11.2/32 is directly connected, Tunnel2
    ip-10-4-0-17#
    ```

1.  Notice that there is only one next-hop address for each of the VPCs CIDRs. We can fix this by allow Equal Cost Multipathing (ECMP).
    Back in config mode (**config t**) we will set maximum-paths to 8 in our BGP router:

    ```ip-10-4-0-17# config t
      router bgp 65001
      maximum-paths 8
      end
    ```

    Now, run **sh ip ro** command again. See, both the tunnels are showing up!

          ```
          ...<output omitted>
          Gateway of last resort is 10.4.0.1 to network 0.0.0.0

          S*    0.0.0.0/0 [1/0] via 10.4.0.1, GigabitEthernet1
                10.0.0.0/8 is variably subnetted, 7 subnets, 3 masks
          B        10.0.0.0/16 [20/100] via 169.254.11.1, 00:00:13
                            [20/100] via 169.254.10.1, 00:00:13
          S        10.4.0.0/16 is directly connected, GigabitEthernet1
          C        10.4.0.0/22 is directly connected, GigabitEthernet1
          L        10.4.0.17/32 is directly connected, GigabitEthernet1
          B        10.8.0.0/16 [20/100] via 169.254.11.1, 00:00:13
                            [20/100] via 169.254.10.1, 00:00:13
          B        10.16.0.0/16 [20/100] via 169.254.11.1, 00:00:13
                            [20/100] via 169.254.10.1, 00:00:13
          B        10.17.0.0/16 [20/100] via 169.254.11.1, 00:00:13
                            [20/100] via 169.254.10.1, 00:00:13
                169.254.0.0/16 is variably subnetted, 4 subnets, 2 masks
          C        169.254.10.0/30 is directly connected, Tunnel1
          L        169.254.10.2/32 is directly connected, Tunnel1
          C        169.254.11.0/30 is directly connected, Tunnel2
          L        169.254.11.2/32 is directly connected, Tunnel2
          ip-10-4-0-17#
          ```

1.  Just to verify where those routes are coming from, we can take a look at the **Green Route Table**. _note: remember, it's under the **VPC** service and **Transit Gateway Route Tables** at the bottom of the left menu._ There should be **5** routes listed. Any ideas why only **4** show up on the CSR?
