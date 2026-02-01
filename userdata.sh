#!/bin/bash
sudo echo "server.port=${APPLICATION_PORT}" >> /home/csye6225/webapp/userdata.properties
sudo echo "spring.datasource.url=jdbc:mysql://${IP_ADDRESS}/${DB_NAME}" >> /home/csye6225/webapp/userdata.properties
sudo echo "spring.datasource.username=${USERNAME}" >> /home/csye6225/webapp/userdata.properties
sudo echo "spring.datasource.password=${PASSWORD}" >> /home/csye6225/webapp/userdata.properties
sudo echo "spring.datasource.driverClassName=com.mysql.cj.jdbc.Driver" >> /home/csye6225/webapp/userdata.properties
sudo echo "spring.profiles.active=${SPRING_ACTIVE_PROFILES}" >> /home/csye6225/webapp/userdata.properties
sudo echo "spring.mvc.converters.preferred-json-mapper=gson" >> /home/csye6225/webapp/userdata.properties
sudo echo "spring.cloud.gcp.pubsub.enabled=false" >> /home/csye6225/webapp/userdata.properties
sudo echo "spring.cloud.gcp.core.enabled=false" >> /home/csye6225/webapp/userdata.properties
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/tmp/cloudwatch_config.json -s
sudo systemctl daemon-reload
sudo systemctl restart amazon-cloudwatch-agent
sudo systemctl start webapp.service
sudo systemctl enable webapp.service