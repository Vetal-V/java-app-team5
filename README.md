# Deploying Java Application 
Crash Course Devops: team #5  
--------------------------
## Infrastructure 
tf_vms - creating main infrastructure in Azure Cloud Service

- resource group 
- virtual network
- subnet
- public IPs
- network security group
- network interface
- virtual machines

tf_sqlserver - adding Microsoft Azure SQL Server to infrastructure
- Database: prd-crashdb-rg-eastus-crashcourse
- firewall_rule
- storage_account

monitor_tf - adding monitoring to infrastructure
- monitor_action_group
- email_receivers
- monitor_metric_alert
- dashboard

## Vms configuration - Ansible playbooks 
ansible_haproxy
Load balancer auto-configuration

ansible_tomcat:
- JDK 11
- Tomcat 9

## Jenkins Pipelines
- jenkinsfile1-terraform - main infrastructure 
- jenkinsfile2-terraform - Database and IP's
- jenkinsfile-ansible - ansible structurized plan 
- jenkinsfile-monitor 
- jenkinsfile-app - deploying Java app
 
 ## App
 
 Files for building JSP-app for end-user
 Registration and Entering form connected with SQL-database
 
 ## Scripts 
 
 Shell scripts for backup and restoring database
 
 ## haproxy.cfg
 
 Configuration file for HAproxy load balancer.
 
 ## License
[CC0 1.0] (https://creativecommons.org/publicdomain/zero/1.0/deed.ru)
