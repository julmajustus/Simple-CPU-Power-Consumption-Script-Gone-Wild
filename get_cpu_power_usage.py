#!/usr/bin/env python3
import time

ENERGY_FILE = "/sys/class/hwmon/hwmon7/energy17_input"

def get_energy():
    with open(ENERGY_FILE, "r") as f:
        return int(f.read().strip())

def main():
    initial_energy = get_energy()
    time.sleep(0.1)
    final_energy = get_energy()
    energy_diff = final_energy - initial_energy
    energy_diff_joules = energy_diff / 1_000_000
    power_usage = energy_diff_joules / 0.1

    print(f"{power_usage:.1f}")

if __name__ == "__main__":
    main()
