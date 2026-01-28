#!/bin/bash
# Remove Netdata

set -e

echo "Removing Netdata..."

systemctl stop netdata 2>/dev/null || true
systemctl disable netdata 2>/dev/null || true

# Use official uninstaller if available
if [ -x /usr/libexec/netdata/netdata-uninstaller.sh ]; then
    /usr/libexec/netdata/netdata-uninstaller.sh --yes --force
else
    # Fallback to package manager
    apt-get remove --purge -y netdata 2>/dev/null || yum remove -y netdata 2>/dev/null || true
fi

# Clean up remaining files
rm -rf /etc/netdata /var/lib/netdata /var/cache/netdata /var/log/netdata

echo "Done."
