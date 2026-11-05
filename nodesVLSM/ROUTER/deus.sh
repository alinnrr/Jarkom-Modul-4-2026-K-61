cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.16.78
    netmask 255.255.255.252
    up ip route replace default via 10.94.16.77

auto eth1
iface eth1 inet static
    address 10.94.16.81
    netmask 255.255.255.252
    up ip route replace 10.94.15.0/26 via 10.94.16.82
    up ip route replace 10.94.15.128/26 via 10.94.16.82
    up ip route replace 10.94.16.0/27 via 10.94.16.82
    up ip route replace 10.94.16.48/29 via 10.94.16.82
    up ip route replace 10.94.16.84/30 via 10.94.16.82
    up ip route replace 10.94.16.88/29 via 10.94.16.82

auto eth2
iface eth2 inet static
    address 10.94.14.1
    netmask 255.255.255.128

EOF

sysctl -w net.ipv4.ip_forward=1
grep -q '^net.ipv4.ip_forward=1' /etc/sysctl.conf || echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf

ip addr flush dev eth0
ip addr add 10.94.16.78/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1
ip addr add 10.94.16.81/30 dev eth1
ip link set eth1 up
ip addr flush dev eth2
ip addr add 10.94.14.1/25 dev eth2
ip link set eth2 up
ip route replace 10.94.15.0/26 via 10.94.16.82
ip route replace 10.94.15.128/26 via 10.94.16.82
ip route replace 10.94.16.0/27 via 10.94.16.82
ip route replace 10.94.16.48/29 via 10.94.16.82
ip route replace 10.94.16.84/30 via 10.94.16.82
ip route replace 10.94.16.88/29 via 10.94.16.82
ip route replace default via 10.94.16.77
