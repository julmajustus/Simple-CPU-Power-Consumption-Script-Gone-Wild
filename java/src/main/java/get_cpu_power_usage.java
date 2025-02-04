import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.charset.StandardCharsets;

public class get_cpu_power_usage {
    private static final String CPU_INPUT_FILE = "/sys/class/hwmon/hwmon7/energy17_input";

    private static long getCpuEnergy() {
        try {
            String content = new String(Files.readAllBytes(Paths.get(CPU_INPUT_FILE)), StandardCharsets.UTF_8).trim();
            return Long.parseUnsignedLong(content);
        } catch (IOException e) {
            System.err.println("Failed to read file: " + e.getMessage());
            System.exit(1);
        } catch (NumberFormatException e) {
            System.err.println("Failed to parse energy value");
            System.exit(1);
        }
        return 0; // Unreachable
    }

    public static void main(String[] args) {
        long initialEnergy = getCpuEnergy();
        try {
            Thread.sleep(10); // Sleep for 10 milliseconds
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
        long finalEnergy = getCpuEnergy();
        long energyDiff = finalEnergy - initialEnergy;
        double energyDiffJoules = energyDiff / 1_000_000.0;
        double powerUsage = energyDiffJoules / 0.01;
        System.out.printf("%.1f%n", powerUsage);
    }
}
