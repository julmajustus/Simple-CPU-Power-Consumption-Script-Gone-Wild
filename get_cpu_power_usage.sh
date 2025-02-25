#!/bin/bash

energy_file="/sys/class/hwmon/hwmon7/energy17_input"

get_energy() {
    local energy
    read -r energy < "$energy_file"
    echo "$energy"
}

initial_energy=$(get_energy)
sleep 0.01
final_energy=$(get_energy)
energy_diff=$((final_energy - initial_energy))
energy_diff_joules=$(echo "scale=6; $energy_diff / 1000000" | bc)
power_usage=$(echo "scale=1; $energy_diff_joules / 0.01" | bc)

printf "%.1f\n" $power_usage
