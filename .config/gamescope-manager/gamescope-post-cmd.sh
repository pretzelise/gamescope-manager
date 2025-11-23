#!/usr/bin/env bash

gamescope_launch_command=$1   # the command string used to identify the upcoming gamescope process
post_run_cmd=("${@:2}")       # the command to run after gamescope has exited
start_timestamp=$EPOCHSECONDS # store the current time so we can exit after 30 seconds of no activity
gamescope_pid=""

until [ $((EPOCHSECONDS - start_timestamp)) -gt 30 ]; do
  sleep 1 &
  if [ -z "${SteamAppId}" ]; then
    gamescope_pid=$(pgrep gamescope --list-full | grep -v grep | grep "$gamescope_launch_command" | awk '{print $1}')
  elif [ $SteamAppId -eq 0 ]; then
    gamescope_pid=$(pgrep gamescope --list-full | grep -v grep | grep "$gamescope_launch_command" | grep "AppId=${STEAM_COMPAT_DATA_PATH##*/}" | awk '{print $1}')
  else
    gamescope_pid=$(pgrep gamescope --list-full | grep -v grep | grep "$gamescope_launch_command" | grep "AppId=$SteamAppId" | awk '{print $1}') # uses $SteamAppId env var to confirm its found the correct gamescope process
  fi

  wait

  # if gamescope's pid has been found, exit the loop and continue the script
  [ "$gamescope_pid" == "" ] || break
done

while true; do
  sleep 1 &
  # if gamescope's process has exited, run the post-run command
  if ! [ -f "/proc/${gamescope_pid}/status" ]; then
    "${post_run_cmd[@]}"
    break
  fi
  wait
done
