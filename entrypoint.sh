#!/bin/bash
set -e

# Verificar commits antes de arrancar Apache
if /usr/local/bin/check_repo.sh; then
    echo "🚀 Iniciando Apache..."
    exec apachectl -D FOREGROUND
else
    echo "❌ Aplicación bloqueada por falta de actualización en GitHub."
    exit 1
fi
