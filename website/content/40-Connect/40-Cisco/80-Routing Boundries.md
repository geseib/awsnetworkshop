+++
title = "Routing Boundries"
chapter = false
weight = 80
+++

## Routing Boundaries

If you tested between the P1 server and a NP1 or NP2 server, you should have also seen a reply ping. But that's **not** what we wanted. Look at the VPC route table and the Associated Transit Gateway Route table (_for P1 this should be Blue, for NP1 or NP2 this should be Red_) Follow the logic to understand what's going on. See if you can figure out what is causing the issue, before looking below to solve it.

 <details>
   <summary>SPOLIER Fixing Mysterious Prod to Non-Prod routing</summary><p>

      While we do not have a direct route between the Production and Non-Production VPCs we do have a gateway through the NAT Gateway in the **Datacenter Services VPC**. Let's fix this through a routing mechanism called Blackhole routing (sometimes referred to as null routing).
      This is where designing our IP address space pays off. We can now use sammary route to easily wall off part of our network.

1. In the AWS Management Console choose **Services** then select **VPC**.

1. From the menu on the left, Scroll down and select **Transit Gateway Routes Tables**.

1. From the table in the main panel select **Blue Route Table**. Let's take a look toward the bottom, and click the **Routes** tab.

1. Take a look at the existing routes and see the 0.0.0.0/0 route that is sending data destined for the Non-prod address to the **Datacenter Services VPC**. Let's prevent that. Click the **Add route** button.

1. At the Create route screen, for the **CIDR** enter **10.16.0.0/13** and check the box next to **Blackhole**. This will drop any traffic destined for the Non-Production VPCs. This is because TGW looks for the most specific route that matches and the /13 is more specific than the /0 route.

   ![Blackhole route](/images/tgw-blackholeroute.png)

1. Go back to Session Manager and connect to the P1 server and re-attempt to ping the NP1 or NP2 servers. Pings should fail now.

1. be sure to repeat the blackhole route in the **Red Route Table** by creating a blackhole route for 10.8.0.0/13.

## Congratulations

You now have **completed** this section. Continue to the next section, to setup DNS between your Datacenter and the Cloud.
