cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.16.74
    netmask 255.255.255.252
    up ip route add default via 10.94.16.73

auto eth1
iface eth1 inet static
    address 10.94.0.1
    netmask 255.255.252.0
EOF

sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
ip addr add 10.94.16.74/30 dev eth0 2>/dev/null || true
ip link set eth0 up
ip addr add 10.94.0.1/22 dev eth1 2>/dev/null || true
ip link set eth1 up