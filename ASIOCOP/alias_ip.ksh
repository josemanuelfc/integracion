#!/bin/ksh
#
mkdir -p /var/log/bbdd_alias_ip 
fecha=$(date +%d_%m_%Y)
LOG=/var/log/alias_ip_bbdd/alias_ip_bbdd_${fecha}.log
echo " " >> ${LOG}
echo " " >> ${LOG}
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> ${LOG}
date >> ${LOG}
hist=`echo $HISTFILE`
echo "Historial --> $hist" >> ${LOG}
usuario=`who am i`
echo "Usuario --> ${usuario}" >> ${LOG}
ip_activo=172.23.226.67
ip_standby=172.23.226.68
ip_input=$2
echo "${ip_input}"|grep -E "ip_activo|ip_standby"  > /dev/null 2>&1
if [ $? != 0 ]
then
echo "@@@@@@@@ ERROR, la ip introducida (  ${ip_input} )tienen que ser ip_activo o ip_standby literalmente, siendo cada una:"|tee -a ${LOG}
echo "ip_activo: ${ip_activo}"
echo "ip_standby: ${ip_standby}"
echo "-----------------------------------------------------------------"
echo "Ejecutar el script como: : $0 [up|down] [ip_activo|ip_standby]  "
echo "-----------------------------------------------------------------"
echo "Ejemplo: ./alias_ip up ip_activo"
exit
fi

case "$2" in
ip_activo)
ip_input=172.23.226.67
;;

ip_standby)
ip_input=172.23.226.68
;;

esac

case "$1" in

up)
 ip a|grep -w eth1:0 > /dev/null 2>&1
 if [ $? = 0 ]
 then
   echo "@@@@@@@@ ERROR, ya hay una ip (activa o standby)  levantada en esta maquina, Bajar la ip antes de levantar otra"|tee -a ${LOG}
   echo "----------------------------------------------------------------------------------------------"|tee -a ${LOG}
   ip a|grep inet|grep -E "${ip_activo}|${ip_standby}"|tee -a ${LOG}
   echo "----------------------------------------------------------------------------------------------"|tee -a ${LOG}
   exit
 else 
   ping -w 1 ${ip_input} > /dev/null 2>&1
  if [ $? = 0 ]
  then
   echo "@@@@@@@@ ERROR, ya hay una ip (activa o standby)  levantada en esta maquina o la otra" |tee -a ${LOG}
   echo "Bajar la ip donde este levantada antes de levantarla en esta"|tee -a ${LOG}
   echo "----------------------------------------------------------------------------------------------"|tee -a ${LOG}
   ip a|grep inet|grep -E "${ip_activo}|${ip_standby}"|tee -a ${LOG}
   echo "----------------------------------------------------------------------------------------------"|tee -a ${LOG}
   exit
  else
   echo "Levantando la ip ${ip_input} en la interfaz eth1:0"|tee -a ${LOG}
   ip addr add ${ip_input}/24 brd + dev eth1 label eth1:0|tee -a ${LOG}
  fi
 fi
 ;;

down)
   ip a | grep -w inet|grep -w ${ip_input}  > /dev/null 2>&1
   if [ $? = 0 ]
   then
   echo "Bajando la ip ${ip_input} de la interfaz eth1:0"|tee -a ${LOG}
   echo "----------------------------------------------------------------------------------------------"|tee -a ${LOG}
   ip a|grep inet|grep -E "${ip_activo}|${ip_standby}"|tee -a ${LOG}
   echo "----------------------------------------------------------------------------------------------"|tee -a ${LOG}
   ip addr delete ${ip_input}/24 dev eth1|tee -a ${LOG}
   else 
   echo "@@@@@@@@ ERROR, la ip ${ip_input} no esta levantada en esta máquina"|tee -a ${LOG}
   fi
;;

*)
    echo "usage: $0 [up|down]  [ip_activo|ip_standby]  "|tee -a ${LOG}
;;
esac
