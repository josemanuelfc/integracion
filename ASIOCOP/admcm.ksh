#!/bin/ksh
#
ls -ld /home/admcm|grep root > /dev/null 2>&1
if [ $? = 0 ]
then
chattr -i /home/admcm/.kshrc
chattr -i /home/admcm/.bashrc
chown -R admcm:gcontent /home/admcm
chattr +i /home/admcm/.kshrc
chattr +i /home/admcm/.bashrc
fi
