/bin/ash

if [ ! -f /etc/auth_server/ssl/certificate.crt ]
then
  openssl genrsa -out /etc/auth_server/ssl/private.key 4096 -nodes
  openssl req -new -x509 -key /etc/auth_server/ssl/private.key -sha256 -config /etc/ssl/ssl_gen.cnf -out /etc/auth_server/ssl/certificate.crt -days 36500
fi

/usr/local/bin/auth_server /etc/auth_server/auth.yml
