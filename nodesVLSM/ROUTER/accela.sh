cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.16.90
    netmask 255.255.255.252
    up ip route add default via 10.94.16.89

auto eth1
iface eth1 inet static
    address 10.94.16.93
    netmask 255.255.255.252

up ip route add 10.94.4.0/23 via 10.94.16.94
up ip route add 10.94.16.32/29 via 10.94.16.94
EOF

sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
ip addr add 10.94.16.90/30 dev eth0 2>/dev/null || true
ip link set eth0 up
ip addr add 10.94.16.93/30 dev eth1 2>/dev/null || true
ip link set eth1 up