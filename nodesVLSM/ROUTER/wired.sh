cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.16.58
    netmask 255.255.255.252
    up ip route replace default via 10.94.16.57

auto eth1
iface eth1 inet static
    address 10.94.16.61
    netmask 255.255.255.252
    up ip route replace 10.94.12.0/23 via 10.94.16.62
    up ip route replace 10.94.15.64/26 via 10.94.16.62

auto eth2
iface eth2 inet static
    address 10.94.16.65
    netmask 255.255.255.252
    up ip route replace 10.94.4.0/22 via 10.94.16.66
    up ip route replace 10.94.8.0/23 via 10.94.16.66
    up ip route replace 10.94.14.0/25 via 10.94.16.66
    up ip route replace 10.94.15.0/26 via 10.94.16.66
    up ip route replace 10.94.15.128/26 via 10.94.16.66
    up ip route replace 10.94.16.0/27 via 10.94.16.66
    up ip route replace 10.94.16.40/29 via 10.94.16.66
    up ip route replace 10.94.16.48/29 via 10.94.16.66
    up ip route replace 10.94.16.68/30 via 10.94.16.66
    up ip route replace 10.94.16.72/29 via 10.94.16.66
    up ip route replace 10.94.16.80/28 via 10.94.16.66

auto eth3
iface eth3 inet static
    address 10.94.16.33
    netmask 255.255.255.248
    up ip route replace 10.94.0.0/22 via 10.94.16.34
    up ip route replace 10.94.10.0/23 via 10.94.16.35
    up ip route replace 10.94.15.192/26 via 10.94.16.35

EOF

sysctl -w net.ipv4.ip_forward=1
grep -q '^net.ipv4.ip_forward=1' /etc/sysctl.conf || echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf

ip addr flush dev eth0
ip addr add 10.94.16.58/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1
ip addr add 10.94.16.61/30 dev eth1
ip link set eth1 up
ip addr flush dev eth2
ip addr add 10.94.16.65/30 dev eth2
ip link set eth2 up
ip addr flush dev eth3
ip addr add 10.94.16.33/29 dev eth3
ip link set eth3 up
ip route replace 10.94.12.0/23 via 10.94.16.62
ip route replace 10.94.15.64/26 via 10.94.16.62
ip route replace 10.94.4.0/22 via 10.94.16.66
ip route replace 10.94.8.0/23 via 10.94.16.66
ip route replace 10.94.14.0/25 via 10.94.16.66
ip route replace 10.94.15.0/26 via 10.94.16.66
ip route replace 10.94.15.128/26 via 10.94.16.66
ip route replace 10.94.16.0/27 via 10.94.16.66
ip route replace 10.94.16.40/29 via 10.94.16.66
ip route replace 10.94.16.48/29 via 10.94.16.66
ip route replace 10.94.16.68/30 via 10.94.16.66
ip route replace 10.94.16.72/29 via 10.94.16.66
ip route replace 10.94.16.80/28 via 10.94.16.66
ip route replace 10.94.0.0/22 via 10.94.16.34
ip route replace 10.94.10.0/23 via 10.94.16.35
ip route replace 10.94.15.192/26 via 10.94.16.35
ip route replace default via 10.94.16.57
