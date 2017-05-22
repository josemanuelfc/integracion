fecha=$(date +%H.%M_%d_%m_%Y)
mkdir -p /SOFTWARE/backup_client_tsm_linux_${fecha}
cp /opt/tivoli/tsm/client/ba/bin/*.opt  /SOFTWARE/backup_client_tsm_linux_${fecha}
cp /opt/tivoli/tsm/client/ba/bin/*.sys  /SOFTWARE/backup_client_tsm_linux_${fecha}
cp  /opt/tivoli/tsm/client/ba/bin/backup* /SOFTWARE/backup_client_tsm_linux_${fecha}
cp /opt/tivoli/tsm/client/ba/bin/dsm*.log /SOFTWARE/backup_client_tsm_linux_${fecha}
ls -altr /SOFTWARE/backup_client_tsm_linux_${fecha}
