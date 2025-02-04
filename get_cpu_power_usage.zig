const std = @import("std");

const CPU_INPUT_FILE = "/sys/class/hwmon/hwmon7/energy17_input";

fn getCpuEnergy() u64 {
    // Open the file in read-only mode (empty options defaults to read-only).
    var file = std.fs.cwd().openFile(CPU_INPUT_FILE, .{}) catch {
        std.debug.print("Failed to open file\n", .{});
        std.process.exit(1);
    };

    var buffer: [64]u8 = undefined;
    const bytes_read = file.read(&buffer) catch {
        std.debug.print("Failed to read file\n", .{});
        std.process.exit(1);
    };

    // Trim whitespace characters from the read bytes.
    const s = std.mem.trim(u8, buffer[0..bytes_read], " \t\n\r");

    const energy = std.fmt.parseInt(u64, s, 10) catch {
        std.debug.print("Failed to parse energy value\n", .{});
        std.process.exit(1);
    };
    return energy;
}

pub fn main() !void {
    const initial_energy = getCpuEnergy();
    // Sleep for 10 milliseconds.
    std.time.sleep(10 * 1_000_000); // 10 ms in nanoseconds
    const final_energy = getCpuEnergy();
    const energy_diff: f64 = @floatFromInt(final_energy - initial_energy);
    const energy_diff_joules: f64 = energy_diff / 1000000.0;
    const power_usage: f64 = energy_diff_joules / 0.01;
    std.debug.print("{d:.1}\n", .{power_usage});
}
