#!/bin/bash

echo "Verificando renovação de certificados..."
certbot renew --webroot -w /var/www/certbot --quiet

if [ $? -eq 0 ]; then
    echo "Certificados renovados com sucesso."
    # Recarregar configuração do Nginx
    docker exec nginx nginx -s reload
    echo "Nginx recarregado."
else
    echo "Nenhuma renovação necessária ou erro na renovação."
fi
