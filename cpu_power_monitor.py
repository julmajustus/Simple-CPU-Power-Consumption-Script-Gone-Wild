#!/usr/bin/env python3
import time

# Define the path to the energy input file
ENERGY_FILE = "/sys/class/hwmon/hwmon7/energy17_input"

def get_energy():
    """
    Reads the current energy value in microjoules from the ENERGY_FILE.
    """
    with open(ENERGY_FILE, "r") as f:
        # Read the file content and strip any whitespace/newlines
        return int(f.read().strip())

def main():
    # Get the initial energy reading (in microjoules)
    initial_energy = get_energy()

    # Wait for 1 second (this defines the interval)
    time.sleep(0.1)

    # Get the final energy reading (in microjoules)
    final_energy = get_energy()

    # Calculate the energy difference (in microjoules)
    energy_diff = final_energy - initial_energy

    # Convert the energy difference from microjoules to joules
    # (1 joule = 1,000,000 microjoules)
    energy_diff_joules = energy_diff / 1_000_000

    # Since the interval is 1 second, energy_diff_joules is equal to power in watts.
    power_usage = energy_diff_joules

    # Output the power usage in watts, rounded to 1 decimal place.
    print(f"{power_usage:.1f}")

if __name__ == "__main__":
    main()
