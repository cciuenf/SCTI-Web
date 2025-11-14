#!/bin/bash

# Configuração inicial sem SSL
cp /etc/nginx/nginx-no-ssl.conf /etc/nginx/nginx.conf

# Iniciar Nginx em background
nginx -g "daemon off;" &
NGINX_PID=$!

# Função para verificar certificados
check_certificates() {
    if [ -f "/etc/letsencrypt/live/sctiuenf.com.br/fullchain.pem" ] && [ -f "/etc/letsencrypt/live/sctiuenf.com.br/privkey.pem" ]; then
        echo "Certificados SSL encontrados. Atualizando configuração..."
        cp /etc/nginx/nginx-with-ssl.conf /etc/nginx/nginx.conf
        nginx -s reload
        echo "Nginx atualizado com configuração SSL"
        return 0
    fi
    return 1
}

if [ "$SSL_ENABLED" = "true" ]; then
    echo "SSL enabled, waiting for certificates..."
    # Verificar certificados a cada 10 segundos
    while true; do
        if check_certificates; then
            break
        fi
        sleep 10
    done
fi

# Manter o container rodando
wait $NGINX_PID
