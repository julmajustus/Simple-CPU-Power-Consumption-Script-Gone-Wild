package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strconv"
	"strings"
	"time"
)

const CPU_INPUT_FILE = "/sys/class/hwmon/hwmon7/energy17_input"

func getCPUEnergy() uint64 {
	data, err := ioutil.ReadFile(CPU_INPUT_FILE)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Failed to read file: %v\n", err)
		os.Exit(1)
	}
	s := strings.TrimSpace(string(data))
	energy, err := strconv.ParseUint(s, 10, 64)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Failed to parse energy value: %v\n", err)
		os.Exit(1)
	}
	return energy
}

func main() {
	initialEnergy := getCPUEnergy()
	time.Sleep(10 * time.Millisecond)
	finalEnergy := getCPUEnergy()
	energyDiff := finalEnergy - initialEnergy

	energyDiffJoules := float64(energyDiff) / 1e6
	powerUsage := energyDiffJoules / 0.01

	fmt.Printf("%.1f\n", powerUsage)
}
