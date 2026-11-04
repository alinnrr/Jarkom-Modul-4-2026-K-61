cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.16.110
    netmask 255.255.255.252
    up ip route add default via 10.94.16.109

auto eth1
iface eth1 inet static
    address 10.94.16.113
    netmask 255.255.255.252

auto eth2
iface eth2 inet static
    address 10.94.15.225
    netmask 255.255.255.240

up ip route add 10.94.14.192/26 via 10.94.16.114
up ip route add 10.94.16.24/29 via 10.94.16.114
EOF

sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
ip addr add 10.94.16.110/30 dev eth0 2>/dev/null || true
ip link set eth0 up
ip addr add 10.94.16.113/30 dev eth1 2>/dev/null || true
ip link set eth1 up
ip addr add 10.94.15.225/28 dev eth2 2>/dev/null || true
ip link set eth2 up