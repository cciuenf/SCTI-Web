FROM nginx:alpine

# Instalar dependências necessárias
RUN apk add --no-cache bash

# Copiar configurações
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-no-ssl.conf /etc/nginx/nginx-no-ssl.conf
COPY nginx-with-ssl.conf /etc/nginx/nginx-with-ssl.conf
COPY entrypoint.sh /entrypoint.sh

# Tornar entrypoint executável
RUN chmod +x /entrypoint.sh

EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
