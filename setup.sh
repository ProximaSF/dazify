#!/bin/bash
sudo yum install -y nodejs httpd

npm init -y
npm install express ejs mysql2 dotenv nodemon


echo "Packages installed!"