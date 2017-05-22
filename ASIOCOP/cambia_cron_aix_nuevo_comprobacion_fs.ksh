#!/bin/ksh
#
fecha=$(date +%H.%M_%d_%m_%Y)
cp /var/spool/cron/crontabs/root /var/spool/cron/crontabs/root_${fecha}
sed 's/30 0 \* \* 0 \/home\/admin\/scripts\/comprobar_fs_sist/30 0 \* \* 1,3,5 \/home\/admin\/scripts\/comprobar_fs_sist_aix/g' /var/spool/cron/crontabs/root > /tmp/cron_nuevo.txt 
mv /tmp/cron_nuevo.txt /var/spool/cron/crontabs/root
cat /var/spool/cron/crontabs/root|grep comprobar_fs_sist
