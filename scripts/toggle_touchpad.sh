#!/bin/bash

get_touchpad_device_name() {
  device_name_string=$(xinput list --name-only | grep -i 'touchpad')
  first_char="${device_name_string:0:1}"
  if [[ "${first_char}" == "∼" ]] then
    device_name_string="${device_name_string:2:$(( ${#device_name_string} - 2 ))}"
  fi
  echo "$device_name_string"
}

get_device_status() {
  device_id=$1
  device_status=$(xinput list-props "${device_id}" | grep "Device Enabled" | grep -o "[01]$")
  echo "${device_status}"
}

touchpad_name=$(get_touchpad_device_name)
device_id=$(xinput list --id-only "${touchpad_name}")
device_status=$(get_device_status "${device_id}")

if [[ "${device_status}" == "1" ]] then
  xinput --disable "${device_id}"
elif [[ "${device_status}" == "0" ]] then
  xinput --enable "${device_id}"
fi
