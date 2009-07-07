#!/bin/bash
HTTP_PORT=3128
LIGHT_HTTPD="213.255.229.141:81"
while (true) ; do 
	read -a uri
	stripped="${uri[0]}"
	if [[ ${#uri} == 0 ]] ; then 
		echo -e ${uri[0]}"\e[37m Empty String\e[0m" >> /tmp/read.txt
		exit 0
	else
		if [[ "${uri[0]}" =~ \.(dwg|upd|tar|mp4|mp4u|vpu|dmg|msi|cfm|avi|avc|kfb|rup|dif|flv|png|jpg|bmp|mpg|gif|giff|cab|exe|zip|mp3|wmv|jpe|tiff|mov|wav|ps|psf|pdf|gz|bz2|deb|tgz|rpm|rm|ram|rar|bin|jpg)$ ]] ; then 
			stripped=${stripped//http:\/\//''}
			if [ -e '/cache/data/'$stripped ] ; then 
				#echo -e "http://127.0.0.1/$stripped" >> /tmp/read.txt
				echo -e "302:http://${LIGHT_HTTPD}/$stripped"
			else
				echo -e "${uri[0]}  not found locally" >> /tmp/read.txt
				echo -e "${uri[0]}"
			fi
		else
			echo "${uri[0]} not our file">> /tmp/read.txt
			echo "${uri[0]}"
		fi
	fi
#	sleep 0.01s
done


