cat << 'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.94.16.35
    netmask 255.255.255.248
    up ip route replace default via 10.94.16.33

auto eth1
iface eth1 inet static
    address 10.94.10.1
    netmask 255.255.254.0

auto eth2
iface eth2 inet static
    address 10.94.15.193
    netmask 255.255.255.192

EOF

sysctl -w net.ipv4.ip_forward=1
grep -q '^net.ipv4.ip_forward=1' /etc/sysctl.conf || echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf

ip addr flush dev eth0
ip addr add 10.94.16.35/29 dev eth0
ip link set eth0 up
ip addr flush dev eth1
ip addr add 10.94.10.1/23 dev eth1
ip link set eth1 up
ip addr flush dev eth2
ip addr add 10.94.15.193/26 dev eth2
ip link set eth2 up
ip route replace default via 10.94.16.33
