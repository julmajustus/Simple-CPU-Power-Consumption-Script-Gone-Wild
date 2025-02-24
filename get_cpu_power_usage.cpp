/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_cpu_power_usage.cpp                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jmakkone <jmakkone@student.hive.fi>        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/12/09 18:46:22 by jmakkone          #+#    #+#             */
/*   Updated: 2025/02/24 19:37:47 by jmakkone         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <iostream>
#include <fstream>
#include <string>
#include <iomanip>
#include <cstdlib>
#include <unistd.h>

constexpr const char *CPU_INPUT_FILE = "/sys/class/hwmon/hwmon7/energy17_input";
constexpr int BUFFER_SIZE = 64;
constexpr double SAMPLE_INTERVAL_SECONDS = 0.01;

size_t get_cpu_energy(const char *filepath)
{
    std::ifstream file(filepath, std::ios::in);
    if (!file.is_open())
    {
        std::cerr << "Failed to open file: " << filepath << std::endl;
        std::exit(EXIT_FAILURE);
    }

    std::string buffer;
    if (!std::getline(file, buffer))
    {
        std::cerr << "Failed to read file: " << filepath << std::endl;
        std::exit(EXIT_FAILURE);
    }

    try
    {
        return std::stoull(buffer);
    }
    catch (const std::invalid_argument &)
    {
        std::cerr << "Failed to parse energy value" << std::endl;
        std::exit(EXIT_FAILURE);
    }
    catch (const std::out_of_range &)
    {
        std::cerr << "Energy value out of range" << std::endl;
        std::exit(EXIT_FAILURE);
    }
}

int main()
{
    size_t initial_energy = get_cpu_energy(CPU_INPUT_FILE);
    usleep(static_cast<useconds_t>(SAMPLE_INTERVAL_SECONDS * 1'000'000));
    size_t final_energy = get_cpu_energy(CPU_INPUT_FILE);
    size_t energy_diff = final_energy - initial_energy;

    double energy_diff_joules = energy_diff / 1'000'000.0;
    double power_usage = energy_diff_joules / SAMPLE_INTERVAL_SECONDS;
    std::cout << std::fixed << std::setprecision(1) << power_usage << '\n';

    return 0;
}
