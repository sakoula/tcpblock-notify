# tcpblock-notify

adds notification center support to [tcpblock](http://tcpblock.wordpress.com/).

## Description

tcpblock-notify adds notification center support to tcpblock application firewall.

It has been tested successfully in Mac OS X 10.9 Mavericks.

## Requirements

### terminal notifier

[terminal notifier](https://github.com/alloy/terminal-notifier) is required. You can either install it manually or via [brew](http://brew.sh/) (brew is the preferred way)

### tcpblock configuration

tcpblock should be configured using:
+ Enabled
+ Log blocked connections
+ using "White List"

Check the following screenshot:
![alt tag](https://raw.github.com/sakoula/tcpblock-notify/master/images/tcpblock_gui.jpg)

## Install

There are two ways

### Install with installer

Download from the
[releases section](https://github.com/sakoula/tcpblock-notify/releases).

Make sure that you have installed terminal-notifer and you have located the binary. Based on the method you have used to install terminal-notifier (brew, gem or released) the location of the binary may differ. Examples include:
+ `/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier`
+ `/usr/local/bin/terminal-notifier`

Install it using:
```
$ unzip tcpblock-notify-0.2.zip
$ cd tcpblock-notify-0.2
$ ./install-tcpblock-notify.sh "/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier"

copying binary to /home/psebos/.tcpblock-notify ...done
automating startup ...done

installation completed!
you can start tcpblock-notify by

rebooting
or
launchctl load /home/psebos/Library/LaunchAgents/com.sakoula.tcpblock-notify.plist

thx
sakoula
```

### Install manually

Download from the
[releases section](https://github.com/sakoula/tcpblock-notify/releases). Install it using:
```
$ terminalnotifier="LOCATION OF THE TERMINAL NOTIFIER BINARY"

$ unzip tcpblock-notify-0.2.zip
$ cd tcpblock-notify-0.2

# copying binary to ${HOME}/.tcpblock-notify ..
$ mkdir -p ${HOME}/.tcpblock-notify
$ cat tcpblock-notify.sh | sed "s#/usr/local/bin/terminal-notifier#\"${terminalnotifier}\"#" > ${HOME}/.tcpblock-notify/tcpblock-notify.sh
$ cp tcpblock-notify.sh ${HOME}/.tcpblock-notify
$ chmod 755 ${HOME}/.tcpblock-notify/tcpblock-notify.sh

$# loading tcpblock-notify on startup ..
$ mkdir -p $HOME/Library/LaunchAgents/
$ cat com.sakoula.tcpblock-notify.plist | sed "s#<string>tcpblock-notify.sh</string>#<string>$HOME/.tcpblock-notify/tcpblock-notify.sh</string>#" > ${HOME}/Library/LaunchAgents/com.sakoula.tcpblock-notify.plist
$ chmod 644 ${HOME}/Library/LaunchAgents/com.sakoula.tcpblock-notify.plist

$# start the tcpblock-notify with the command
launchctl load ${HOME}/Library/LaunchAgents/com.sakoula.tcpblock-notify.plist
```


## Uninstall

### Uninstall with uninstaller

If used the installer for installation use the uninstaller which is included inside the installation package [releases section](https://github.com/sakoula/tcpblock-notify/releases):
```
$ unzip tcpblock-notify-0.2.zip
$ cd tcpblock-notify-0.2

$ ./uninstall-tcpblock-notify.sh
```

### Uninstall manually

```
$# deleting ${HOME}/.tcpblock-notify ..
$ /bin/rm -r ${HOME}/.tcpblock-notify/tcpblock-notify.sh

$# stopping ${HOME}/Library/LaunchAgents/com.sakoula.tcpblock-notify.plist
$ launchctl unload ${HOME}/Library/LaunchAgents/com.sakoula.tcpblock-notify.plist

$# deleting ${HOME}/Library/LaunchAgents/com.sakoula.tcpblock-notify.plist
$ /bin/rm -r ${HOME}/Library/LaunchAgents/com.sakoula.tcpblock-notify.plist
echo ".done"
```

<!--

### Install with brew

You can also install it via [Homebrew](https://github.com/mxcl/homebrew):
```
$ brew install tcpblock-notify
```

terminal-notifier will be installed automatically.

make sure to read the Caveats in order to automate the launch of tcpblock-notify:


-->

## Usage

when an application will be block you will presented with a notification message:

![alt tag](https://raw.github.com/sakoula/tcpblock-notify/master/images/notification_window.png)


click on it and you will presented with the local user password in order to add it to the exception list:

![alt tag](https://raw.github.com/sakoula/tcpblock-notify/master/images/authentication_window.png)

## Behind the scenes

The code is very simple. It continuously monitors the syslog (/var/log/system.log) where tcpblock is logging to. If it finds an entry from tcpblock it parses the entry, figures out the blocked application and it used the following command to add it to the exception list:
```
$ sudo tcpblock -a application_name
```

## Troubleshooting

Make sure that terminal-notifier works. Locate the binary and run from the command line
```
$"/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier" -message "This is a test"
or
$"/usr/local/bin/terminal-notifier" -message "This is a test"
depending on the terminal-notifier binary
```


## License

All the works are available under the MIT license.

Copyright (c) 2013 psebos@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
