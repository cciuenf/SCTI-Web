FROM alpine:latest

# Instalar dependências necessárias
RUN apk add --no-cache certbot curl docker-cli bash dcron

# Criar diretórios necessários
RUN mkdir -p /var/www/certbot /etc/letsencrypt

# Copiar scripts
COPY start.sh /usr/local/bin/start.sh
COPY renew-certs.sh /usr/local/bin/renew-certs.sh

# Tornar scripts executáveis
RUN chmod +x /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/renew-certs.sh

# Configurar cron para renovação às 2h da manhã todos os dias
RUN echo "0 2 * * * /usr/local/bin/renew-certs.sh >> /var/log/cron.log 2>&1" > /etc/crontabs/root

# Criar arquivo de log
RUN touch /var/log/cron.log

# Comando de inicialização
CMD ["/usr/local/bin/start.sh"]
