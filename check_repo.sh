#!/bin/bash
set -e

# Configuración
REPO="Cuabu/Didi-server"
API_URL="https://api.github.com/repos/$REPO/commits"

if [ -z "$GITHUB_TOKEN" ]; then
  echo "❌ No se definió la variable de entorno GITHUB_TOKEN"
  exit 1
fi

echo "🔍 Verificando últimas actualizaciones en $REPO..."

# Consultar API de GitHub con autenticación
LAST_COMMIT_DATE=$(curl -s \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "User-Agent: DockerCheck" \
  "$API_URL" | jq -r '.[0].commit.committer.date')

if [ "$LAST_COMMIT_DATE" == "null" ] || [ -z "$LAST_COMMIT_DATE" ]; then
  echo "❌ No se pudo obtener la fecha del último commit"
  exit 1
fi

# Convertir fechas
LAST_COMMIT_UNIX=$(date -d "$LAST_COMMIT_DATE" +%s)
NOW_UNIX=$(date +%s)
DIFF=$(( (NOW_UNIX - LAST_COMMIT_UNIX) / 3600 ))

echo "📅 Último commit: $LAST_COMMIT_DATE ($DIFF horas atrás)"

if [ $DIFF -gt 24 ]; then
  echo "⛔ El repositorio no se ha actualizado en más de 24h. Bloqueando Apache..."
  exit 1
else
  echo "✅ El repo está actualizado. Apache puede iniciar."
fi
