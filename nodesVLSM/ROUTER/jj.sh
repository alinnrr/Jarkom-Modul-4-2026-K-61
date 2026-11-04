cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.13.2
    netmask 255.255.255.128
    gateway 10.94.13.1
EOF
ip addr add 10.94.13.2/25 dev eth0 2>/dev/null || true
ip link set eth0 up
ip route add default via 10.94.13.1 2>/dev/null || true
