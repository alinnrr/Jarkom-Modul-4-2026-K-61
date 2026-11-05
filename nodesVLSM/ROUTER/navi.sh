cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.16.62
    netmask 255.255.255.252
    up ip route replace default via 10.94.16.61

auto eth1
iface eth1 inet static
    address 10.94.12.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 10.94.15.65
    netmask 255.255.255.192

auto eth3
iface eth3 inet static
    address 10.94.13.1
    netmask 255.255.255.0

EOF

sysctl -w net.ipv4.ip_forward=1
grep -q '^net.ipv4.ip_forward=1' /etc/sysctl.conf || echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf

ip addr flush dev eth0
ip addr add 10.94.16.62/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1
ip addr add 10.94.12.1/24 dev eth1
ip link set eth1 up
ip addr flush dev eth2
ip addr add 10.94.15.65/26 dev eth2
ip link set eth2 up
ip addr flush dev eth3
ip addr add 10.94.13.1/24 dev eth3
ip link set eth3 up
ip route replace default via 10.94.16.61
