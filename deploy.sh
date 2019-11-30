export app_name=react-test-app
sudo apt-get update
sudo apt-get install -y build-essential openssl libssl-dev pkg-config
sudo apt-get install -y nodejs nodejs-legacy
sudo apt-get install npm -y
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
sudo apt-get install nginx git -y
sudo git clone https://github.com/honoka428/$app_name.git /var/www/$app_name
sudo apt-get install -y build-essential openssl libssl-dev pkg-config
sudo cp $HOME/qualcat_deploy/nginx_conf /etc/nginx/sites-available/$app_name
sudo rm /etc/nginx/sites-available/default
sudo ln -s /etc/nginx/sites-available/$app_name /etc/nginx/sites-enabled/$app_name

sudo rm /etc/nginx/sites-enabled/default
sudo npm install pm2 -g
(cd /var/www/ && sudo chown -R ubuntu $app_name)
(cd /var/www/$app_name && sudo npm install)

(cd /var/www/$app_name/views && sudo npm install)
(cd /var/www/$app_name/views && sudo npm run build)
(cd /var/www/$app_name && pm2 start server.js)
sudo service nginx stop && sudo service nginx start

# Need to run buld and start on both server and client??