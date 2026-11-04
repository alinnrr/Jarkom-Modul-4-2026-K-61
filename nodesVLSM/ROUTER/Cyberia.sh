cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
    up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

auto eth1
iface eth1 inet static
    address 10.94.16.57
    netmask 255.255.255.252
    up ip route add 10.94.0.0/16 via 10.94.16.58

auto eth2
iface eth2 inet static
    address 10.94.13.1
    netmask 255.255.255.128
EOF

sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
ip addr add 10.94.16.57/30 dev eth1 2>/dev/null || true
ip link set eth1 up
ip addr add 10.94.13.1/25 dev eth2 2>/dev/null || true
ip link set eth2 up
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE 2>/dev/null || true
udhcpc -i eth0 2>/dev/null || true