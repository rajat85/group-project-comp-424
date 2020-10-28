
#!/bin/bash


echo "Pulling the code from GIT repo https://github.com/rajat85/group-project-comp-424"
#pull the repo
cd /home/ubuntu/424project
git pull https://github.com/rajat85/group-project-comp-424


echo "Setting up the databse"
# Create DB and User
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS group_project_comp_424_development;
CREATE USER IF NOT EXISTS 'ubuntu@localhost' IDENTIFIED BY 'comp424';
GRANT ALL PRIVILEGES ON group_project_comp_424_development.* TO 'ubuntu'@'localhost' IDENTIFIED BY 'comp424';
FLUSH PRIVILEGES;
exit
EOF


echo "Building the application"
# setup the server
cd group-project-comp-424/
bundle


echo "Migrating the database"
#create/migrate
rails db:migrate

echo "Starting the server"
#start the server
rails server



