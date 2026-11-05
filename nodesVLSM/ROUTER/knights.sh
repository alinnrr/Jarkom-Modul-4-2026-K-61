cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.16.86
    netmask 255.255.255.252
    up ip route replace default via 10.94.16.85

auto eth1
iface eth1 inet static
    address 10.94.16.89
    netmask 255.255.255.252
    up ip route replace 10.94.15.128/26 via 10.94.16.90
    up ip route replace 10.94.16.0/27 via 10.94.16.90
    up ip route replace 10.94.16.92/30 via 10.94.16.90

auto eth2
iface eth2 inet static
    address 10.94.16.49
    netmask 255.255.255.248

EOF

sysctl -w net.ipv4.ip_forward=1
grep -q '^net.ipv4.ip_forward=1' /etc/sysctl.conf || echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf

ip addr flush dev eth0
ip addr add 10.94.16.86/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1
ip addr add 10.94.16.89/30 dev eth1
ip link set eth1 up
ip addr flush dev eth2
ip addr add 10.94.16.49/29 dev eth2
ip link set eth2 up
ip route replace 10.94.15.128/26 via 10.94.16.90
ip route replace 10.94.16.0/27 via 10.94.16.90
ip route replace 10.94.16.92/30 via 10.94.16.90
ip route replace default via 10.94.16.85
