cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.4.2
    netmask 255.255.252.0
    gateway 10.94.4.1

EOF

ip addr flush dev eth0
ip addr add 10.94.4.2/22 dev eth0
ip link set eth0 up
ip route replace default via 10.94.4.1
