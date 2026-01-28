#!/bin/bash

DURATION=${1:-30}

echo "Generating load for ${DURATION}s..."
echo "Watch the dashboard at http://$(hostname -I | awk '{print $1}'):19999"

stress --cpu $(nproc) --timeout ${DURATION}s &
stress --vm 1 --vm-bytes 256M --timeout ${DURATION}s &

(
    end=$((SECONDS + DURATION))
    while [ $SECONDS -lt $end ]; do
        dd if=/dev/zero of=/tmp/testfile bs=1M count=50 2>/dev/null
        rm -f /tmp/testfile
    done
) &

wait
echo "Load test complete"