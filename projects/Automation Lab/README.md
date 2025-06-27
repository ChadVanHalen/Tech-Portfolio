<h1>Automation Lab</h1>

<h2>Description</h2>
This project is a sort of culmination of all technology and techniques I've learned so far. Here I establish a SIEM, Wazuh, and a ticketing system, TheHive, on two separate Linux servers. Each have functionality the other has, but intertwining them in this way helps show how supposedly separate technologies can be used in conjunction with one another.<br/>
I then configure a Windows 10 VM to forward Sysmon data the Wazuh SIEM, which I set a rule to look for specific malware I have loaded on the Windows machine.<br/>
Once this rule get tripped, I configure an open source automation/SOAR resource, Shuffler.io, to receive that alert, parse the generated hash from the alert, run the hash through VirusTotal and have the result sent to a ticketing system and my email.<br/>
<br/>
This lab also hopefully demonstrates my tenacity and resourcefulness in troubleshooting when presented with quite a few hurdles.<br/>
Due to amount of different technologies and configurations this one will be a little long.<br/>
<br />


<h2>Utilities Used</h2>
 
- <b>Wazuh</b>
- <b>TheHive</b>
- <b>Shuffler.io</b>
- <b>Sysmon</b>
- <b>Cassandra</b>
- <b>ElasticSearch</b>
- <b>Regex</b>
- <b>Bard AI</b>
- <b>Mimikatz</b>
- <b>ngrok</b>
- <b>PowerShell</b>
- <b>SSH</b>

<h2>Environments Used </h2>

- <b>Ubuntu Server 22.04.1 LTS</b>
- <b>Windows 10</b>

<h2>Project walk-through:</h2>

<p align="center">
First I will show a diagram of the network in which we will setup.<br/>
<img src="https://i.postimg.cc/dtbw8W8g/SOAR-Diagram.png" height="80%" width="80%" alt="SOC Analyst Lab"/><br/>
The Windows 10 Virtual Machine, which has a Wazuh Agent on it, will send Sysmon event data to Wazuh Manager, which is on a separate Linux server.<br/>
Shuffler will request alerts from Wazuh, and pull IOC info from VirusTotal, this example being SHA256 hash info. Shuffler will then create an alert to send to TheHive, and alert the SOC Analyst via email.<br/>
The SOC Analyst would then view the info on TheHive and send the proper response action in response to the alert.<br/><br/>

 
Now to get my environments ready.<br/>
I will be using a Windows 10 VM with Sysmon installed, as well as two headless Ubuntu servers, one running Wazuh, which is acting as my SIEM, and one running TheHive, my ticketing system.<br/>
TheHive also has several child services, Cassandra and ElasticSearch which need to be installed and enabled.<br/>
Once I can reach all services through their web GUI on my host machine and the VM I know I can move on:<br/>
<img src="https://i.postimg.cc/L6BBb2yG/1-Install-Sysmon-on-Windows-10-Pro-VM.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/Wb2Jtrnf/2-Linux-Server-with-Wazuh-Wazuh-web-GUI.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/RZg1vGxR/3-Configuring-services-like-Cassandra-and-Elastic-Search-on-Hive-VM.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/rsTR1tLs/4-After-enabling-all-services-can-confirm-that-The-Hive-is-accessible-in-the-web-GUI-from-host-and-V.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/RhT6XVMR/5-Confirming-Wazuh-is-still-available-on-both-host-and-VM.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Following Wazuh's documentation, I'm able to install Wazuh via PowerShell onto the Windows VM, and am able to see the Windows VM from Wazuh:  <br/>
<img src="https://i.postimg.cc/d07CwYBs/6-Enable-the-Win-VM-to-be-a-Wazuh-agent-start-the-service-and-can-confirm-Wazuh-web-sees-it.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
For the demonstration I will change Wazuh's configuration file on the Windows machine to stop it's current configuration of not passing all info onto Wazuh.<br/>
In normal situations, this is obviously a fairly smart config, but for one machine I want to see as much info from it as possible show up on Wazuh.<br/>
But, before any changes are made, always make a backup to config files. If anything gets messed up I can always reload from the unaltered one: <br/>
<img src="https://i.postimg.cc/7hr0KWSx/7-Win-VM-conf-file-shows-services-automatically-configured-to-NOT-generate-logs-we-will-copy-it-and.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/DwvdVHH0/8-First-making-a-copy-of-the-default-conf-file.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/0Qw7dsMW/9-I-want-to-copy-this-local-application-code-but-make-it-ingest-Sysmon-but-not-sure-where-to-find-w.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
I'll copy the format and syntax of the pre-configured rules, but change them to be how I want them. Pulling the correct name of Sysmon from Event Viewer, I can add it to the config file.<br/>
For ease of use, I'll be getting rid of all other ingest-ibles besides my Sysmon ones, then wait for it to start showing in Wazuh.<br/>
While I wait, I prep my VM for the malware, excluding the downloads folder from Defender, which allows me to run my chosen malware, Mimikatz, without much harassment from Windows: <br/>
<img src="https://i.postimg.cc/0Qw7dsMW/9-I-want-to-copy-this-local-application-code-but-make-it-ingest-Sysmon-but-not-sure-where-to-find-w.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/6QSdv334/10-Through-Event-Viewer-I-can-find-Sysmon-then-in-properties-I-can-see-the-Full-Name-which-is-what-we.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/Dzmr0s2K/11-Sysmon-in-the-config-file.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/prQ84JBK/12-Just-for-ease-of-use-we-got-rid-of-local-app-security-and-system-logs-just-to-lessen-the-amount.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/YCCgDgLm/13-While-waiting-for-sysmon-to-sync-on-wazuh-ill-add-the-VM-downloads-folder-as-an-exclusion-in-Defe.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
I run Mimikatz from PowerShell and... No alert.br/>
This time I check the config of Wazuh, of course backing up the conf file, and see another set of safeguards from "logging all", which I set from no to yes.<br/>
Restarting the Wazuh service I can now see the log files have been generated, which means it should be ready to accept my Sysmon event.<br/>
In the web GUI I set a new index to look for these logs and to also allow all alerts through there. Wazuh has some preconfigured rules, but in case Mimikatz traffic isn't a part of those rules, I will 'allow all' for now until I know what I'm looking for: <br/>
<img src="https://i.postimg.cc/B6H1PBkR/14-Install-and-run-mimikatz-no-hit-from-wazuh-just-have-to-further-tune-it.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/3r2gk3HW/15-Backing-up-conf-file-before-changing-it.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/gkd3R1Ys/16-These-two-log-all-configurations-were-set-to-no-we-will-set-them-to-yes.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/fTKmv5yN/17-Restarting-Wazuh-after-configuring-the-config-we-see-the-two-log-files.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/6pbZk3Cb/18-three-preconfigured-indexes-added-the-archives-one-so-we-can-still-log-everything-even-if-it-itsn.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
While logs are being ingested and syncing in Wazuh I can go directly to the source, the two archives I created on the Wazuh server, to see if the Mimikatz events are being picked up there.<br/>
If I can't find them there, they won't appear on the web GUI. If I do, it just means it needs a little mroe time to sync.<br/>
And after a grep search, -i for no case sensitivity, I can see Mimikatz events in the archive files... And eventually the events start populating in Wazuh:  <br/>
<img src="https://i.postimg.cc/FK2LKBWj/19-While-waiting-for-logs-to-ingest-I-can-directly-check-the-logs-to-see-if-mimikatz-was-picked-up.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/90czR5Gq/20-Confirming-Sysmon-is-picking-up-mimikatz.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/wvX7jTsp/21-Confirming-the-json-log-file-on-the-server-is-picking-up-mimikatz.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/3Jn0GRfr/22-Confirming-Wazuh-dashboard-now-seeing-it.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Now looking at the event I can start looking at metadata I can use to craft a rule. I notice one labelled "originalFileName" which will be useful.<br/>
Sysmon/Wazuh catching this will help prevent an attacker changing malware's name or hash to get past defences. Though, this probably is also able to be side-stepped by an attacker, so having multiple IOCs to catch malware is important:  <br/>
<img src="https://i.postimg.cc/3rjvK9gv/23MAKI-1.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
Wazuh has some pre-crafted rules for Sysmon, including one for PID 1, which is Process Creation. So I'll grab that and tweak it for my use here. These rules can be seen and crafted in both CLI and GUI, but for the demo I'll be using the GUI.<br/>
Copy and paste it into the custom rules file, being sure to perfectly match formatting:  <br/>
<img src="https://i.postimg.cc/nzbXxQr2/24-To-craft-our-rule-Wazuh-has-some-pre-built-rules-you-can-access-via-cli.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/HL7rFtYj/25-They-are-also-available-on-the-GUI.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/5ypy873K/26-Sysmon-rules-come-built-in-especially-for-event-ID-1-which-is-process-creation.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/Z5Q9fQh1/27-Paste-borrowed-rule-into-the-local-rules-file-being-sure-to-match-the-formatting-of-the-pre-exis.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
I'll set the variable I want it to watch out for to be the originalFileName, and then have it look for Mimikatz. Since Mimikatz is a known quantity, I'll replace the severity tags with the Mitre tag for the type of attack it is, T1003.<br/>
I also be sure to name the rule, since it's a custom rule it needs to be over 100000. And since the first pre-configured rule is already 100001, I choose 100002:  <br/>
<img src="https://i.postimg.cc/13XnrQbG/28-Set-rule-ID-and-set-rule-severity-to-highest-for-fun-15-we-want-field-name-to-be-the-original-nam.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/8kb78cSd/28-Set-rule-ID-and-set-rule-severity-to-highest-for-fun-15-we-want-field-name-to-be-the-original-nam.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br />
<br />
I then  make sure there isn't any other Mimikatz coming through since creating the rule, and test my originalFileName rule.<br/>
I rename Mimikatz.exe to NotAVirus and show that, despite the name change, it is still getting caught:  <br/>
<img src="https://i.postimg.cc/Hsxsft3H/29-Confirm-after-rule-set-there-are-no-further-mimikatz-alerts-then-to-prove-the-point-with-the-orig.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/jddLRTxp/30-And-then-we-can-see-our-Mimikatz-rule-is-still-triggered-and-showing-up-on-the-dashboard.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br/>
<br/>
Now that I have a rule set up that is correctly catching malware being detonated on a system, I will set up an automation process through an open source website called Shuffler.io, where I will process the data and send it to TheHive.<br/>
TheHive will then create an alert in a ticketing system for my analyst/SOC team to investigate.<br/>
First step is linking Shuffler with my Wazuh, by adding my Wazuh API into one of these apps.<br/>
However I was running into some errors within Wazuh, the errors pointed to issues reading the conf file I edited earlier, so I went back in to check on it, where I did find some human error.<br/>
Correcting and restarting, I can now see that Mimikatz is executed on my Windows machine, logged by Sysmon, forwarded by Wazuh, and then the rule is caught by Shuffler:  <br/>
<img src="https://i.postimg.cc/C17S2Zqz/31-Setting-up-Shuffle-and-connecting-the-alerts-to-Wazuh-config.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/nL7L3c2D/32ANER-1.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/X7z73yD5/33-Can-confirm-that-running-mimikatz-gets-logged-by-sysmon-which-is-caught-by-a-rule-in-Wazuh-whi.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br/>
<br/>
Another use case within this automation is being able to link caught malware to VirusTotal directly. Though, the SHA info Shuffler shows has 'SHA=' hard-coded onto the hash, which won't get picked up by VirusTotal.<br/>
So before I can send it to VT, I need to strip that off. Which is a function that Shuffler allows, however, it's done through Regex, something I'm not familiar with at all. I can stumble my way through Python, but blind to Regex.<br/>
So, let's see if I can get an LLM to do it. I ask Google Bard if it could get me the Regex of how to remove the SHA= from this string, and it gives me a hit.<br/>
Plugging it into Shuffler, just to make sure it works, and it does! VirusTotal is able to get the hash and provide me with the data I was looking for, including the number of places that label Mimikatz as malicious:  <br/>
<img src="https://i.postimg.cc/TY7hwshp/34-Since-we-are-trying-to-automate-sending-the-hash-to-VT-and-the-hash-has-sha1-we-need-to-parse-th.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/6p8qGhGz/35-Through-regex-we-can-specify-the-hash-field-but-to-parse-out-the-hash-we-need-to-do-some-researc.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/3xzRjDXh/36-Using-LLM-we-can-find-the-code-to-parse-in-regex.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/Kjcvc72P/37-Double-checking-the-LLMs-work-and-see-we-do-get-the-hash-returned-to-us.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/MTSpN23r/39-Success-results-from-VT-part-1.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/qRxvdb9B/39-Success-results-from-VT-part-2-we-can-see-VT-reports-58-sites-label-mimikatz-as-malicious.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br/>
<br/>
So now in the final stretch. I have my machine which is executing malware, and has the Sysmon telemetry being sent to Wazuh. I haze Wazuh interfacing with Shuffler to take the hash of the malware and provide automated info on it.<br/>
Now I just need to send that information to my ticketing system and create an email alert. I start defining the alert with info Shuffler is pulling from the Wazuh event:<br/>
<img src="https://i.postimg.cc/fW5R2PcB/40-Defining-alerts-to-give-me-utc-time-and-a-decription-saying-Mimikatz-detected-on-computer-from-us.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
And that's where my lab completely broke down.<br/>
<br/>
This entire time I was using an entirely on-prem system, 3 VMs. But now, with the introduction of Shuffler.io, an external resource, it took me an unfortunate amount of time to realize why Shuffler was unable to see the private IP of my TheHive machine. It was seriously multiple days after work sitting here frustrated as to why I couldn't get it to work.<br/>
When I finally made my palm to head discovery, I did my best to come up with a solution. On my TheHive VM I installed a service called ngrok which would allow my private IP to be on a public server, which I could then link to on Shuffler! Success!...<br/>
Sort of.<br>:  <br/>
<img src="https://i.postimg.cc/BZhJcK3z/41-Discovering-the-big-mistake-trying-to-work-through-it-downloading-ngrok-and-I-think-I-have-to-sc.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br/>
<br/>
TheHive was "succeeding" in Shuffler, but was unable to process the data and send it to my Hive server, creating an alert on the private GUI. I could see the traffic being picked up in ngrok, but it was giving me an error. And all my Google-Fu was leading me to a very frustrating lack of answers. After being stuck for multiple days, then making a breakthrough, just to immedately be stuck in the same place was really bumming me out.<br/>
I figured there was some...thing... where maybe ngrok wouldn't allow TheHive's Shuffler app to add the directories to it's public IP it was giving me, so I decided to scrap it all and go through the cloud, where I could have a public facing IP.<br/>
After painstakingly getting everything up and running again...<br/><br/>

Same.<br/>
Error.<br/>
So after all that work of getting it running on the cloud, turns out that wasn't even the issue. I start really looking at the error and see the same 3 fields causing the error. Back on the on-prem version I tried leaving these fields blank, putting integers in them, putting strings in them, putting numbers in quotes, in brackets, in {}, etc... Anything to get these errors to resolve. But seeing them here on the cloud version too I went on the warpath.<br/>
I went to TehHive's app in Shuffler, forked it out so I could edit the code, and poked around. After a little poking and prodding I found the code for the 3 fields being errored out, highlighted the code and... Delete.<br/>
<img src="https://i.postimg.cc/C5KSpFGJ/42AFTE-1.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br/>
<br/>
SUCCESS!:  <br/>
<img src="https://i.postimg.cc/YCL2SqJs/43-And-success-the-alert-is-appearing-in-Hive.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br/>
<br/>
The alert automatically appeared in TheHive, including all the data I had Shuffler pull from Wazuh!:  <br/>
<img src="https://i.postimg.cc/25pkLNY8/44-Here-we-can-see-the-data-pulled-from-the-Wazuh-traffic-sent-through-Shuffle-and-output-into-Hive.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<br/>
<br/>
Now the final step. Include a step in the automation where an email is generated with the alert and... Email received.:  <br/>
<img src="https://i.postimg.cc/PxTdKbNg/45-Now-creating-another-node-that-will-generate-an-email-when-mimikatz-is-detected.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
<img src="https://i.postimg.cc/XvwVw1NK/46-Email-success.png" height="80%" width="80%" alt="SOC Analyst Lab"/>
