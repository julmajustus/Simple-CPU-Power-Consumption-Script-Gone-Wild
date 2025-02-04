
#include <fstream>
#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

constexpr const char *CPU_INPUT_FILE = "/sys/class/hwmon/hwmon7/energy17_input";

size_t get_cpu_energy(int fd)
{
    char buffer[64];
    ssize_t bytes_read = pread(fd, buffer, sizeof(buffer) - 1, 0);
    if (bytes_read <= 0)
    {
        perror("Failed to read file");
        std::exit(EXIT_FAILURE);
    }

    buffer[bytes_read] = '\0';

    char *end;
    size_t energy = std::strtoull(buffer, &end, 10);
    if (end == buffer)
    {
        std::cerr << "Failed to parse energy value" << std::endl;
        std::exit(EXIT_FAILURE);
    }
    return energy;
}

int main()
{
    int fd = open(CPU_INPUT_FILE, O_RDONLY);
    if (fd == -1)
    {
        perror("Failed to open file");
        return 1;
    }
    size_t initial_energy = get_cpu_energy(fd);
	usleep(10000);
    size_t final_energy = get_cpu_energy(fd);
    close(fd);

    size_t energy_diff = final_energy - initial_energy;
    double energy_diff_joules = energy_diff / 1'000'000.0; // Convert microjoules to joules
    double power_usage = energy_diff_joules / 0.01; // Power in watts

    std::cout << std::fixed << std::setprecision(1) << power_usage << '\n';
    return 0;
}
