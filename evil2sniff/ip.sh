echo 1 > /proc/sys/net/ipv4/ip_forward
iptables --table nat --append POSTROUTING --out-interface eth0 -j MASQUERADE
iptables -F
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t nat -F
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P INPUT ACCEPT
iptables -t nat -P OUTPUT ACCEPT
iptables -t nat -P POSTROUTING ACCEPT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables --append FORWARD --in-interface eth0  -j ACCEPT
iptables -A FORWARD -p tcp --dport 80 -j ACCEPT
iptables -A FORWARD -p tcp --dport 443 -j ACCEPT
iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.1.4:80
iptables -t nat -A PREROUTING -p tcp --dport 443 -j DNAT --to-destination 192.168.1.4:80
iptables -t nat -A POSTROUTING -j MASQUERADE
