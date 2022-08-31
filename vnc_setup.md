## Setup VNC in xacchead server:

__Step 0. [init password]__ 

Login your account in xacchead. run ```vncserver```, it will ask you to setup the password.
after setting your vnc's password, kill the vncserver with the following command

```bash
vncserver -list
vncserver -kill :1  # assuming the vnc session is :1
```

Note: the number ":1" should be same with corresponding number that appeared when you start the vncserver

__Step 1. [setup xserver]__ 

Add or change  "~/.vnc/xstartup" into the following code:

```bash
#!/bin/sh
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
vncconfig -iconic &
dbus-launch --exit-with-session gnome-session &
```

This procedure only need to be done once.

__Step 2. [enable port forwarding]__ 

You need to exit current ssh session or connect with a new ssh session. Reconnect xacchead with port forwarding using the following command. 
```bash
ssh -L 5901:localhost:5901 xxxxx@xacchead.d2.comp.nus.edu.sg
```

Note: you should carefully select the port/vnc session, since it will have conflicts with others.
The port number corresponds to your vnc session number.

For example:

* vnc session :1 --> port 5901
* vnc session :12 --> port 5912

In the following example, we assums the vnc session is :1.

__Step 3. [start vncserver]__ 

From the server side, start vncserver:

```bash
vncserver :1
```
__Step 4. [start vncviewer]__ 

From your local machine, start vncviewer. The port is forwarded to your localhost.

##### for linux machine:

Install the vncviewer on your local machine.

```bash
sudo apt install tigervnc-viewer # we suggest the tigervnc viewer.
```

Start vncviewer with localhost (port 5901 in this example) in command line.

```bash
vncviewer 127.0.0.1:5901
```

##### for windows:

Please setup the configuration following your program instructions

##### NOTE:

In case you lock your VNC session, it may be stall in the login screen when you login next time. You can run the following command in your ssh session to unlock your VNC session.


```bash
loginctl  unlock-session  $(loginctl list-sessions | grep ${USER} | awk '{print $1}')
```

