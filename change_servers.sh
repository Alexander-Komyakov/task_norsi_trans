#!/usr/bin/bash

addresses_servers=("192.168.1.145" "127.0.0.1")
user_name="user01"
find_user_connect="user01"
command_check_connect="journalctl --since "2023-01-20" -u sshd | grep "$find_user_connect
path_to_iptables="/etc/sysconfig/iptables"
path_to_nftables="/etc/nftables.conf"
command_check_change_iptables="stat "$path_to_iptables" | head -7 | tail +7 | grep 2023-01-20 "
command_check_change_nftables="stat "$path_to_nftables" | sed -n '7p' | grep 2023-01-20 "
for i in ${addresses_servers[*]}
do
	resultCheck=$(ssh $user_name@$i $command_check_connect)
	if [[ ! -z $resultCheck ]]; then
		echo "USER: " $find_user_connect " connecting to server " $i >> $find_user_connect\_log.txt
		iptab_change_bool=$(ssh $user_name@$i $command_check_change_iptables)
		if [[ ! -z $iptab_change_bool ]]; then
			echo "USER: " $find_user_connect " change IPtables in server: " $i >> $find_user_connect\_log.txt
		fi
		nftab_change_bool=$(ssh $user_name@$i $command_check_change_nftables)
		if [[ ! -z $nftab_change_bool ]]; then
			echo "USER: " $find_user_connect " change NFtables in server: " $i >> $find_user_connect\_log.txt
		fi
	fi
done
