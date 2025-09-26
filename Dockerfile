FROM ubuntu:22.04

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    apache2 \
    curl \
    jq \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copiar scripts
COPY check_repo.sh /usr/local/bin/check_repo.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/check_repo.sh /usr/local/bin/entrypoint.sh

# Exponer Apache
EXPOSE 80

# Usar entrypoint como arranque
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
