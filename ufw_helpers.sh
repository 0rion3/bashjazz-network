#!/bin/bash
source $SHARED_SCRIPTS_PATH/utils/formatting.sh
source $SHARED_SCRIPTS_PATH/utils/rootrun.sh

add_ufw_rules() {
  echo -e "$(wrap "$1" 'color gray' 'ind 4')"
  result="$(rootrun "$1")"
  echo -e "$(wrap "$result" 'color gray' 'ind 6; ind 1 "=> "')"
}

reload_or_enable_ufw() {

  if [[ $1 == "confirm" ]]; then
    echo -e "$(wrap "Now we can enable ufw and all in & out traffic on $device will be blocked." \
      'ind 4; color white')"
    echo -e "$(wrap "Exceptions are made for the local network with the ip range of $local_ip_range" \
      'ind 4; color light_gray')"
    confirmation_line="$(echo -e \
      "$(wrap "Are you sure? (y/n): " \
      'ind 4; color yellow; color bold')")"
    read -p "$confirmation_line" confirmation
  else
    confirmation="y"
  fi

  if [[ $confirmation == "y" ]]; then
    if [[ $ufw_status == "inactive" ]]; then
      echo -e "$(wrap "$(rootrun 'ufw enable')" 'color gray' 'ind 6; ind 1 "=> "')"
    else
      echo -e "$(wrap "$(rootrun 'ufw reload')" 'color gray' 'ind 6; ind 1 "=> "')"
    fi
  fi

}

reset_ufw() {
  echo -e "$(wrap "Removing rules and reloading ufw (for now with just ufw reset)..." 'color white' 'ind 4')"
  echo -e "$(wrap "$(rootrun 'ufw --force reset')" 'color gray' 'ind 6; ind 1 "=> "')"
}
