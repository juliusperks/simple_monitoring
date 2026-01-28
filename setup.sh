#!/bin/bash
# Install Netdata and configure a custom CPU alert

set -e

echo "Installing Netdata..."
bash <(curl -Ss https://get.netdata.cloud/kickstart.sh) --dont-wait --disable-telemetry --non-interactive

# Custom CPU alert: warn >80%, critical >95%
cat > /etc/netdata/health.d/custom_cpu.conf << 'EOF'
alarm: cpu_usage_high
   on: system.cpu
lookup: average -2m percentage foreach user,system
 units: %
 every: 10s
  warn: $this > 80
  crit: $this > 95
  info: CPU usage is high
EOF

systemctl restart netdata

echo "Done! Dashboard: http://$(hostname -I | awk '{print $1}'):19999"