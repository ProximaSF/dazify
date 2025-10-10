# AWS LightSail Website Setup (Ubuntu)

Explains how to deploy a Node.js website on AWS Lightsail using **Ubuntu**, **Nginx**, **PM2**, and **MariaDB** with **SSL encryption**.

---

## 1. Update the Console and Install Nginx

Update the Server Console
```bash
sudo apt update -y
```

### Setting Up Nginx
**Nginx** ("_engine x_") is a high-performance HTTP web server, reverse proxy, content cache, and load balancer.

**benefits:**
- Lightweight and fast
- Handles multiple concurrent connections efficiently


Install Nginx
```bash
sudo apt install nginx -y
```
- The default configuration path is `/etc/nginx/sites-available/default` once installed


Enable Nginx on Boot
```bash
sudo systemctl enable nginx
```
- Ensures Nginx starts automatically when the server boots.


Start Nginx
```bash
sudo systemctl start nginx
```
- Starts the Nginx service immediately.


Check Nginx status:
```bash
sudo systemctl status nginx
```

Test if Nginx is responding:
```bash
curl -I http://127.0.0.1
```
- Should return a `200 OK` response.

---

## 2. Configure UFW Firewall (not required) 

UFW is a **local firewall** that runs inside the Linux instance. It controls inbound and outbound network traffic _on the instance itself_.
- For Lightsail, it is not required but adds an extra layer of protection.

Install and enable **UFW** (Uncomplicated Firewall):

```bash
sudo apt install ufw
sudo ufw allow OpenSSH # Make sure to run this else can't access instance via ssh if going to use ufw
sudo ufw allow 'Nginx Full'
```
- `'Nginx Full'` opens both **HTTP (port 80)** and **HTTPS (port 443)**.


Apply and verify changes:
```bash
sudo ufw enable
sudo ufw reload
sudo ufw status
```

---

## 3. Configure Nginx Website (HTTP)

Create a new Nginx config file:
```bash
sudo nano /etc/nginx/sites-available/dazify.conf
```

Add the following configuration:
```nginx
server {
  listen 80;
  listen [::]:80;
  server_name dazify.xyz www.dazify.xyz 123.123.123.12;

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

> If don’t have a domain name, use server’s IP address in `server_name`.

Enable the configuration:
```bash
sudo ln -s /etc/nginx/sites-available/dazify.conf /etc/nginx/sites-enabled/
```
- Switch to use the web server config instead of `default`

Test the configuration:
```bash
sudo nginx -t
```
- Should be based on the `.../server.conf`. If not sure, add a extra `{` at the beginning/end in `server.conf` and test the config. Should get and error with the file path it's in.

---

## 4. Install Node.js and PM2

```bash
sudo apt install -y nodejs npm
sudo npm install -g pm2
```

Start Node.js server:
```bash
pm2 start server.js
```

---

## 5. Install Required Node Packages

Inside the project directory:
```bash
npm init -y
npm install ejs
npm install nodemon
npm install dotenv
npm install express
npm install mysql2
```

---

## 6. Set Up the SQL Database (MariaDB)

Install MariaDB:
```bash
sudo apt install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
```

Secure the installation:
```bash
sudo mysql_secure_installation
```

Follow the prompts:
- Press Enter if there’s no root password.
- Set a root password.
- Switch to unix_socket authentication? **N**
- Remove anonymous users? **Y**
- Disallow root login remotely? **Y**
- Remove test database? **Y**
- Reload privilege tables? **Y**

Login to MariaDB:
```bash
sudo mariadb -u root -p
```

Then create database, tables, and insert any data.

---

## 7. Create a `.env` File

Inside project directory:

```bash
sudo nano .env
```

Add environment variables.

---

## 8. Enable HTTPS with SSL (Let’s Encrypt)

> Ensure the **domain name is configured** in your DNS provider (e.g., Namecheap) to point to the Lightsail public IP before getting an SSL certificate and changing `.../server.cong`.

### Install Certbot

```bash
sudo apt update
sudo apt install -y certbot python3-certbot-nginx
```

Edit Nginx configuration:
```bash
sudo nano /etc/nginx/sites-available/dazify.conf
```

Update the `server_name` line to include your domain:
```nginx
server {
  listen 80;
  listen [::]:80;
  server_name dazify.xyz www.dazify.xyz 44.202.179.192;

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

### Obtain the SSL Certificate

```bash
sudo certbot --nginx -d dazify.xyz -d www.dazify.xyz
```
- Certbot will automatically update the Nginx `.../server.conf` to enable HTTPS (port 443).

Auto renewal certificate
```bash
sudo certbot renew --dry-run
```

Check syntax and reload Nginx:
```bash
sudo nginx -t
sudo systemctl reload nginx
```

> Ensure HTTPS (port 443) is allowed in the AWS Lightsail **Networking** tab.
> **<u>VERY IMPORTANT‼️</u>**

---

## 9. Verify Domain and DNS

Check if domain points to the correct public IP:

```bash
ping dazify.xyz
```
- Should show website public IP address

- If changed ip address is different, it could be the address is being updated (can take a bit)
	- Happens if IP addresses was assigned and changed multiple times based on the domain name on the provider (NameCheap)
		- Takes Namecheap or other services time to update to match the domain to IP address
	- Once updated, rerun and renew cert:
		```bash
		sudo certbot --nginx -d dazify.xyz -d www.dazify.xyz
		```
		- Depending how much cert was created based on the domain name, might need to wait to request a new cert. 
			- Required so the domain name cret is based on the ip address being used

If sites still not being loaded, check `Debug  4-6`

---


# Debugging

### 1. Check Server Logs

```bash
pm2 logs
```

### 2. Flush PM2 Logs

```bash
pm2 flush
```

### 3. Test Nginx Config

```bash
sudo nginx -t
```

### 4. Check HTTP/HTTPS Responses

```bash
curl -I http://dazify.xyz
curl -I http://www.dazify.xyz
curl -I http://44.202.179.192
```
- Should return `200` or `301`.
- If HTTPS fails, ensure port 443 is open in your firewall.

### 5. Verify DNS Records

```bash
nslookup dazify.xyz
nslookup www.dazify.xyz
```
- The `Address` should match Lightsail public IP, similar when doing `ping`
  
### 6. Clear Local DNS and Browser Cache

If DNS records are correct but browser still shows an old version or unable to connect even after setting up firewall in AWS:

```powershell
ipconfig /flushdns
```

Then close and reopen your browser, and clear its cache.


---
# Common Issues Faced

1. Using Nginx default conf path instead of the one made for the server `.../server.conf`
	- Fix by changing Nginx config path

2. Firewall rule not enabled on AWS Lightsail networking config.
	- Fixed after adding HHTPS 443 rule in Lightsail networking config tab

3. DNS Record and Reponses are correct but browser still unable to connect
	- Slightly fixed after resetting browser cache

4. SQL promises not working
	- Fixed after installing the right npm packages within the project directory 

5. Unable to access the instance after setting up ufw and exiting instance
	- Added ssh rule for ufw

   
