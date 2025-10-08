

AWS LightSail website setup for **Ubunto** distro from personal website temp.


## 1. Update Console and install Nginx Server (not Apache)

### Update server console:
- `sudo apt update -y`

### Setting Up Nginx
**<u>nginx</u>** ("_engine x_") is an HTTP web server, reverse proxy, content cache, load balancer, TCP/UDP proxy server, and mail proxy server.
- Light weight and fast
- Allows multiple instance connections

#### Step 1: install nginx
```bash 
sudo apt install nginx -y
```

#### Step 2: Setup nginx automatic on bootup
```bash
sudo systemctl enable nginx
```
- Make nginx start automatic when the server/computer boots up

#### Step 3: Start nginx
```bash
sudo systemctl start nginx
```
- Check nginx is running:
	```bash
	sudo systemctl status nginx
	```

```bash
curl -I http://127.0.0.1
```
- Quick check that Nginx answers locally (should return `200 OK`).

#### Step 4: Open http and https port so server is reachable
```bash
sudo ufw allow OpenSSH       # keep SSH access else wont able to access server
sudo ufw allow 'Nginx Full'
```
- `'Nginx Full'` profile within UFW corresponds to a predefined set of rules that open both HTTP (port 80) and HTTPS (port 443) ports. This allows web browsers and other clients to connect to your Nginx server over both unencrypted and encrypted connections.

- Enable and reload the firewall to apply changes
	```bash
	sudo ufw enable
	sudo ufw reload
	```

- Check firewall status
	```bash
	sudo ufw status
	```
#### Step 5: Config server and website 
```bash
sudo nano /etc/nginx/sites-available/dazify.conf
```

Server config setup
```txt
server {
  listen 80;
  server_name yourdomain.com;

  location / {
    proxy_pass http://127.0.0.1:3000;
    proxy_http_version 1.1;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
  }
}
```
- If there is no domain name yet, replace `serveer_name` field with _
	- It will match and connect all catch requests

Check for syntax error:
```bash
sudo nginx -t
```


#### Step 6: Enable site
```bash
sudo ln -s /etc/nginx/sites-available/dazify /etc/nginx/sites-enabled/
```


#### Step 7: Reload Nginx
```bash
sudo systemctl reload nginx
```


#### Step 8: Install node and pw2

```bash
sudo apt -y install nodejs npm
sudo npm i -g pm2
```

#### Step 9: Start server

Make sure inside the website directory
```bash
pm2 start server.js
```

#### Step 10: Install required packages for the site to work

Make sure inside of site package
```bash
npm install ejs
npm install nodemon
npm install dotenv

...
```


