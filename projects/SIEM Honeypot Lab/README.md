<h1>Azure Honeypot Lab</h1>

<h2>Description</h2>
This project consists of getting hands-on experience on the creation of logs from a purposefully insecure virtual machine, feeding the logs into a SIEM, seeing the results, mapping the results, then showing that the attempts stop when the VM is secured.<br/>
<br />


<h2>Utilities Used</h2>
 
- <b>Azure</b>
- <b>PowerShell ISE</b>
- <b>RDP</b>
- <b>IPGeoLocator.io</b>

<h2>Environments Used </h2>

- <b>Windows 10</b> (22H2)

<h2>Project walk-through:</h2>

<p align="center">
I created a VM within a free trial of Azure, removing all firewall security features it had preloaded: <br/>
<img src="https://i.postimg.cc/hvB6jnXS/1-Create-honeypot-VM-remove-firewall-to-allow-any.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Here I make a few purposeful failed attempts to RDP into the VM from my host computer, and check the Event Viewer to compare a success and failure:  <br/>
<img src="https://i.postimg.cc/9Qnk9ZDg/2-Fail-login-on-VM.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/NMwp84BD/3-Audit-Failure-VM-Event-Viewer.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
In the Event Viewer I can also see info on the failed attempt, like the IP of where it came from and what credentials they attempted to login with: <br/>
<img src="https://i.postimg.cc/3J2fPGkL/4ffuoh21.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
From my host machine, despite turning firewall off on the Azure level, still unable to ping the VM. So I went and turned the firewall off within the VM itself, which then allowed my host machine to ping the VM, confirming the VM was open to the internet:<br/>
<img src="https://i.postimg.cc/xj5tHM7G/5-Ping-VM-fail.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/K86NFNkb/6-Ping-VM-success-after-firewall-disable.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Next I used the following code which was specifically based on the API of IPGeoLocation.io to pull the failed login attempts, pull the IP found in the event, run the IP through the website to get the latitude and longitude location of the login attempt. This then outputs into a .log file: <br/>
 https://github.com/joshmadakor1/Sentinel-Lab/blob/main/Custom_Security_Log_Exporter.ps1<br/>
<img src="https://i.postimg.cc/XYG8Thvx/7-Power-Shell-ISE-Log-Exporter-Script.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Here we can see the previous attempts have been pulled and the IP was converted into a physical location. I then show this output also appearing in the log file:  <br/>
<img src="https://i.postimg.cc/gJq4gZ0W/8-Running-script-confirm-log-output.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
 <img src="https://i.postimg.cc/DfPYgtWX/9-Log-data-with-sample-data-my-failed-login.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
I then use my VPN to change my location ot Belgium and attempt another failed login to see if the location in the log matches as well.<br/>It successfully tracks the attempt being from Belgium:  <br/>
<img src="https://i.postimg.cc/zvx7rYW2/10-Failed-login-from-Belgium.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/W3jwq1wf/11-Log-of-failed-Belgium-login.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
In Azure Sentinel, Azure's SIEM, I point it at my newly created failed login log, then seeing it as available for query within Azure:  <br/>
<img src="https://i.postimg.cc/C5h7XxZf/12-Create-custom-log-copy-paste-from-VM-to-host-machine.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/6QVdKNxV/13-Custom-log-appearing-in-LAW.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
While the custom log is syncing, I can query the SecurityEvents to see my failed attempts:   <br/>
<img src="https://i.postimg.cc/YqVNf3xF/14-While-custom-log-is-being-synced-the-regular-event-logs-from-VM-are-viewable.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Here I'm putting code to pull the string data, splitting into data like latitude, longitude, country, etc to output onto my map. At the same time I'm removing the "sample" examples from the log:<br/>
<img src="https://i.postimg.cc/SRxLV156/15-Custom-log-synced-and-outputting-data-from-log-into-Sentinel-SIEM-removing-sample-examples.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br/>
<br/>
Here is the result of pulling that data and outputting it to my map, my failed attempts from my home computer in Utah, and the VPN attempt in Belgium. Unfortunately my PowerShell code in the VM had a bit of a hiccup so the log got a little messed up, but after fixing the code and re-connecting the IP/Location API, I went to make dinner while I waited to see if I got any bites:<br/>
<img src="https://i.postimg.cc/QCz7m8cD/16-Mapping-my-2-failed-logins.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/FFTV1mdD/17-World-map-issues-with-code-and-log-some-inaccurate-queries-now-wait-to-see-if-any-attempts-are.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
After less than 90 minutes of making, eating then cleaning dinner, I came back to almost 2,000 attempts from Russia. I wasn't sure of exactly how many I was expecting when I came back, but this was a lot more than I had imagined:<br/>
<img src="https://i.postimg.cc/zGgCdgdc/18-Number-of-attempts-at-my-honeypot-after-90-minutes.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
The following are snapshots of the Russian login attempts, you can see they were brute forcing passwords using common login credentials like Administrator, admin, guest, etc:<br/>
According to https://www.reddit.com/r/codes/comments/yy0wha/encoded_russian_default_usernames_i_cant_figure/ the non-Latin characters being tested on the VM were Codepage 1251, which is how Cyrillic is displayed on Windows systems. Decoding the characters into Cyrillic and then into English shows login attempts like "administrators", "guest", etc<br/>
<img src="https://i.postimg.cc/K8BT7yjX/19-Russian-attempts-admin-Administrator.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/CK0qm6nR/20-More-login-attempts.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/Tw752d7b/21-More-login-attempts.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/qqNhzPS5/22-More-login-attempts.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br/>
<br/>
At this point my map was failing due to reaching my free trial limitation on the IP location API, would have been interesting to see how many different locations would have tried to brute force into my VM, but I had to call it here.<br/>
It was still logging attempts, but just unable to convert the IP to locations.<br/>
In my VM I re-enabled all the firewall settings I previously disabled, and nearing 7pm I catch this final login attempt. After re-enabling the firewall there were no more RDP attempts.:<br/>
<img src="https://i.postimg.cc/XNPBTvyS/23-View-of-my-last-log-before-re-configuring-firewall.png" height="80%" width="80%" alt="SOC Analyst Lab"/>



<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
