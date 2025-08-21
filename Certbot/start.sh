#!/bin/bash

# Aguardar o Nginx iniciar
echo "Aguardando Nginx iniciar..."
sleep 15

# Parar o Nginx temporariamente para usar modo standalone
echo "Parando Nginx para obter certificados..."
docker stop nginx

# Obter certificados usando modo standalone
echo "Obtendo certificados SSL..."
certbot certonly --standalone \
    -d sctiuenf.com.br \
    --email "$EMAIL" \
    --non-interactive \
    --agree-tos \
    --force-renewal

# Reiniciar o Nginx
echo "Reiniciando Nginx..."
docker start nginx

# Iniciar cron em segundo plano
echo "Iniciando agendador de renovação..."
crond -f

# Manter o container rodando
tail -f /var/log/cron.log
