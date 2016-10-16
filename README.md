# minecraft-pe-server
Minecraft Pocket Edition server set-up

This will install everything as the *sudo* user, but will also create a *minecraft* user with limited access to change only minecraft-pe settings, and stop/start minecraft-pe server.

### Pre-requisites
> This has only been tested on Ubuntu 14.04 on AWS  
* A fresh server running Ubuntu 14.04
* Sudo user access.  On AWS this user is **ubuntu**
* If running on AWS, security groups attached to instance allowing incoming access on ports 22 and 19132 (TCP and UDP)  

### Install
* SSH onto server (with *sudo* user)
* install Git (as this is not included in the standard Ubuntu image):
```sh
sudo apt-get -y install git
```
* Clone this repo:
```sh
git clone https://github.com/digitalbear/minecraft-pe-server.git
```
* Go to repo directory
```sh
cd minecraft-pe-server
```
* Run install script (this will prompt you for a password to be assigned to the new minecraft user that will be set-up - enter any non-blank value here):
```sh
./install.sh
```
Assuming no errors then you are ready to do initial configuration.
* Logoff as *sudo* user
```sh
exit
```

### Configure
* Logon to server instance as *minecraft* user (using password provided in install step above)
```sh
ssh minecraft
```
* Change to server directory and start Minecraft PE server
```sh
cd server
./start.sh
```
* Selecting the default for language should be fine - you are reading this in English - just press enter
* Select "y" to accept the licence
* Select "y" to skip the rest of the wizard.  Config settings can be changed later

Server should now be up and running.  However, if you disconnect it will stop, so we need to run as a *service*.  Ctrl-c to cancel operation.
```sh
service minecraftpe start
```

### Stop and start minecraft-pe
Logon as *minecraft* user
* Stop server
```sh
service minecraftpe stop
```
* Start server
```sh
service minecraftpe start
```
* Restart server
```sh
service minecraftpe restart
```

### To do
If running on AWS you may want to set-up an Elastic IP Address for your instance.  Otherwise everytime you stop and start the instance it will be allocated a new IP address.  This could be frustrating for the players if they have to keep inputting a new IP Address everytime they want to play.
