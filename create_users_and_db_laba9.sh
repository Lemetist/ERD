#!/bin/bash

# Функция для генерации случайного пароля
generate_password() {
  tr -dc 'A-Za-z0-9' </dev/urandom | head -c 6
}

# Создаем 11 пользователей, 11 баз данных и таблицу для хранения данных
for i in $(seq 1 11); do
  # Создаем пароль для каждого пользователя
  password=$(generate_password)

  # Создаем пользователя и базу данных
  mysql -e "CREATE DATABASE 'RouteDB$i';"
  mysql -e "CREATE USER 'captain$i'@'localhost' IDENTIFIED BY '$password';"
  mysql -e "GRANT ALL PRIVILEGES ON 'RouteDB$i'.* TO 'RouteDB$i'@'localhost';"
  mysql -e "REVOKE CREATE, DROP ON 'RouteDB$i'.* FROM 'RouteDB$i'@'localhost';"
  mysql -e "FLUSH PRIVILEGES;"

  # Заполним таблицу Users (создадим ее если не существует)
  if [ $i -eq 1 ]; then
    mysql -e "CREATE DATABASE DB;"
    mysql -e "CREATE TABLE DB.Users (username VARCHAR(50), password TEXT);"
  fi

  # Вставим пользователя и его зашифрованный пароль
  encrypted_password=$(echo -n "$password" | sha256sum | awk '{print $1}')
  mysql -e "INSERT INTO DB.Users (username, password) VALUES ('captain$i', '$encrypted_password');"
done

echo "Пользователи и базы данных созданы успешно!"

