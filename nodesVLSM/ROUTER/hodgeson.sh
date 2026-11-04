cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.15.242
    netmask 255.255.250.240
    gateway 10.94.15.129
EOF
ip addr add 10.94.15.242/28 dev eth0 2>/dev/null || true
ip link set eth0 up
ip route add default via 10.94.15.129 2>/dev/null || true
