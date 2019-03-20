#!/bin/bash
 


ROPT="-v -az --delete"
 
#Перенос директорий с настройками Zabbix Appache 
rsync $ROPT /etc/zabbix/ /mnt/backup_zabbix/etc_zabbix
rsync $ROPT /usr/share/zabbix/ /mnt/backup_zabbix/usr_share_zabbix
rsync $ROPT /etc/httpd/ /mnt/backup_zabbix//etc_httpd
#rsync $ROPT /etc/letsencrypt/ /backup/zabbix_server/etc_letsencrypt

#Остановка сервиса Zabbix
systemctl stop zabbix-server
sleep 3

#Дамп БД
mysqldump -uzabbix -p31832312 zabbix > /mnt/backup_zabbix/`date +%d-%m-%Y`.zabbix.sql

#Запуск сервиса Zabbix
service zabbix-server start

#Создание архива 
tar -czvf /mnt/backup_zabbix/`date +%d-%m-%Y`.backup_zabbix.tar.gz  /mnt/backup_zabbix/
