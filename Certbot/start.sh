#!/bin/bash

# Aguardar o Nginx iniciar
echo "Aguardando Nginx iniciar para o desafio webroot..."
sleep 15

# Obter certificados via webroot (não para o Nginx)
echo "Obtendo/Verificando certificados SSL..."
certbot certonly --webroot -w /var/www/certbot \
    -d sctiuenf.com.br \
    --email "$EMAIL" \
    --non-interactive \
    --agree-tos \
    --quiet

# Iniciar cron em segundo plano para renovações futuras
echo "Iniciando agendador de renovação..."
crond -f &

# Manter o container rodando e exibir logs de renovação
tail -f /var/log/cron.log
