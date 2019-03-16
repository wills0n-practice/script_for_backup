#!/bin/bash
 


ROPT="-v -az --delete"
 
#Перенос директорий с настройками Zabbix Appache 
rsync $ROPT /etc/zabbix/ /home/zabbixadmin/backup/zabbix_server/etc_zabbix
rsync $ROPT /usr/share/zabbix/ /home/zabbixadmin/backup/zabbix_server/usr_share_zabbix
rsync $ROPT /etc/httpd/ /home/zabbixadmin/backup/zabbix_server/etc_httpd
#rsync $ROPT /etc/letsencrypt/ /backup/zabbix_server/etc_letsencrypt

#Остановка сервиса Zabbix
systemctl stop zabbix-server
sleep 3

#Дамп БД
mysqldump -uzabbix -p31832312 zabbix > /home/zabbixadmin/backup/zabbix_server/`date +%d-%m-%Y`.zabbix.sql

#Запуск сервиса Zabbix
service zabbix-server start

#Создание архива 
tar -czvf /home/zabbixadmin/backup/`date +%d-%m-%Y`.zabbix_server.tar.gz  /home/zabbixadmin/backup/zabbix_server
