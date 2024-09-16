#!/bin/bash

# Import sources
import_sources=(
    https://raw.githubusercontent.com/pebblehost/hunter/master/ips.txt
)

# Output file
output_file="/etc/haproxy/blacklist.lst"
#output_file="blacklist.lst"

# Add to blacklist if not already present
for source in "${import_sources[@]}"; do
    while IFS= read -r line; do
        if ! grep -q "$line" $output_file; then
            echo "Adding $line to blacklist"
            echo "$line" >> $output_file
        fi
    done < <(curl -s "$source")
done