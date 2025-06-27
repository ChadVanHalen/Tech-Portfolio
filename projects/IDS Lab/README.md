<h1>IDS Lab</h1>

<h2>Description</h2>
This project consists of getting hands-on experience with a free IDS software Snort.<br/>
I will create a very basic and easy to test first rule, check the installation and initial configurations are working and then confirm that Snort is able to detect the traffic related to the rule.<br/>
Once working, I will implement rules recommended by Snort, and then feed a pcap that contained malware; dissect the signatures and then make it more legible. From there I can research the details I pull from the pcap about the malware and check it against resources like VirusTotal, the MITRE CVE, CISA, etc.
<br />


<h2>Utilities Used</h2>
 
- <b>SSH</b>
- <b>Snort</b>
- <b>Malware-Traffic-Analysis.net</b>

<h2>Environments Used </h2>

- <b>Ubuntu Server</b>

<h2>Project walk-through:</h2>

<p align="center">
First I install Snort 3, with help from the documentation provided by Noah Dietrich. <br/>
After the lengthy installation process I can see Snort shows zero errors with the configuration, and I also check my Ubuntu's internet settings, making note it is using ens33:<br/>
<img src="https://i.postimg.cc/T3gZt8zQ/1-Installing-Snort.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/ZKygqt5Z/2-Snort-config-and-checking-Ubuntu-network-config.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
One of the first steps is to make sure both generic and large receive offload are 'off'<br/>
Using the documentation I know this input in the ethtool service will shut them to off<br/>
And I then confirm they are off:<br/>
<img src="https://i.postimg.cc/nrNP1TT6/3-Checking-receive-offload-needs-to-be-off-for-both-generic-and-large.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/3ry72qxf/4-nano-lib-systemd-system-ethtool-service.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/5tmDMBNC/5-Confirming-offloads-are-now-off.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Here I create a basic alert for ICMP traffic. This allows me to check everything works as planned with a simple configuration first, before expanding into more complex configurations and rules.<br/>
This simple rule is simply saying an alert will be created if there is ICMP traffic from any IP on any port going to any IP on any port, and will display the message "ICMP Detected". The SID needs to be 1000001 because 1-999999 are already reserved by Snort.<br/>
After defining the ICMP rule and running Snort I can verify it runs without configuration errors being triggered:<br/>
<img src="https://i.postimg.cc/QMDvP4sD/6-Creating-a-basic-alert-for-detecting-ICMP-traffic-in-Snort.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/fyVPX17c/7-Configure-Snort-with-ICMP-rule-part-1.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/G2hV34HS/8-Configure-Snort-with-ICMP-rule-part-2.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br/>
<br />
Now I run Snort with it actively looking for the ICMP rule I defined in the last step.<br/>
Though I've run into an error, a quick search informs me that this has to do with user permissions and the DAQ socket needs 'root' permissions.<br/>
Re-starting Snort as root clears the error:<br/>
<img src="https://i.postimg.cc/fWPpZTZB/10-Start-Snort-part-2-pre-ping-DAQ-error.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/Mp2LMPnB/11-Start-Snort-as-root-part-1.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/VkqVjqtV/11-Start-Snort-as-root-part-2-pre-ping-working.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Now, after sending a ping from my host machine to the server's IP, I can see the ICMP ping traffic from my host, and the replies back to the host, being caught: <br/>
<img src="https://i.postimg.cc/13Bbk0zN/12-Snort-catches-pings-from-my-host-machine.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
After this initial success, the next step is to have the rule run without specifically pointing to it like I had to in the last step.<br/>
This involves opening Snort's config file with nano, and change a few of the default options.<br/>
Specifically I'm de-commenting the line of code that enables builtin rules, and then underneath it defining WHICH rules to enable, pointing it to my ICMP rule:<br/>
<img src="https://i.postimg.cc/7Z4k8YMj/13-Opening-Snort-config-file-to-allow-our-ICMP-rules-to-run-without-being-directly-pointed-to.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/9fcN1DtF/14-IPS-config-pre.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/wBF4r905/15-IPS-config-post.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Starting Snort again, this time not defining the ICMP rule specifically during startup, continues to allow me to see the ping traffic between my host computer and the Linux server: <br/>
<img src="https://i.postimg.cc/2669RgKs/16-Start-Snort-again-no-specific-rules.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/fLr2wB4J/17-We-see-the-new-pings.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
 <br />
<br />
The next step to build upon everything so far is to now do what I just did, but for more rules beyond just the simple ICMP rule.<br/>
Luckily Snort has different rules you can access, through their Pulled Pork script.<br/>
I will be using the "Registered Ruleset". Within the Python script I select the ruleset I'm using, enter my API connected with my account on their site, commented out the use of a blocklist, and de-commented a few points, like defining where the Snort executable is, and where the rule path is. I am using my previously created local.rules with my ICMP rule from earlier to keep everything together.
<img src="https://i.postimg.cc/nLRbDKbt/18-Expanding-rules-from-our-basic-ICMP-detection-to-use-pre-defnied-rules-from-Pulled-Pork.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/rz6f4swT/19-Pulled-Pork-ruleset-choice.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/zXnsjYZ7/19-Pulled-Pork-ruleset-choice-added-new-rules-API-commented-out-blocklist-un-commented-rule-file.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Testing my new config... Error.<br/>
Luckily just a quick fix, and one creating the missing directory later:<br/>
<img src="https://i.postimg.cc/s2DCx6Lc/20-No-so-rules-directory-and-fix.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
 <br />
<br />
Testing again... Another error.<br/>
This one is a little weirder, there appears to be a typo of some sort, since the error calls out a rule numbered 31740, but the most recent version is 31470.<br/>
Looking at the Python file I can see where hard-coding the right rule number might be, so I make a copy of the file for safety, then put in the 31470 rule and try again:<br/>
<img src="https://i.postimg.cc/Y2J7Rx4r/21-Another-error-checking-documentation.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/kXKmpt8x/22-I-dont-see-a-rule-labelled-31740-seems-to-be-a-typo-most-recent-rule-is-31470.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/W17P2L5z/23-Found-rules-in-python-file.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/HxrG4Jd8/24-Going-back-and-saving-a-copy-of-the-original-before-we-mess-with-it.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/JnvfT1z6/25-Hard-coding-current-rule-set.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/FHN2CCh4/26-Looks-like-the-edit-solved-the-errors.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br/>
<br/>
Now that that is fixed, I can go back to the earlier config page where I pointed Snort at the ICMP local.rules, and change it to the pulledpork.rules. Confirming, again, no errors when I'm done: <br/>
<img src="https://i.postimg.cc/XNySrysT/27-Go-back-to-Snort-config-and-change-rules-to-pulle-dpork-rules.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/wT8KLTP3/28-Go-back-to-Snort-config-and-change-rules-to-pulle-dpork-rules.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/7hzpdpCx/29-Running-Snort-with-the-new-configurations-confirmed-no-errors.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
  <br />
  <br/>
Now in the final stretch, dealing with malicious network traffic.<br/>
I'm using a pcap downloaded from MalWare-Traffic-Analysis.net and feeding it into my Snort:<br/>
<img src="https://i.postimg.cc/xCJ7NW3K/30-Donwloading-pcap-from-malware-traffic-analysis.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/zDh6zYBN/31-Feeding-the-pcap-into-Snort-gives-a-lot-of-signatures.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Since there are a lot of signatures with this particular pcap, I will be feeding them into a .txt file: <br/>
<img src="https://i.postimg.cc/NfwVLC9H/32-So-we-are-going-to-output-the-signatures-into-a-txr.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
This allows me to have more control over the output. I can get rid of specific portions of the signature using the cut command.<br/>
Here I am specifying that I want to cut everything up to, and including the ] in field 3.<br/>
And then I want to delete everything after, and including the [ in field 1<br/>
It took some trial and error to find the correct field numbers, they did not correlate with the order they appear on the screen, but I eventually got it to look how I was wanting:<br/>
<img src="https://i.postimg.cc/VvXVDnTv/33-Cat-into-the-txt-and-can-edit-the-data-clean-it-up-to-be-a-little-more-legible.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/SsBP6DgH/34-After-making-the-data-more-legible-I-can-sort-it-now-the-most-common-traffic-to-most-rare.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
With the data looking much cleaner I could now combine non-unique instances, then sort the instances by rarity. As you'd probably expect, the signature with the actual malware only happened once, so it was at the end of the list: <br/>
<img src="https://i.postimg.cc/nLwgzHBF/35-Only-one-instance-of-the-malware-Whisper-Gate-in-the-signature.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Now that I know what I was looking for I could go back to the full signatures and grep for the piece of malware, giving me the full signature, including IP. <br/>
I can use this info and do some research, checking the name and associated IP on various platforms like VirusTotal, CVE, CISA, etc.:
<img src="https://i.postimg.cc/FKKwNffC/36-Now-that-we-know-what-we-are-looking-for-we-can-grep-and-look-at-the-full-thing.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/FzhMG6Tf/Virus-Total-IP.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/4dRkHytQ/CISA-Whisper-Gate.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/3RjMXhF5/Trend-Micro-Whisper-Gate.png" height="80%" width="80%" alt="SOC Analyst Lab"/>

<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
