#!/bin/bash
HTTP_PORT="3128"
echo "Entering Cron upxl Step 1 " >> /tmp/read2.txt
if [ -e /tmp/getuoff.lock ] ; then 
	echo "Leaving Cron Job Update already running" >> /tmp/read2.txt
	exit 0 
fi
## importing rate
touch /tmp/getuoff.lock
me=`date "+%d-%H-%M"`
if [ ! -d /tmp/crontabs ] ; then 
   mkdir /tmp/crontabs
fi
cd /tmp/crontabs
/bin/cp /tmp/read.txt /tmp/read.txt.$me
echo '' > /tmp/read.txt
/bin/rm -f *
for t in `cat /tmp/read.txt.$me | grep -i 'not found locally' | grep -i -v -E 'pokerstars|primary.xml|\?|\=|\[|\%|\*|\&|\.tif|rapidshare|\.wmv|\.avi|\.mpg|\.wmv|\.mp4|\.vpu'| /usr/local/bin/gawk '{print $1}' | sort -u` ; do 
	n="$t"
	echo -e "Fetching File \e[35m$n\e[0m"
	t=${t//http\:\/\//}
	# check if the file is currently in cache 
	if [ -e /cache/data/$t ] ; then 
		echo " Object $t already in cache " >> /tmp/read2.txt
	else 
		echo -e "\e[32m$t \e[33m$n\e[0m" >> /tmp/read2.txt
		firstround=`echo $t | sed -ne 's/\// /gp' | /usr/local/bin/gawk '{print $NF}'`
		secondround=`echo $t | sed -ne "s/$firstround//gp"`
		/usr/local/bin/wget -S -c -t 8 --dns-timeout=12 --connect-timeout=120 --read-timeout=140 "$n" 2>/tmp/wget.log
		success=$?
		if [[ $success == "0" ]] ; then 
			echo "Success is on " >> /tmp/read2.txt
			mkdir -p "/cache/data/${secondround}"
			/bin/mv -f * "${firstround}"
			/bin/mv -f "${firstround}" "/cache/data/${secondround}"
			/usr/sbin/chown -R www-data:www-data "/cache/data/${secondround}"
			/bin/rm -f ./*
			squidclient -p ${HTTP_PORT} -m PURGE -s "${n}"
		fi
		sleep 0.01s
	fi
done
echo "Leaving Key level 1" >> /tmp/read2.txt
/bin/rm -f /tmp/getuoff.lock	
cd -

