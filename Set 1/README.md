# System Resource Monitoring Script

## Overview

This bash script provides a **comprehensive monitoring solution** for various system resources on a proxy server. It displays **real-time data** in a dashboard format, refreshing every few seconds. Additionally, users can view specific sections of the dashboard using command-line switches, allowing for targeted monitoring.

## Features

1. **Top 10 Most Used Applications**:
   - Displays the top 10 applications consuming the most CPU and memory.

2. **Network Monitoring**:
   - Number of concurrent connections to the server.
   - Packet drops (RX/TX).
   - Network traffic in and out (in MB).

3. **Disk Usage**:
   - Displays disk space usage by mounted partitions.
   - Highlights partitions using more than 80% of the space.

4. **System Load**:
   - Shows the current load average for the system.
   - Includes a breakdown of CPU usage (user, system, idle, etc.).

5. **Memory Usage**:
   - Displays total, used, and free memory.
   - Shows swap memory usage.

6. **Process Monitoring**:
   - Displays the number of active processes.
   - Shows the top 5 processes in terms of CPU and memory usage.

7. **Service Monitoring**:
   - Monitors the status of essential services like `sshd`, `nginx`, `apache`, `iptables`, etc.

8. **Custom Dashboard**:
   - Provides command-line switches to view specific parts of the dashboard, e.g., `-cpu`, `-memory`, `-network`, etc.

## Installation

1. **Download the Script**:
   - Save the script to your server.

2. **Make the Script Executable**:
   - Run the following command to make the script executable:
     ```bash
     chmod +x monitor.sh
     ```

3. **Run the Script**:
   - To run the script, use the following command:
     ```bash
     ./monitor.sh
     ```

## Usage

### Full Dashboard

To view the full dashboard with all monitoring features:

```bash
./monitor.sh
