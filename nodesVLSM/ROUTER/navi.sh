cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.16.62
    netmask 255.255.255.252
    up ip route add default via 10.94.16.61

auto eth1
iface eth1 inet static
    address 10.94.8.1
    netmask 255.255.254.0

auto eth2
iface eth2 inet static
    address 10.94.14.129
    netmask 255.255.255.192

auto eth3
iface eth3 inet static
    address 10.94.13.129
    netmask 255.255.255.128
EOF

sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
ip addr add 10.94.16.62/30 dev eth0 2>/dev/null || true
ip link set eth0 up
ip addr add 10.94.8.1/23 dev eth1 2>/dev/null || true
ip link set eth1 up
ip addr add 10.94.14.129/26 dev eth2 2>/dev/null || true
ip link set eth2 up
ip addr add 10.94.13.129/25 dev eth3 2>/dev/null || true
ip link set eth3 up