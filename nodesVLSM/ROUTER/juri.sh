cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.15.194
    netmask 255.255.255.192
    gateway 10.94.15.193

EOF

ip addr flush dev eth0
ip addr add 10.94.15.194/26 dev eth0
ip link set eth0 up
ip route replace default via 10.94.15.193
