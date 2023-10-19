#!/bin/bash

# Variables

WEB_SERVER="hello.com"  # Web server name
WEB_SERVER_PORT="80"    # Replace with your web server port
INTERVAL=5              # Time interval between each monitoring cycle (in seconds)
OUTPUT_FILE="webserver_performance.txt"

# Function to get timestamp
get_timestamp() {
  date +"%Y-%m-%d %H:%M:%S"
}

# Main monitoring loop
while true; do
  # Get server status
  server_status=$(curl -s -o /dev/null -w "%{http_code}" "http://$WEB_SERVER:$WEB_SERVER_PORT")

  # Get server load average
  load_average=$(uptime | awk -F'average: ' '{print $2}')

  # Get free memory
  free_memory=$(free -m | awk 'NR==2{print $4}')

  # Get CPU usage percentage
  cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

  # Get disk usage percentage
  disk_usage=$(df -h | grep "/$" | awk '{print $5}')

  # Get timestamp
  timestamp=$(get_timestamp)

  # Get connected clients
  connected_clients=$(netstat -an | grep ESTABLISHED | wc -l)


  # Output to file
  echo "Timestamp: $timestamp" >> "$OUTPUT_FILE"
  echo "Server Status: $server_status" >> "$OUTPUT_FILE"
  echo "Load Average: $load_average" >> "$OUTPUT_FILE"
  echo "Free Memory: $free_memory MB" >> "$OUTPUT_FILE"
  echo "CPU Usage: $cpu_usage%" >> "$OUTPUT_FILE"
  echo "Disk Usage: $disk_usage" >> "$OUTPUT_FILE"
  echo "Connected clients: $connected_clients" >> "$OUTPUT_FILE"
  echo "-----------------------------------" >> "$OUTPUT_FILE"

  # Display current stats
  echo "Timestamp: $timestamp"
  echo "Server Status: $server_status"
  echo "Load Average: $load_average"
  echo "Free Memory: $free_memory MB"
  echo "CPU Usage: $cpu_usage%"
  echo "Disk Usage: $disk_usage"
  echo "Connected clients: $connected_clients"
  echo "-----------------------------------"

  # Wait for the next interval
  sleep $INTERVAL
done

