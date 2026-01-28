# simple_monitoring

Basic monitoring setup using Netdata

## Usage

'''bash
sudo ./setup.sh
sudo ./test_dashboard.sh
sudo ./cleanup
'''

Dashboard: 'http://<your-ip>:19999'

## Custom Alert

The setup creates a CPU alert at '/etc/netdata/healh.d/custom_cpu.conf':
- Warning: >80%
- Critical: >95%