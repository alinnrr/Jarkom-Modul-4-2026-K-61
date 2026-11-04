cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.16.66
    netmask 255.255.255.252
    up ip route add default via 10.94.16.65

auto eth1
iface eth1 inet static
    address 10.94.16.97
    netmask 255.255.255.252

auto eth2
iface eth2 inet static
    address 10.94.16.85
    netmask 255.255.255.252

auto eth3
iface eth3 inet static
    address 10.94.10.1
    netmask 255.255.254.0

up ip route add 10.94.14.0/25 via 10.94.16.98
up ip route add 10.94.14.192/26 via 10.94.16.98
up ip route add 10.94.15.128/27 via 10.94.16.98
up ip route add 10.94.15.224/28 via 10.94.16.98
up ip route add 10.94.15.240/28 via 10.94.16.98
up ip route add 10.94.16.24/29 via 10.94.16.98
up ip route add 10.94.16.48/30 via 10.94.16.98

up ip route add 10.94.4.0/23 via 10.94.16.86
up ip route add 10.94.16.32/29 via 10.94.16.86
up ip route add 10.94.16.40/29 via 10.94.16.86
EOF

sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
ip addr add 10.94.16.66/30 dev eth0 2>/dev/null || true
ip link set eth0 up
ip addr add 10.94.16.97/30 dev eth1 2>/dev/null || true
ip link set eth1 up
ip addr add 10.94.16.85/30 dev eth2 2>/dev/null || true
ip link set eth2 up
ip addr add 10.94.10.1/23 dev eth3 2>/dev/null || true
ip link set eth3 up