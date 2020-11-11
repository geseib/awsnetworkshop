+++
title = "VPN Setup"
chapter = false
weight = 50
+++

## Setup VPN Between Datacenter and Transit Gateway

Ipsec tunnels can be setup over the internet or over Direct Connect (using a Public Virtual Interface). In this case we are connecting over the public backbone of AWS.
We will create one VPN tunnel from the Transit Gateway and connect it to the Strong Swan Box in the Datacenter.
In a real production environment we would setup a second router for redundancy and for added bandwidth setup multiple tunnels from each Strong Swan (or whichever ipsec device you use). Each ipsec tunnel provides up to 1.25Gbps. This is called Equal cost multipath routing. On the AWS side, up to 50 parallel (ECMP) paths are supported. Many vendors support 4-8 ECMP paths, so check with your vendor)

1. In the AWS Management Console change to the region you are working in. This is in the upper right hand drop down menu.

1. In the AWS Management Console choose **Services** then select **VPC**.

1. From the menu on the left, Scroll down and select **Transit Gateway Attachments**.

1. You will see the VPC Attachments listed, but we want to add one to connect our Datacenter. Click the **Create Transit Gateway Attachment** button above the list.

1. Fill out the **Create Transit Gateway Attachment** form. exactly as below (_note: these choices will match our config of the router on the other side of the VPN tunnels_)

- **Transit Gateway ID** will have a name Tag matching your first CloudFormation Stack name.
- **Attachment Type** is **VPN**
- **Customer Gateway** (CGW) will be **Existing**. _note: the CloudFormation template created the CGW. it is the IP address of our Datacenter VPN device and in the lab matches the EIP of EC2 Instance running the Strong Swan and Quagga._
- Leave **Routing options** set to **Dynamic(requires BGP)**. _note: BGP is required if you want traffic to balance across more than one VPN tunnel at a time (ECMP or Equal Cost Multipathing)_
- For **Inside IP CIDR for Tunnel 1** use **169.254.10.0/30** for CIDR.

- For **Pre-Shared Key for Tunnel 1** use **awsamazon**
- For **Inside IP CIDR for Tunnel 2** use **169.254.11.0/30** for CIDR.
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

1.  Back on the Cloud9 browser tab, using the two VPN tunnel endpoint address generated from the step above (example from Site-to-Site VPN)

    ![VPN tunnel Addresses](/images/vpn-tunneladdresses.png)

    SSH to the Strong Swan and Quagga Box if not already.  The SSH command can be found under the **Exports** tab of the **CloudFormation** template.  Edit the VPN configuration file ipsec.conf.
    
    ```
    sudo nano /etc/strongswan/ipsec.conf
    ```
    To configure the IP Sec tunnel, you need to replace the configuration file place holders.  This is a sample configuration file with the updated place holders. **dc2aws1** is the tunnel with CIDR 169.254.10.0/30 and **dc2aws2** is the tunnel with CIDR 169.254.11.0/30.  The public IP Address for each tunnel and **leftid** must be the EIP assigned to the StrongSwan EC2 instance.  The **right** and **rightid** values for each must be the corresponding **Outside IP Address** of the VPN Connection.
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
    ```
    To save and close the nano editor press Ctrl+X and answer Y.

    _note: AWS generates starter templates to assist with the configuration for the on-prem router. For your real world deployments, you can get a starter template from the console for various devices (Cisco, Juniper, Palo Alto, F5, Checkpoint, etc). Word of Caution is to look closely at the routing policy in the BGP section. you may not want to send a default route out. You likely also want to consider using a route filter to prevent certain routes from being propagated to you._

1.  Start the tunnel and check its status with the following commands. _Note: Strong Swan only will provide the IP Sec tunnels._
    Start Command:
    ```
    sudo strongswan start
    ```
    Command Output:
    ```
    Starting strongSwan 5.7.2 IPsec [starter]...
    ```
    Check Status Command:
    ```
    sudo strongswan status
    ```
    Command Output:
    ```
    Security Associations (2 up, 0 connecting):
         dc2aws2[2]: ESTABLISHED 46 seconds ago, 10.4.3.247[54.204.203.49]...34.198.46.228[34.198.46.228]
         dc2aws2{2}:  INSTALLED, TUNNEL, reqid 1, ESP in UDP SPIs: ce18c0e6_i 0a683749_o
         dc2aws2{2}:   0.0.0.0/0 === 0.0.0.0/0
         dc2aws1[1]: ESTABLISHED 46 seconds ago, 10.4.3.247[54.204.203.49]...23.23.52.79[23.23.52.79]
         dc2aws1{1}:  INSTALLED, TUNNEL, reqid 2, ESP in UDP SPIs: cd7efc23_i 92a5ea51_o
         dc2aws1{1}:   0.0.0.0/0 === 0.0.0.0/0
    ```

1.  Configure Quagga to provide BGP. First start the daemon and then configure BGP.
    ```
    sudo systemctl start bgpd
    sudo vtysh
    conf t
    no router bgp 7675
    router bgp 65001
    network 10.4.0.0/16
    neighbor 169.254.10.1 remote-as 65000
    neighbor 169.254.11.1 remote-as 65000
    end
    wr
    ```
    Command Output:
    ```
    Building Configuration...
    Configuration saved to /etc/quagga/zebra.conf
    Configuration saved to /etc/quagga/bgpd.conf
    [OK]
    ```

1.  Lets make sure we are seeing the routes on the Quagga router. first we can look at what BGP is seeing: **show ip bgp summary**. The most important thing to see is the Prefixes received. If this is in Active or Idle (likely if neighbor statement is wrong: IP address, AS number) there is a configuration issue. What we want to see is a number. In fact if everything is setup correctly we should see 4 for each neighbor.

    ```
    show ip bgp summary
    ```
    Command Output:
    ```
    BGP router identifier 10.4.3.247, local AS number 65001
    RIB entries 9, using 1008 bytes of memory
    Peers 2, using 9120 bytes of memory
    
    Neighbor        V    AS MsgRcvd MsgSent   TblVer  InQ OutQ Up/Down  State/PfxRcd
    169.254.10.1    4 65000      50      52        0    0    0 00:07:53        4
    169.254.11.1    4 65000      50      51        0    0    0 00:07:55        4
    
    Total number of neighbors 2
    ```

1.  We can also see what those routes are and how many paths we have with the **show ip route** command.

    ```
    show ip route
    ```
    Command Ouptut:
    ```
    Codes: K - kernel route, C - connected, S - static, R - RIP,
           O - OSPF, I - IS-IS, B - BGP, A - Babel,
           > - selected route, * - FIB route
    
    K>* 0.0.0.0/0 via 10.4.0.1, eth0
    B>* 10.0.0.0/16 [20/100] via 169.254.11.1, vti2, 00:04:50
    C>* 10.4.0.0/22 is directly connected, eth0
    B>* 10.8.0.0/16 [20/100] via 169.254.11.1, vti2, 00:04:50
    B>* 10.16.0.0/16 [20/100] via 169.254.11.1, vti2, 00:04:50
    B>* 10.17.0.0/16 [20/100] via 169.254.11.1, vti2, 00:04:50
    C>* 127.0.0.0/8 is directly connected, lo
    C>* 169.254.10.0/30 is directly connected, vti1
    C>* 169.254.11.0/30 is directly connected, vti2
    K>* 169.254.169.254/32 is directly connected, eth0
    ```

1.  Notice that there is only one next-hop address for each of the VPCs CIDRs. We can fix this by allow Equal Cost Multipathing (ECMP).
    Back in config mode we will set maximum-paths to 8 in our BGP router:

    ```
    conf t
    router bgp 65001
    maximum-paths  8
    end
    wr
    ```

    Now, run **show  ip route** command again. See, both the tunnels are showing up!

    ```
    show  ip route
    ```
    Command Output:
    ```
    Codes: K - kernel route, C - connected, S - static, R - RIP,
           O - OSPF, I - IS-IS, B - BGP, A - Babel,
           > - selected route, * - FIB route
    
    K>* 0.0.0.0/0 via 10.4.0.1, eth0
    B>* 10.0.0.0/16 [20/100] via 169.254.11.1, vti2, 00:00:04
      *                      via 169.254.10.1, vti1, 00:00:04
    C>* 10.4.0.0/22 is directly connected, eth0
    B>* 10.8.0.0/16 [20/100] via 169.254.11.1, vti2, 00:00:04
      *                      via 169.254.10.1, vti1, 00:00:04
    B>* 10.16.0.0/16 [20/100] via 169.254.11.1, vti2, 00:00:04
      *                       via 169.254.10.1, vti1, 00:00:04
    B>* 10.17.0.0/16 [20/100] via 169.254.11.1, vti2, 00:00:04
      *                       via 169.254.10.1, vti1, 00:00:04
    C>* 127.0.0.0/8 is directly connected, lo
    C>* 169.254.10.0/30 is directly connected, vti1
    C>* 169.254.11.0/30 is directly connected, vti2
    K>* 169.254.169.254/32 is directly connected, eth0
    ```


1.  Just to verify where those routes are coming from, we can take a look at the **Green Route Table**. _note: remember, it's under the **VPC** service and **Transit Gateway Route Tables** at the bottom of the left menu._ There should be **5** routes listed. Any ideas why only **4** show up on the Strong Swan?
