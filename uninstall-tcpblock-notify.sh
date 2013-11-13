#!/bin/bash
# uninstall-tcpblock-notify.sh
#
# argument: none
#
# description:
#  deletes
#   tcpblock-notify.sh @ $HOME/.tcpblock-notify/
#   com.sakoula.tcpblock-notify.plist @ $HOME/Library/LaunchAgents/
#
# logging:
#  on screen
#
#  psebos@gmail.com
echo " "

echo -n "stopping ${HOME}/Library/LaunchAgents/com.sakoula.tcpblock-notify.plist"
launchctl unload ${HOME}/Library/LaunchAgents/com.sakoula.tcpblock-notify.plist
echo ".done"


echo -n "deleting ${HOME}/.tcpblock-notify .."
/bin/rm -r ${HOME}/.tcpblock-notify/tcpblock-notify.sh
/bin/rmdir ${HOME}/.tcpblock-notify
echo ".done"

echo -n "deleting ${HOME}/Library/LaunchAgents/com.sakoula.tcpblock-notify.plist"
/bin/rm -r ${HOME}/Library/LaunchAgents/com.sakoula.tcpblock-notify.plist
echo ".done"

cat << EOS

thx
sakoula
EOS

exit 0
