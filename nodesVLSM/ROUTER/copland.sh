cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.16.78
    netmask 255.255.255.252
    up ip route add default via 10.94.16.77

auto eth1
iface eth1 inet static
    address 10.94.6.1
    netmask 255.255.254.0

auto eth2
iface eth2 inet static
    address 10.94.15.65
    netmask 255.255.255.192
EOF

sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
ip addr add 10.94.16.78/30 dev eth0 2>/dev/null || true
ip link set eth0 up
ip addr add 10.94.6.1/23 dev eth1 2>/dev/null || true
ip link set eth1 up
ip addr add 10.94.15.65/26 dev eth2 2>/dev/null || true
ip link set eth2 up