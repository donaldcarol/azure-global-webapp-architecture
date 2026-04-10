#!/bin/bash
set -e

apt-get update -y
apt-get install -y nginx

HOSTNAME_VALUE=$(hostname)

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>Azure Web App Demo</title>
</head>
<body>
  <h1>Azure Global Web App Architecture Demo</h1>
  <p>Served from instance: ${HOSTNAME_VALUE}</p>
</body>
</html>
EOF

systemctl enable nginx
systemctl restart nginx