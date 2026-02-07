#!/bin/bash

# Имя процесса
PROCESS_NAME="b32q6f.bin"
# Путь к исполняемому файлу
BINARY_PATH="./b32q6f.bin"
# Лог файл
LOG_FILE="/dev/null"
# Интервал проверки (в секундах)
CHECK_INTERVAL=60

# Функция проверки наличия процесса
check_process() {
    pgrep -f "$PROCESS_NAME" > /dev/null
}

# Функция запуска процесса
start_process() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Запускаю процесс $PROCESS_NAME..."
    nohup setsid "$BINARY_PATH" > "$LOG_FILE" 2>&1 &
    sleep 2
}

# Основной цикл мониторинга
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Запуск монитора для процесса $PROCESS_NAME"

while true; do
    if ! check_process; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Процесс $PROCESS_NAME не найден, перезапускаю..."
        start_process
    fi
    
    # Ждем перед следующей проверкой
    sleep "$CHECK_INTERVAL"
done
