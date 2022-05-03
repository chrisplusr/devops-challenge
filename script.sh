sudo apt-get update 
sudo apt-get upgrade -y

## Install Apache
sudo apt install apache2 -y
sudo ufw allow 8000
sudo ufw allow "Apache Full"
sudo systemctl start apache2
sudo systemctl enable apache2

sudo sed -i'' 's/Listen 80/Listen 127.0.0.1:8000/g' /etc/apache2/ports.conf
sudo sed -i'' 's/*:80/*:127.0.0.1:8000/g' /etc/apache2/ports.conf
sudo sed -i'' 's/*:80/127.0.0.1:8000/g' /etc/apache2/sites-available/000-default.conf


sudo systemctl restart apache2
sudo apt-get update 

## Install nginx
sudo apt-get install nginx -y
sudo ufw allow "Nginx HTTP"
sudo systemctl start nginx
sudo systemctl enable nginx

sudo mv /tmp/desafio.conf /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/desafio.conf /etc/nginx/sites-enabled/

## Install Docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt install docker-ce -y
sudo usermod -aG docker ubuntu

## Install Docker-compose
sudo curl -SL https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo mkdir ~/compose-wordpress && cd ~/compose-wordpress
sudo mv /tmp/docker-compose.yml ~/compose-wordpress/
sudo docker-compose up -d

sudo systemctl restart nginx
sudo systemctl restart apache2