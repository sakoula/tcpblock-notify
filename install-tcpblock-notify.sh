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
_usage ()
{
  cat <<EOS
Usage: $0 [terminal-notifier]
terminal-notifier :  location of terminal-notifier binary. if the argument
                     is missing the instaler will try to figure out the location.
e.g.
$0 "/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier"

terminal-notifier can be installed from https://github.com/alloy/terminal-notifier
--
EOS
  return 0
}

# detecting installation of terminal-notifer
[[ -z "$1" && ! $(which terminal-notifier) ]] && echo "error: cannot find terminal-notifier" && _usage && exit 1
[[ -n "$1" && ! -x "$1" ]] && echo "error: invalid terminal-notifier binary: '$1'" && _usage && exit 1
[[ $(${1} -message 'installing tcpblock-notify') && $? != 0 ]] && echo "error: invalid terminal-notifier binary: '$1'" && _usage && exit 1
if [[ -n "$1" ]]; then
  terminalnotifier="$1"
else
  terminalnotifier=$(which terminal-notifier)
fi
# detected installation


echo " "

echo -n "copying binary to ${HOME}/.tcpblock-notify .."
mkdir -p ${HOME}/.tcpblock-notify 2>/dev/null
cat tcpblock-notify.sh | sed "s#/usr/local/bin/terminal-notifier#\"${terminalnotifier}\"#" > ${HOME}/.tcpblock-notify/tcpblock-notify.sh
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
