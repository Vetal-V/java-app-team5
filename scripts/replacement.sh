#!/bin/bash

file='web.xml'
hostip='prd-sqlserver-eastus-crashcourse.database.windows.net'
dbname='prd-sqldb-eastus-crashcourse'
user='LOGINVALUE'
password='PASSWORDVALUE'

sed -i "s/host-ip-value/$hostip/" $file
sed -i "s/dbname-value/$dbname/" $file
sed -i "s/user-value/$user/" $file
sed -i "s/password-value/$password/" $file
