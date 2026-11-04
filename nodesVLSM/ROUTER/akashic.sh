cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.16.42
    netmask 255.255.255.248
    gateway 10.94.16.41
EOF
ip addr add 10.94.16.42/29 dev eth0 2>/dev/null || true
ip link set eth0 up
ip route add default via 10.94.16.41 2>/dev/null || true
