#!/bin/bash
sudo apt update && sudo apt install curl ansible unzip -y
cd /tmp
sudo wget https://projetoformacaosrelumr921298290312.s3.us-west-1.amazonaws.com/ansible.zip 
unzip ansible.zip -d /tmp
cd /tmp/ansible/
sudo ansible-playbook playbook.yml \
--extra-vars "wp_db_name=${wp_db_name} wp_username=${wp_username} wp_user_password=${wp_user_password} wp_db_host=${wp_db_host}"
wget https://projetoformacaosrelumr921298290312.s3.us-west-1.amazonaws.com/node_exporter.sh
sh node_exporter.sh
