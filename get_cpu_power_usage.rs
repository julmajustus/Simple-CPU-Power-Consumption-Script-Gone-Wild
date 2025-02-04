use std::fs::read_to_string;
use std::process;
use std::thread::sleep;
use std::time::Duration;

const CPU_INPUT_FILE: &str = "/sys/class/hwmon/hwmon7/energy17_input";

fn get_cpu_energy() -> u64 {
    let content = read_to_string(CPU_INPUT_FILE).unwrap_or_else(|err| {
        eprintln!("Failed to read file: {}", err);
        process::exit(1);
    });
    let energy = content.trim().parse::<u64>().unwrap_or_else(|err| {
        eprintln!("Failed to parse energy value: {}", err);
        process::exit(1);
    });
    energy
}

fn main() {
    let initial_energy = get_cpu_energy();
    sleep(Duration::from_millis(10));
    let final_energy = get_cpu_energy();
    let energy_diff = final_energy - initial_energy;
    let energy_diff_joules = energy_diff as f64 / 1e6;
    let power_usage = energy_diff_joules / 0.01;
    println!("{:.1}", power_usage);
}
