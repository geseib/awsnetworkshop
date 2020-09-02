+++
title = "EXTRA- ECMP"
chapter = false
weight = 60
+++

## Extra: Create 2 more Equal Cost Paths to the Datacenter

Bandwidth scaling and High Availability are built into the Transit Gateway inherently as well via the multiple Availability Zone (AZ) attachments to our VPCs. However; for connectivity back to our Datacenter, we have some things to consider. In the real world, we would create another customer gateway on a totally separate physical device. Ideally this is physically as fault-isolated from the first Customer Gateway as we can make it (think, in across the room or even in another communications room. With separate connectivity and power if we have it). But in order to distribute load across both Customer gateways from the datacenter, you typically would use another tier of routers (shown below via a core router) to balance the traffic. For our demo purposes, lets build it on the same Strong Swan we have in our simulated Datacenter so we can see ECMP in action.

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

1.  Click in **Create Propagation**on the field “chose attachment to propagate”, select the attachment of the VPN (previously named by you) and click in **Create propagation**.

1.  Repeat the above step on the propagations tab for the **Red Route Table** and the **Blue Route Table** so VPCs associated with these route tables also get four paths to the datacenter.

1.  Take a look at each of the route tables and notice the tab **Routes**. You can see the routes that are propagated, as well as a static route table that was created for you by the CloudFormation template. That's the default route (0.0.0.0/0) that will direct traffic destined for the internet to the **Datacenter Services VPC** and ultimately through the NAT Gateway in that VPC. _note: there is also a route table with no name. This is the default route table. In this lab we do not intend to use the default route table_.

1.  Back on the Cloud9 browser tab, using the two VPN tunnel endpoint address generated from the step above, ssh to the Strong Swan and Quagga Box to edit the VPN configuration file:
    Lets add the additional tunnels in the Strong Swan configuration file. Example from Site-to-Site VPN
    ![VPN tunnel Addresses](/images/vpn-tunneladdresses.png)
    ```
    ssh -i ~/.ssh/StrongSwan.pem ec2-user@10.4.3.247
    sudo nano /etc/strongswan/ipsec.conf
    ```
    This is a sample configuration file with the updated place holders. dc2aws1 is the tunnel with CIDR 169.254.10.0/30, dc2aws2 is the tunnel with CIDR 169.254.11.0/30, dc3aws3 is the tunnel with CIDR 169.254.12.0/30, and dc3aws4 is the tunnel with CIDR 169.254.13.0/30, double check the public IP Address for each tunnel and leftid must be the EIP assigned to the StrongSwan EC2 instance.
    ```
    conn %default
      leftauth=psk
      rightauth=psk
      ike=aes128-sha1-modp1024!
      ikelifetime=28800s
      aggressive=no
      esp=aes128-sha1-modp1024!
      type=tunnel
      dpddelay=10s
      dpdtimeout=30s
      keyexchange=ikev1
      rekey=yes
      reauth=no
      dpdaction=restart
      closeaction=restart
      leftsubnet=0.0.0.0/0
      rightsubnet=0.0.0.0/0
      leftupdown=/etc/ipsec-vti.sh
      installpolicy=yes
      compress=no
      mobike=no
    
    conn dc2aws1
      left=10.4.3.247  
      leftid=54.204.203.49
      right=35.166.118.167
      rightid=35.166.118.167
      auto=start
      mark=100
    
    conn dc2aws2
      left=10.4.3.247  
      leftid=54.204.203.49
      right=52.36.14.223
      rightid=52.36.14.223
      auto=start
      mark=200
    
    conn dc2aws3
      left=10.4.3.247
      leftid=54.204.203.49
      right=52.3.204.56
      rightid=52.3.204.56
      auto=start
      mark=300
    
    conn dc2aws4
      left=10.4.3.247
      leftid=54.204.203.49
      right=54.145.177.84
      rightid=54.145.177.84
      auto=start
      mark=400
    ```
    To save and close the nano editor press Ctrl+X and answer Y. **NOTE: Make sure the name of the tunnels are dc2aws3 and dc2aws4.**

    _note: AWS generates starter templates to assist with the configuration for the on-prem router. For your real world deployments, you can get a starter template from the console for various devices (Cisco, Juniper, Palo Alto, F5, Checkpoint, etc). Word of Caution is to look closely at the routing policy in the BGP section. you may not want to send a default route out. You likely also want to consider using a route filter to prevent certain routes from being propagated to you._

1.  Re start the tunnel and check its status with the following commands. _Note: Strong Swan only will provide the IP Sec tunnels._
    ```
    $ sudo strongswan restart
    $ sudo strongswan status
    Security Associations (4 up, 0 connecting):
         dc2aws4[4]: ESTABLISHED 8 seconds ago, 10.4.3.247[54.204.203.49]...54.145.177.84[54.145.177.84]
         dc2aws4{3}:  INSTALLED, TUNNEL, reqid 2, ESP in UDP SPIs: c8ea20a2_i f09118d2_o
         dc2aws4{3}:   0.0.0.0/0 === 0.0.0.0/0
         dc2aws3[3]: ESTABLISHED 8 seconds ago, 10.4.3.247[54.204.203.49]...52.3.204.56[52.3.204.56]
         dc2aws3{4}:  INSTALLED, TUNNEL, reqid 2, ESP in UDP SPIs: c6a5f77b_i 3c1ac9c4_o
         dc2aws3{4}:   0.0.0.0/0 === 0.0.0.0/0
         dc2aws2[2]: ESTABLISHED 8 seconds ago, 10.4.3.247[54.204.203.49]...54.147.3.245[54.147.3.245]
         dc2aws2{2}:  INSTALLED, TUNNEL, reqid 2, ESP in UDP SPIs: c1f0de8e_i 8b7676da_o
         dc2aws2{2}:   0.0.0.0/0 === 0.0.0.0/0
         dc2aws1[1]: ESTABLISHED 8 seconds ago, 10.4.3.247[54.204.203.49]...54.82.116.219[54.82.116.219]
         dc2aws1{1}:  INSTALLED, TUNNEL, reqid 1, ESP in UDP SPIs: cc759fd1_i c82a55e6_o
         dc2aws1{1}:   0.0.0.0/0 === 0.0.0.0/0
    ```

1.  Now enter Quagga configuration terminal and add the new neighbours.
    ```
    $ sudo vtysh
    # conf t
    # router bgp 65001
    # neighbor 169.254.12.1 remote-as 65000
    # neighbor 169.254.13.1 remote-as 65000
    # end
    # wr
    Building Configuration...
    Configuration saved to /etc/quagga/zebra.conf
    Configuration saved to /etc/quagga/bgpd.conf
    [OK]
    ```

1.  Now, run **show  ip route** command again. You should see something like this, notice that 4 tunnels are up!

    ```
    # show  ip route
    Codes: K - kernel route, C - connected, S - static, R - RIP,
           O - OSPF, I - IS-IS, B - BGP, A - Babel,
           > - selected route, * - FIB route
    
    K>* 0.0.0.0/0 via 10.4.0.1, eth0
    B>* 10.0.0.0/16 [20/100] via 169.254.10.1, vti1, 00:01:01
      *                      via 169.254.13.1, vti4, 00:01:01
    C>* 10.4.0.0/22 is directly connected, eth0
    B>* 10.8.0.0/16 [20/100] via 169.254.10.1, vti1, 00:01:01
      *                      via 169.254.13.1, vti4, 00:01:01
    B>* 10.16.0.0/16 [20/100] via 169.254.10.1, vti1, 00:01:01
      *                       via 169.254.13.1, vti4, 00:01:01
    B>* 10.17.0.0/16 [20/100] via 169.254.10.1, vti1, 00:01:01
      *                       via 169.254.13.1, vti4, 00:01:01
    C>* 127.0.0.0/8 is directly connected, lo
    C>* 169.254.10.0/30 is directly connected, vti1
    C>* 169.254.11.0/30 is directly connected, vti2
    C>* 169.254.12.0/30 is directly connected, vti3
    C>* 169.254.13.0/30 is directly connected, vti4
    K>* 169.254.169.254/32 is directly connected, eth0
    ```