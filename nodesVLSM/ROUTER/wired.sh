cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.16.58
    netmask 255.255.255.252
    up ip route add default via 10.94.16.57

auto eth1
iface eth1 inet static
    address 10.94.16.61
    netmask 255.255.255.252

auto eth2
iface eth2 inet static
    address 10.94.16.65
    netmask 255.255.255.252

auto eth3
iface eth3 inet static
    address 10.94.16.69
    netmask 255.255.255.252

up ip route add 10.94.0.0/22 via 10.94.16.70
up ip route add 10.94.6.0/23 via 10.94.16.70
up ip route add 10.94.12.0/24 via 10.94.16.70
up ip route add 10.94.15.64/26 via 10.94.16.70

up ip route add 10.94.8.0/23 via 10.94.16.62
up ip route add 10.94.13.128/25 via 10.94.16.62
up ip route add 10.94.14.128/26 via 10.94.16.62
up ip route add 10.94.15.0/26 via 10.94.16.62
up ip route add 10.94.15.192/27 via 10.94.16.62
up ip route add 10.94.16.16/29 via 10.94.16.62

up ip route add 10.94.4.0/23 via 10.94.16.66
up ip route add 10.94.10.0/23 via 10.94.16.66
up ip route add 10.94.14.0/25 via 10.94.16.66
up ip route add 10.94.14.192/26 via 10.94.16.66
up ip route add 10.94.15.128/27 via 10.94.16.66
up ip route add 10.94.15.160/27 via 10.94.16.66
up ip route add 10.94.15.224/28 via 10.94.16.66
up ip route add 10.94.15.240/28 via 10.94.16.66
up ip route add 10.94.16.0/28 via 10.94.16.66
up ip route add 10.94.16.24/29 via 10.94.16.66
up ip route add 10.94.16.32/29 via 10.94.16.66
up ip route add 10.94.16.40/29 via 10.94.16.66
up ip route add 10.94.16.48/30 via 10.94.16.66
EOF

sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
ip addr add 10.94.16.58/30 dev eth0 2>/dev/null || true
ip link set eth0 up
ip addr add 10.94.16.61/30 dev eth1 2>/dev/null || true
ip link set eth1 up
ip addr add 10.94.16.65/30 dev eth2 2>/dev/null || true
ip link set eth2 up
ip addr add 10.94.16.69/30 dev eth3 2>/dev/null || true
ip link set eth3 up