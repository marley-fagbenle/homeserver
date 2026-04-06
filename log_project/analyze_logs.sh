#!/bin/bash

# Define the log file location
LOG_FILE="dummy_access.log"

# Check if the file exists before running
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: Log file $LOG_FILE not found!"
    exit 1
fi

echo "Analyzing $LOG_FILE..."
echo "-----------------------------------"
echo "Top IP Addresses (Successful Requests Only):"

# The Unix Pipeline
# 1. cat reads the file
# 2. grep isolates lines with a " 200 " success status
# 3. sed deletes any lines from the local 127.0.0.1 loopback address
# 4. awk extracts the 1st column (the IP address)
# 5. sort organizes the IPs alphabetically so identical ones are grouped together
# 6. uniq -c counts the occurrences of each grouped IP
# 7. sort -nr sorts the output numerically (-n) in reverse/descending order (-r)
# 8. head -n 3 outputs only the top 3 results

cat "$LOG_FILE" \
    | grep " 200 " \
    | sed '/127.0.0.1/d' \
    | awk '{print $1}' \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -n 3

echo "-----------------------------------"
echo "Analysis complete."
