#!/bin/bash 
sudo wget -qO- https://get.docker.com/ | sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
wget https://projetoformacaosrelumr921298290312.s3.us-west-1.amazonaws.com/prometheus_grafana.zip
sudo apt install unzip -y
unzip prometheus_grafana.zip
cd prometheus_grafana
sudo docker network create monitoring
sudo /usr/local/bin/docker-compose up -d