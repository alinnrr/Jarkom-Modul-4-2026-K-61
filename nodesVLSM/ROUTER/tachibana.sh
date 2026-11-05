cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.16.66
    netmask 255.255.255.252
    up ip route replace default via 10.94.16.65

auto eth1
iface eth1 inet static
    address 10.94.16.77
    netmask 255.255.255.252
    up ip route replace 10.94.14.0/25 via 10.94.16.78
    up ip route replace 10.94.15.0/26 via 10.94.16.78
    up ip route replace 10.94.15.128/26 via 10.94.16.78
    up ip route replace 10.94.16.0/27 via 10.94.16.78
    up ip route replace 10.94.16.48/29 via 10.94.16.78
    up ip route replace 10.94.16.80/28 via 10.94.16.78

auto eth2
iface eth2 inet static
    address 10.94.16.69
    netmask 255.255.255.252
    up ip route replace 10.94.4.0/22 via 10.94.16.70
    up ip route replace 10.94.16.40/29 via 10.94.16.70
    up ip route replace 10.94.16.72/30 via 10.94.16.70

auto eth3
iface eth3 inet static
    address 10.94.8.1
    netmask 255.255.254.0

EOF

sysctl -w net.ipv4.ip_forward=1
grep -q '^net.ipv4.ip_forward=1' /etc/sysctl.conf || echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf

ip addr flush dev eth0
ip addr add 10.94.16.66/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1
ip addr add 10.94.16.77/30 dev eth1
ip link set eth1 up
ip addr flush dev eth2
ip addr add 10.94.16.69/30 dev eth2
ip link set eth2 up
ip addr flush dev eth3
ip addr add 10.94.8.1/23 dev eth3
ip link set eth3 up
ip route replace 10.94.4.0/22 via 10.94.16.70
ip route replace 10.94.16.40/29 via 10.94.16.70
ip route replace 10.94.16.72/30 via 10.94.16.70
ip route replace 10.94.14.0/25 via 10.94.16.78
ip route replace 10.94.15.0/26 via 10.94.16.78
ip route replace 10.94.15.128/26 via 10.94.16.78
ip route replace 10.94.16.0/27 via 10.94.16.78
ip route replace 10.94.16.48/29 via 10.94.16.78
ip route replace 10.94.16.80/28 via 10.94.16.78
ip route replace default via 10.94.16.65
