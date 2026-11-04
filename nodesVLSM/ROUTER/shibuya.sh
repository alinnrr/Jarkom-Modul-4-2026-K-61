cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.16.114
    netmask 255.255.255.252
    up ip route add default via 10.94.16.113

auto eth1
iface eth1 inet static
    address 10.94.16.117
    netmask 255.255.255.252

up ip route add 10.94.14.192/26 via 10.94.16.118
up ip route add 10.94.16.24/29 via 10.94.16.118
EOF

sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
ip addr add 10.94.16.114/30 dev eth0 2>/dev/null || true
ip link set eth0 up
ip addr add 10.94.16.117/30 dev eth1 2>/dev/null || true
ip link set eth1 up