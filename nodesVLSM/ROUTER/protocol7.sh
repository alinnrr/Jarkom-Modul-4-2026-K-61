cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.16.102
    netmask 255.255.255.252
    up ip route add default via 10.94.16.101

auto eth1
iface eth1 inet static
    address 10.94.16.105
    netmask 255.255.255.252

auto eth2
iface eth2 inet static
    address 10.94.15.129
    netmask 255.255.255.224

auto eth3
iface eth3 inet static
    address 10.94.16.49
    netmask 255.255.255.252

up ip route add 10.94.14.192/26 via 10.94.16.106
up ip route add 10.94.15.224/28 via 10.94.16.106
up ip route add 10.94.16.24/29 via 10.94.16.106
EOF

sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
ip addr add 10.94.16.102/30 dev eth0 2>/dev/null || true
ip link set eth0 up
ip addr add 10.94.16.105/30 dev eth1 2>/dev/null || true
ip link set eth1 up
ip addr add 10.94.15.129/27 dev eth2 2>/dev/null || true
ip link set eth2 up
ip addr add 10.94.16.49/30 dev eth3 2>/dev/null || true
ip link set eth3 up