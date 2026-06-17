#!/bin/bash

# Color Codes for Senior-Level Formatting
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CLEAR='\033[0m'

echo -e "${GREEN}=== SYSTEM PERFORMANCE METRICS ===${CLEAR}"

# 1. OS Version
if [ -f /etc/os-release ]; then
    OS_VERSION=$(grep -w "PRETTY_NAME" /etc/os-release | cut -d= -f2 | tr -d '"')
    echo -e "  • OS Version:      ${GREEN}${OS_VERSION}${CLEAR}"
else
    echo -e "  • OS Version:      ${YELLOW}Unknown Linux Distribution${CLEAR}"
fi

# [NEW ADDITION] 2. System Uptime & Load Average
# Dumps how long the server has been running and system load over 1, 5, and 15 mins
UPTIME_INFO=$(uptime | awk -F'load average:' '{print $2}' | tr -d ' ')
echo -e "  • Load Average:    ${GREEN}${UPTIME_INFO}${CLEAR}"

# 3. Total CPU Usage
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
CPU_USAGE=$(awk "BEGIN {print 100 - $CPU_IDLE}")
echo -e "  • Total CPU Usage: ${GREEN}${CPU_USAGE}%${CLEAR}"

# 4. Total Memory Usage (Used vs Free)
MEM_TOTAL=$(free -m | grep "Mem:" | awk '{print $2}')
MEM_USED=$(free -m | grep "Mem:" | awk '{print $3}')
MEM_PCT=$(awk "BEGIN {printf \"%.2f\", ($MEM_USED / $MEM_TOTAL) * 100}")
echo -e "  • Memory Usage:    ${GREEN}${MEM_USED}MB / ${MEM_TOTAL}MB (${MEM_PCT}%)${CLEAR}"

# 5. Total Disk Usage
DISK_TOTAL=$(df -h / | tail -n 1 | awk '{print $2}')
DISK_USED=$(df -h / | tail -n 1 | awk '{print $3}')
DISK_PCT=$(df -h / | tail -n 1 | awk '{print $5}')
echo -e "  • Disk Usage:      ${GREEN}${DISK_USED} / ${DISK_TOTAL} (${DISK_PCT})${CLEAR}"

# [NEW ADDITION] 6. Security Audit: Active Users
# Counts how many active shell sessions are currently open on the host
USER_COUNT=$(who | wc -l)
echo -e "  • Active Users:    ${GREEN}${USER_COUNT} logged in${CLEAR}"

# 7. Top 5 Processes by CPU Usage (The Header Shaver)
echo -e "\n${GREEN}=== TOP 5 PROCESSES BY CPU ===${CLEAR}"
ps -eo pid,pcpu,comm --sort=-pcpu | head -n 6 | tail -n 5

echo -e "${GREEN}==================================${CLEAR}"
