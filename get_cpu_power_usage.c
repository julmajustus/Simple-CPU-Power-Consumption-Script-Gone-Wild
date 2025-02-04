/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   cpu_power_monitor.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jmakkone <jmakkone@student.hive.fi>        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/12/03 23:54:38 by jmakkone          #+#    #+#             */
/*   Updated: 2024/12/04 01:29:05 by jmakkone         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

#define CPU_INPUT_FILE "/sys/class/hwmon/hwmon7/energy17_input"
#define BUFFER_SIZE 64

static size_t get_cpu_energy(int fd)
{
	char buffer[BUFFER_SIZE];
	ssize_t bytes_read = pread(fd, buffer, BUFFER_SIZE - 1, 0);
	if (bytes_read <= 0)
	{
		perror("Failed to read file");
		exit(1);
	}

	buffer[bytes_read] = '\0';

	char *end;
	size_t energy = strtoull(buffer, &end, 10);
	if (end == buffer)
	{
		fprintf(stderr, "Failed to parse energy value\n");
		exit(1);
	}
	return energy;
}

int main(void)
{
	int fd = open(CPU_INPUT_FILE, O_RDONLY);
	if (fd == -1)
	{
		perror("Failed to open file");
		exit(1);
	}
	size_t initial_energy = get_cpu_energy(fd);
	usleep(10000);
	size_t final_energy = get_cpu_energy(fd);
	close(fd);
	size_t energy_diff = final_energy - initial_energy;
	double energy_diff_joules = energy_diff / 1000000.0;
	double power_usage = energy_diff_joules / 0.01;
	printf("%.1f\n", power_usage);

	return 0;
}
