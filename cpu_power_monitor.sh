#!/bin/bash

# Define the path to the energy input file
energy_file="/sys/class/hwmon/hwmon7/energy17_input"

# Function to get the current energy in microjoules
get_energy() {
    local energy
    read -r energy < "$energy_file"
    echo "$energy"
}

# Initial energy reading (in microjoules)
initial_energy=$(get_energy)

# Wait for 0.1 second (this defines the interval)
sleep 0.1

# Final energy reading (in microjoules) after 1 second
final_energy=$(get_energy)

# Calculate the energy difference (in microjoules)
energy_diff=$((final_energy - initial_energy))

# Convert energy difference from microjoules to joules (1 joule = 1 million microjoules)
energy_diff_joules=$(echo "scale=6; $energy_diff / 1000000" | bc)

# Calculate power in watts (1 joule per second = 1 watt)
power_usage=$(echo "scale=1; $energy_diff_joules / 1" | bc)

# Output the power usage in watts, rounded to 1 decimal place
printf "%.1f\n" $power_usage
