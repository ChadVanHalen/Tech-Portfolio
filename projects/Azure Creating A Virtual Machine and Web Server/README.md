<h1>Azure - Creating A Virtual Machine and Web Server</h1>

<h2>Description</h2>
A project in which I demonstrate my ability to perform general tasks within Azure including the creation of resource groups, virtual networks, subnets and virtual machines. As well as utilize Azure resources like Network Security Groups, Bastion and public IPs in order to create a secure, but public facing, web server with a DNS label that I can access from my host machine<br/>
<br />


<h2>Utilities Used</h2>
 
- <b>Azure</b>

<h2>Environments Used </h2>

- <b>Linux Ubuntu 24.02</b>

<h2>Project walk-through:</h2>

<p align="center">
Within my Azure instance I first started by creating a resource group, "RG-USW-Nextcloud": <br/>
<img src="https://i.postimg.cc/sg9hdvNS/01-Create-resource-group.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/QMfKCvsd/02-Creat-resource-group.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Inside of that resource group I create the Virtual Network, "VNET-USE-Nextcloud":  <br/>
<img src="https://i.postimg.cc/Hxjcy3s4/03-Create-Virtual-Network.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
In that Virtual Network I set up the internal private IP and create a basic /16 subnet, I then confirmed it being visible on the main screen: <br/>
<img src="https://i.postimg.cc/mkHPdD9P/04-Set-IP-and-subnet-information-in-virtual-network.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/j59WQNDV/05-Confirmed-virtual-network-is-a-part-of-resource-group.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Next within this resource group was enabling the Network Security Group, Azure has a few rules pre-established that worked for the purpose of this lab project. <br/>
Inbound accepts network only from the virtual network on the load balancer, implicit deny to all other traffic.<br/>
Similarly, outbound traffic is only for the Virtual Network or the Internet, all other traffic is implicit deny: <br/>
<img src="https://i.postimg.cc/J7GdQBTp/06-Create-network-security-group-w-default-rules.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
I then apply these now created rules to the previously created subnet: <br/>
<img src="https://i.postimg.cc/hPmykRRx/07-Add-new-network-security-group-rules-to-virtual-network-subnet.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
To access our VM we will be using Bastion as our jump box, which will allow us to disable SSH from the VM, decreasing its attack surface.  <br/>
Bastion will allow us to access the VM with a private key saved on my host computer: <br/>
<img src="https://i.postimg.cc/mgGXRpTn/09-Create-Azure-Bastion-Subnet.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/GmJMpP2m/10-Create-Bastion-Resource.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/9fmLw4Rt/11-Create-VM-disable-SSH-connection-will-be-through-Bastion.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/HxKzNBSB/12-Connecting-to-VM-via-Bastion-and-private-key.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Within the Linux server VM I install NextCloud, a popular self-hosted file hosting/productivity platform. I set the admin credentials for logging into the portal later, as well as create a self-signed cert:  <br/>
<img src="https://i.postimg.cc/7h29r0dD/13-Installing-Nextcloud-on-Ubuntu.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/J7DPXCng/14-Setting-admin-admin-creds.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/G3WzJgTp/15-Creating-self-signed-cert.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Since this VM is on the cloud, I wont be able to access it from my host computer. So here I am manually assigning a public IP from Azure:  <br/>
<img src="https://i.postimg.cc/yY0jfh0y/16-Associating-VM-with-public-IP.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/sgycbBcd/17-Public-IP-now-associated-with-VM.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
But on my host computer I'm having issues accessing through it's public IP. <br/>
  So I check the security settings of the Virtual Machine and found where I could create an inbound rule.   <br/>
There were a few options, but I kept it to only my host machine's IP being able to connect : <br/>
<img src="https://i.postimg.cc/sgycbBcd/17-Public-IP-now-associated-with-VM.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/HLv9J6Cd/19-Creating-an-inbound-rule-to-allow-my-current-public-IP-address.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
  <img src="https://i.postimg.cc/QtBkccX5/19a-Creating-an-inbound-rule-to-allow-my-current-public-IP-address.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
I can now successfully reach the portal for NextCloud on my host machine:  <br/>
<img src="https://i.postimg.cc/jq74563Y/20-We-can-now-access-Nextcloud-through-its-public-IP.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br/>
<br/>
Lastly I create a DNS label, which allows me to type in a web address vs an IP address. <br/>
  Although Azure's free DNS naming scheme leaves one to think that maybe the IP address is the easier address to type and remeber:  <br/>
<img src="https://i.postimg.cc/nz6K2MzW/21-Creating-a-DNS-record-for-the-Nextcloud.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/VL999fc7/22-Confirming-the-DNS-record-for-the-VM.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Once the DNS label is on the Azure side, I then go back to the server and associate it there as well. <br/>
And look at that, I'm connecting to my virtual cloud server via a domain name on my host machine!  <br/>
<img src="https://i.postimg.cc/Cxmjtc5k/23-Adding-the-DNS-record-to-the-server.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/TwWgKG9J/24-Confirming-the-domain-is-working.png" height="80%" width="80%" alt="SOC Analyst Lab"/>



<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
