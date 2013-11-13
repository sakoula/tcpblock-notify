#!/bin/bash
# tcpblock-notify.sh
#
# argument: none
#
# description:
#  monitor (blocking) /var/log/system.log
#  for tcpblock messages.
#  when found a message parse the appname and
#  use terminal-notifier to display a message in
#  notification center.
#
# logging:
#  none
#
#  psebos@gmail.com
# if [[ ! $(which terminal-notifier) ]]; then
#   cat << EOS
# terminal-notifier is not installed. Please visit
# https://github.com/alloy/terminal-notifier
# to install it and try again.
# EOS
#   exit 1
# fi
# notifier_path=$(which terminal-notifier)

tail -1 -f /var/log/system.log | while read line
do
  if [[ "$line" == *tcpblock*block*connection* ]]; then
    message=$(echo $line | cut -d\  -f7-  | cut -d: -f1)
    app=$(echo $message | sed 's/^block connection of //' | sed 's/ to .*//')
    cmd='/usr/local/bin/tcpblock -a \"'$app'\"'
    /usr/local/bin/terminal-notifier -title tcpblock -sound Frog -message "$message" -execute "osascript -e 'do shell script \"$cmd\" with administrator privileges'"
    # $notifier_path -title tcpblock -sound Frog -message "$message" -execute "osascript -e 'do shell script \"$cmd\" with administrator privileges'"
    # check this for escaping http://stackoverflow.com/questions/18535178/trouble-escaping-quotes-in-a-shell-script
    # http://stackoverflow.com/questions/1250079/bash-escaping-single-quotes-inside-of-single-quoted-strings
  fi
done

