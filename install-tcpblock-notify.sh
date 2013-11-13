#!/bin/bash
# install-tcpblock-notify.sh
#
# argument: none
#
# description:
#  installs
#   tcpblock-notify.sh @ $HOME/.tcpblock-notify/
#   com.sakoula.tcpblock-notify.plist @ $HOME/Library/LaunchAgents/
#  updates com.sakoula.tcpblock-notify.plist with the right paths
#
# logging:
#  on screen
#
#  psebos@gmail.com
# if [[ ! $(which terminal-notifier) ]]; then
if [[ ! $(which ls) ]]; then
  cat << EOS
terminal-notifier is not installed. Please visit
https://github.com/alloy/terminal-notifier
to install it and try again.
EOS
  exit 1
fi

echo " "

echo -n "copying binary to ${HOME}/.tcpblock-notify .."
mkdir -p ${HOME}/.tcpblock-notify 2>/dev/null
cp tcpblock-notify.sh ${HOME}/.tcpblock-notify
chmod 755 ${HOME}/.tcpblock-notify/tcpblock-notify.sh
echo ".done"

echo -n "loading tcpblock-notify on startup .."
mkdir -p $HOME/Library/LaunchAgents/
cat com.sakoula.tcpblock-notify.plist | sed "s#<string>tcpblock-notify.sh</string>#<string>$HOME/.tcpblock-notify/tcpblock-notify.sh</string>#" > ${HOME}/Library/LaunchAgents/com.sakoula.tcpblock-notify.plist
chmod 644 ${HOME}/Library/LaunchAgents/com.sakoula.tcpblock-notify.plist
echo ".done"

cat << EOS

installation completed!
you can start tcpblock-notify by

rebooting
or
launchctl load ${HOME}/Library/LaunchAgents/com.sakoula.tcpblock-notify.plist

thx
sakoula
EOS

exit 0
