heck if nginx user exists, if not, create it
if ! id -u nginx &>/dev/null; then
	    useradd -r -M nginx
fi

# Update Nginx configuration to run as nginx user and listen on port 8080
nginx_conf="/etc/nginx/nginx.conf"

# Backup the original nginx.conf file
cp "$nginx_conf" "$nginx_conf.bak"

# Update nginx.conf to run Nginx as nginx user and listen on port 8080
sed -i 's/^user .*;/user nginx;/' "$nginx_conf"
sed -i 's/^listen .*;/listen 8080;/g' "$nginx_conf"

# Update default site configuration to listen on all active IPs
default_site_conf="/etc/nginx/sites-available/default"
sed -i 's/^.*listen 80 default_server;/\tlisten 8080 default_server;/g' "$default_site_conf"

# Restart Nginx to apply changes
service nginx restart

echo "Nginx is now configured to run as the nginx user and listen on port 8080."

