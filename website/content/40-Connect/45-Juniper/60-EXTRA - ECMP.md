+++
title = "EXTRA- ECMP"
chapter = false
weight = 60
+++

## Extra: Create 2 more Equal Cost Paths to the Datacenter

Bandwidth scaling and High Availability are built into the Transit Gateway inherently as well via the multiple Availability ZOne (AZ) attachments to our VPCs. However; for connectivity back to our Datacenter, we have some things to consider. In the real world, we would create another customer gateway on a totally separate physical device. Ideally this is physically as fault-isolated from the first Customer Gateway as we can make it (think, in across the room or even in another communications room. With separate connectivity and power if we have it). But in order to distribute load across both Customer gateways from the datacenter, you typically would use another tier of routers (shown below via a core router) to balance the traffic. For our demo purposes, lets build it on the same CSR we have in our simulated Datacenter so we can see ECMP in action.

![ECMP on VPNs](/images/vpn-ecmp.png)

## Creating Four Equal Cost paths between our VPCs and the Datacenter

1. In the AWS Management Console change to the region you are working in. This is in the upper right hand drop down menu.

1. In the AWS Management Console choose **Services** then select **VPC**.

1. From the menu on the left, Scroll down and select **Transit Gateway Attachments**.

1. You will see the VPC Attachments listed, but we want to add one to connect our Datacenter. Click the **Create Transit Gateway Attachment** button above the list.

1. Fill out the **Create Transit Gateway Attachment** form.

- **Transit Gateway ID** will have a name Tag matching your first CloudFormation Stack name.
- **Attachment Type** is **VPN**
- **Customer Gateway** (CGW) will be **Existing**. _note: the CloudFormation template created the CGW. it is the same IP address used in the previous VPN._
- Leave **Routing options** set to **Dynamic(requires BGP)**. _note: BGP is required if you want traffic to balance across more than one VPN tunnel at a time (ECMP or Equal Cost Multipathing)_
- For **Inside IP CIDR for Tunnel 1** use **169.254.12.0/30** for CIDR. _Note: we are different addresses from the previous VPN_

- For **Pre-Shared Key for Tunnel 1** use **awsamazon**
- For **Inside IP CIDR for Tunnel 2** use **169.254.13.0/30** for CIDR. _Note: we are different addresses from the previous VPN_
- For **Pre-Shared Key for Tunnel 2** use **awsamazon**
- Once the page is filled out, click **Create attachment** at the bottom right.
  ![Create VPN Attachment](/images/tgw-create2ndvpnattach.png)

1.  While we are on the **Transit Gateway Attachments** page, lets go back to the top and give the VPN connection a name. Scan down the **Resource type** column for the VPN Attachment. \*note: you may have to hit the refresh icon in the upper right above the table to get the new VPN to show. If you click the pencil that appears when you mouse over the **Name** column, you can enter a name that's different than the first VPN. Be sure to click the _check_ mark to save the name.

1.  From the Menu on the Left Select **Site-to-Site VPN Connections**. From the main panel, you likely will see the new VPN is in State **pending**. That fine. Lets take a look toward the bottom, and click the **Tunnel Details** tab. Record the two **Outside IP Address**es. We want to record them in the order of the one pairing up with the **Inside IP CIDR** range 169.254.**12**.0/30 first. _note: You can use cloud9 as a scratch pad, by clicking the + in the main panel and selecting **New file**. be sure to paste them in the right order!_

1.  From the Menu on the Left Select **Transit Gateway Route Tables**. From the table in the main panel select **Green Route Table**. Lets take a look toward the bottom, and click the **Associations** tab. Associations mean that traffic coming from the outside toward the Transit gateway will use this route table to know where the packet will go after routing through the TGW. _note: An attachment can only be Associated with one route table. But a route table can have multiple associations_. Here in the **Green Route Table**, We already have one association, The **Datacenter Services VPC**. Click **Create associations** in the **Associations** tab. From the drop-down list, select the new vpn. _note:it should be the only one in the list without a **Association route table** ._ Click **Create association**.
    ![Associate VPN](/images/tgw-vpnassocationspending.png)

1.  While at the **Transit Gateway Route Tables**, take a look at the **Propagations** tab. These are the Resources that Dynamically inform the route table. An attachment can propagate to multiple route tables. For the Datacenter, we want to propagate to all of the route tables so the VPC associated with each route table can route back to the datacenter. Lets start with the **Green Route Table**. We can see all of the VPCs are propagating their CIDR to the route table. Since the **Datacenter Services VPC** is also associated with this route table, we need to propagate this new second set of VPN routes to the **Green Route Table**.

1.  Repeat the above step on the propagations tab for the **Red Route Table** and the **Blue Route Table** so VPCs associated with these route tables also get four paths to the datacenter.

1.  Take a look at each of the route tables and notice the tab **Routes**. You can see the routes that are propagated, as well as a static route table that was created for you by the CloudFormation template. That's the default route (0.0.0.0/0) that will direct traffic destined for the internet to the **Datacenter Services VPC** and ultimately through the NAT Gateway in that VPC. _note: there is also a route table with no name. This is the default route table. In this lab we do not intend to use the default route table_.

1.  Back on the Cloud9 browser tab, using the two VPN tunnel endpoint address generated from the step above, cd to tgwwalk on the Cloud9 bash console and run the bash script, ./create2ndcsr.sh. _note: THIS is a different Script than above! Also, be sure to put the address that lines up with Inside IP CIDR address 169.254.12.0/30 for ip1_.
    Example from Site-to-Site VPN
    ![VPN tunnel Addresses](/images/vpn-tunneladdresses.png)

    ```
    cd tgwwalk
    ##./create2ndsrx.sh ip1 ip2 outputfile
    ./create2ndsrx.sh 35.166.118.167 52.36.14.223 my2ndsrxconfig.txt
    ```

    _note: AWS generates starter templates to assist with the configuration for the on-prem router. For your real world deployments, you can get a starter template from the console for various devices (Cisco, Juniper, Palo Alto, F5, Checkpoint, etc). Word of Caution is to look closely at the routing policy in the BGP section. you may not want to send a default route out. You likely also want to consider using a route filter to prevent certain routes from being propagated to you._

1.  On the left hand panel, the output file should be listed. You may have to open the tgwwalk folder to see the txt file. Select all text (ctrl-a on pc/command-a on mac). Then copy the text to buffer (Select all text (ctrl-c on pc/command-c on mac))

1.  enter configuration mode, which will take you to a config prompt

    ```
    root% cli
    root> configure
    Enter configuration commands, one per line.  End with CNTL/Z.
    (edit)
    root#
    ```

1.  Once in Configuration mode _note: you should see (config)# prompt_, paste Select all text (ctrl-v on pc/command-v on mac) in the text from the output file created in step 4. This will slowly paste in the configuration file.

1.  At the root# prompt, type **commit** and press enter, type **exit** and press enter.

1.  Now lets look at the new interfaces: **sh int br**. You should see new interfaces: st0.3 and st0.4 and they both should show up. \*note: if they do not change from down to up after a 2 minutes, likely cause is the ip addresses were flipped in the createcsr script.
    ![ssh key and ssh to CSR](/images/csr-showtunnel.png)

1.  Lets make sure we are seeing the routes on the Cisco CSR. first we can look at what BGP is seeing: **show bgp summary**. The most important thing to see is the State/PfxRcd (Prefixes received). If this is in Active or Idle (likely if neighbor statement is wrong: IP address, AS number) there is a configuration issue. What we want to see is a number. In fact if everything is setup correctly we should see 4 for each neighbor.

    ```
     root> show bgp summary
    Groups: 1 Peers: 2 Down peers: 0
    Peer                     AS      InPkt     OutPkt    OutQ   Flaps Last Up/Dwn State|#Active/Received/Accepted/Damped...
    169.254.10.1          65000        374        415       0       0     1:01:54 Establ
    aws.inet.0: 4/4/4/0
    169.254.11.1          65000        373        414       0       0     1:01:51 Establ
    aws.inet.0: 4/4/4/0
    169.254.12.1          65000        374        415       0       0     1:01:54 Establ
    aws.inet.0: 4/4/4/0
    169.254.13.1          65000        373        414       0       0     1:01:51 Establ
    aws.inet.0: 4/4/4/0
    ```

1.  Lets verify Equal Cost Multipathing (ECMP). Making sure we setup ECMP, back in config mode we will add maximum-paths to 8:

    ```
    set routing-instances aws protocols bgp group ebgp multipath
    ```

    Now, run **sh route table aws** command . See, both the tunnels are showing up!

    ```
    + = Active Route, - = Last Active, * = Both

    0.0.0.0/0 _[Static/5] 01:25:10 > to 10.4.0.1 via ge-0/0/1.0
    10.0.0.0/16 _[BGP/170] 01:13:02, MED 100, localpref 100
    AS path: 65000 E, validation-state: unverified > to 169.254.10.1 via st0.1
    to 169.254.11.1 via st0.2
    [BGP/170] 01:12:58, MED 100, localpref 100
    AS path: 65000 E, validation-state: unverified > to 169.254.11.1 via st0.2
    10.4.0.0/16 _[Static/5] 01:25:11 > to 10.4.8.1 via ge-0/0/0.0
    10.4.0.0/22 _[Direct/0] 01:25:10 > via ge-0/0/1.0
    10.4.0.12/32 _[Local/0] 01:25:10
    Local via ge-0/0/1.0
    10.4.8.0/21 _[Direct/0] 01:25:11 > via ge-0/0/0.0
    10.4.8.11/32 _[Local/0] 01:25:11
    Local via ge-0/0/0.0
    10.8.0.0/16 _[BGP/170] 01:13:02, MED 100, localpref 100
    AS path: 65000 E, validation-state: unverified > to 169.254.10.1 via st0.1
    to 169.254.11.1 via st0.2
    [BGP/170] 01:12:58, MED 100, localpref 100
    AS path: 65000 E, validation-state: unverified > to 169.254.11.1 via st0.2
    10.16.0.0/16 _[BGP/170] 01:13:02, MED 100, localpref 100
    AS path: 65000 E, validation-state: unverified > to 169.254.10.1 via st0.1
    to 169.254.11.1 via st0.2
    [BGP/170] 01:12:58, MED 100, localpref 100
    AS path: 65000 E, validation-state: unverified > to 169.254.11.1 via st0.2
    10.17.0.0/16 _[BGP/170] 01:13:02, MED 100, localpref 100
    AS path: 65000 E, validation-state: unverified > to 169.254.10.1 via st0.1
    to 169.254.11.1 via st0.2
    [BGP/170] 01:12:58, MED 100, localpref 100
    AS path: 65000 E, validation-state: unverified > to 169.254.11.1 via st0.2
    169.254.10.0/30 _[Direct/0] 01:25:10 > via st0.1
    169.254.10.2/32 _[Local/0] 01:25:10
    Local via st0.1
    169.254.11.0/30 _[Direct/0] 01:25:10 > via st0.2
    169.254.11.2/32 _[Local/0] 01:25:10
    Local via st0.2

    ```

1.  Just to verify where those routes are coming from, we can take a look at the **Green Route Table**. _note: remember, it's under the **VPC** service and **Transit Gateway Route Tables** at the bottom of the left menu._
