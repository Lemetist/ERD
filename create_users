#!/bin/bash

# Укажите учетные данные MySQL
MYSQL_USER="root"
MYSQL_PASSWORD="anakin11"

# Функция для генерации случайного пароля
generate_password() {
  tr -dc 'A-Za-z0-9' </dev/urandom | head -c 6
}

# Создаем 11 пользователей, 11 баз данных и таблицу для хранения данных
for i in $(seq 1 11); do
  # Создаем пароль для каждого пользователя
  password=$(generate_password)

  # Создаем пользователя и базу данных
  mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "CREATE DATABASE RouteDB$i;"
  mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "CREATE USER 'captain$i'@'localhost' IDENTIFIED BY '$password';"
  mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "GRANT ALL PRIVILEGES ON RouteDB$i.* TO 'captain$i'@'localhost';"
  mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "REVOKE CREATE, DROP ON RouteDB$i.* FROM 'captain$i'@'localhost';"
  mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "FLUSH PRIVILEGES;"

  # Заполним таблицу Users (создадим ее если не существует)
  if [ $i -eq 1 ]; then
    mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "CREATE DATABASE IF NOT EXISTS DB;"
    mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "CREATE TABLE IF NOT EXISTS DB.Users (username VARCHAR(50), password TEXT);"
  fi

  # Вставим пользователя и его зашифрованный пароль
  encrypted_password=$(echo -n "$password" | sha256sum | awk '{print $1}')
  mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "INSERT INTO DB.Users (username, password) VALUES ('captain$i', '$encrypted_password');"
done

echo "Пользователи и базы данных созданы успешно!"
