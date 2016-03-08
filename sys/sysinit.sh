echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

#to disable ipv6 or tcp6
#http://www.techrepublic.com/article/how-to-disable-ipv6-on-linux/
cat <<E_O_F>> /etc/sysctl.conf
net.ipv6.conf.lo.disable_ipv6 = 1
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
E_O_F

#to check
cat /proc/sys/net/ipv6/conf/all/disable_ipv6
