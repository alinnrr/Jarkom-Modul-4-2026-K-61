cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.16.50
    netmask 255.255.255.248
    gateway 10.94.16.49

EOF

ip addr flush dev eth0
ip addr add 10.94.16.50/29 dev eth0
ip link set eth0 up
ip route replace default via 10.94.16.49
