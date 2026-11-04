cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.14.194
    netmask 255.255.255.192
    gateway 10.94.16.117
EOF
ip addr add 10.94.14.194/26 dev eth0 2>/dev/null || true
ip link set eth0 up
ip route add default via 10.94.16.117 2>/dev/null || true
