#!/bin/bash

file='web.xml'
hostip='HOSTVALUE'
dbname='DBNAMEVALUE'
user='LOGINVALUE'
password='PASSWORDVALUE'

sed -i "s/host-ip-value/$hostip/" $file
sed -i "s/dbname-value/$dbname/" $file
sed -i "s/user-value/$user/" $file
sed -i "s/password-value/$password/" $file
