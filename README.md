# RPMDIFF

create diff patch current config and rpm original config

## Usage

```console
$ ./rpmdiff.sh ${package_name}
```

## Example

```console
$ ./rpmdiff.sh openssh-server
openssh-server-6.6.1p1-23.el7_2.x86_64
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: ftp.iij.ad.jp
 * epel: ftp.riken.jp
 * extras: ftp.iij.ad.jp
 * updates: ftp.iij.ad.jp
Resolving Dependencies
--> Running transaction check
---> Package openssh-server.x86_64 0:6.6.1p1-23.el7_2 will be reinstalled
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================
 Package              Arch         Version                  Repository     Size
================================================================================
Reinstalling:
 openssh-server       x86_64       6.6.1p1-23.el7_2         updates       436 k

Transaction Summary
================================================================================
Reinstall  1 Package

Total download size: 436 k
Installed size: 917 k
Background downloading packages, then exiting:
exiting because "Download Only" specified
--- /etc/ssh/sshd_config
+++ /etc/ssh/sshd_config	2016-02-20 12:37:50.866572704 +0900
@@ -14,13 +14,13 @@
 # SELinux about this change.
 # semanage port -a -t ssh_port_t -p tcp #PORTNUMBER
 #
-#Port 22
+Port 10022
 #AddressFamily any
 #ListenAddress 0.0.0.0
 #ListenAddress ::
 
 # The default requires explicit activation of protocol 1
-#Protocol 2
+Protocol 2
 
 # HostKey for protocol version 1
 #HostKey /etc/ssh/ssh_host_key
@@ -46,13 +46,13 @@
 # Authentication:
 
 #LoginGraceTime 2m
-#PermitRootLogin yes
+PermitRootLogin no
 #StrictModes yes
 #MaxAuthTries 6
 #MaxSessions 10
 
-#RSAAuthentication yes
-#PubkeyAuthentication yes
+RSAAuthentication yes
+PubkeyAuthentication yes
 
 # The default is to check both .ssh/authorized_keys and .ssh/authorized_keys2
 # but this is overridden so installations will only check .ssh/authorized_keys
@@ -76,7 +76,7 @@
 # To disable tunneled clear text passwords, change to no here!
 #PasswordAuthentication yes
 #PermitEmptyPasswords no
-PasswordAuthentication yes
+PasswordAuthentication no
 
 # Change to no to disable s/key passwords
 #ChallengeResponseAuthentication yes
@@ -109,8 +109,8 @@
 # problems.
 UsePAM yes
 
-#AllowAgentForwarding yes
-#AllowTcpForwarding yes
+AllowAgentForwarding yes
+AllowTcpForwarding yes
 #GatewayPorts no
 X11Forwarding yes
 #X11DisplayOffset 10
@@ -123,8 +123,8 @@
 UsePrivilegeSeparation sandbox		# Default for new installations.
 #PermitUserEnvironment no
 #Compression delayed
-#ClientAliveInterval 0
-#ClientAliveCountMax 3
+ClientAliveInterval 30
+ClientAliveCountMax 3
 #ShowPatchLevel no
 #UseDNS yes
 #PidFile /var/run/sshd.pid
$ # We got .patch file !!
$ ls patches/
openssh-server.patch
``` 

## Requires

- yum
- sudo (and sudoer privilege)
- pygmentize(optional)

## TODO

- remove rpm catch file
- bash completion for package names
