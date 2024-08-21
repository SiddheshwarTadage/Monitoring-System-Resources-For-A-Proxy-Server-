#!/bin/bash

# Function to display top 10 most used applications by CPU and memory
function top_apps() {
  echo "Top 10 Applications by CPU Usage:"
  ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 11
  echo ""
  
  echo "Top 10 Applications by Memory Usage:"
  ps -eo pid,comm,%mem,%cpu --sort=-%mem | head -n 11
  echo ""
}

# Function to monitor network activity
function network_monitoring() {
  echo "Network Monitoring:"
  echo "Number of concurrent connections: $(netstat -an | grep 'ESTABLISHED' | wc -l)"
  echo "Packet drops (RX/TX):"
  netstat -i | awk '{print $1, $4, $8}' | column -t
  echo "Network Traffic (MB in/out):"
  ifstat -T 1 1 | awk '{print $1, $6, $8}'
  echo ""
}

# Function to monitor disk usage
function disk_usage() {
  echo "Disk Usage:"
  df -h | awk '{ if ($5 >= 80) print $0; else print $0 }'
  echo ""
}

# Function to display system load and CPU breakdown
function system_load() {
  echo "System Load:"
  uptime
  echo "CPU Usage Breakdown:"
  mpstat | awk '$3 ~ /[0-9.]+/ { print "User: "$4"%", "System: "$6"%", "Idle: "$13"%" }'
  echo ""
}

# Function to display memory usage
function memory_usage() {
  echo "Memory Usage:"
  free -h
  echo ""
}

# Function to monitor active processes
function process_monitoring() {
  echo "Process Monitoring:"
  echo "Number of active processes: $(ps ax | wc -l)"
  echo "Top 5 Processes by CPU and Memory Usage:"
  ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
  echo ""
}

# Function to monitor essential services
function service_monitoring() {
  services=("sshd" "nginx" "apache2" "iptables")
  echo "Service Monitoring:"
  for service in "${services[@]}"; do
    if systemctl is-active --quiet "$service"; then
      echo "$service is running."
    else
      echo "$service is not running."
    fi
  done
  echo ""
}

# Function to show the full dashboard
function show_dashboard() {
  clear
  while true; do
    echo "--------------------- System Monitoring Dashboard ---------------------"
    top_apps
    network_monitoring
    disk_usage
    system_load
    memory_usage
    process_monitoring
    service_monitoring
    sleep 5
    clear
  done
}

# Parse command-line arguments for custom dashboard sections
if [[ $# -eq 0 ]]; then
  show_dashboard
else
  for arg in "$@"; do
    case $arg in
      -cpu)
        system_load
        ;;
      -memory)
        memory_usage
        ;;
      -network)
        network_monitoring
        ;;
      -disk)
        disk_usage
        ;;
      -process)
        process_monitoring
        ;;
      -service)
        service_monitoring
        ;;
      -top)
        top_apps
        ;;
      *)
        echo "Invalid option: $arg"
        echo "Usage: $0 [-cpu] [-memory] [-network] [-disk] [-process] [-service] [-top]"
        exit 1
        ;;
    esac
  done
fi