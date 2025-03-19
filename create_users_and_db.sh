#!/bin/bash

# генерация пароля
generate_password() {
  tr -dc 'A-Za-z0-9' </dev/urandom | head -c 6
}

# 11 пользователей и баз данных
for i in $(seq 1 11); do
  # переменные
  password=$(generate_password)
  root_password="011220"

  # Создаем пользователя и базу данных
  mysql -u root -p$root_password -e "CREATE DATABASE DB$i;"
  mysql -u root -p$root_password -e "CREATE USER 'u$i'@'localhost' IDENTIFIED BY '$password';"
  mysql -u root -p$root_password -e "GRANT ALL PRIVILEGES ON DB$i.* TO 'u$i'@'localhost';"
  mysql -u root -p$root_password -e "REVOKE CREATE, DROP ON DB$i.* FROM 'u$i'@'localhost';"
  mysql -u root -p$root_password -e "FLUSH PRIVILEGES;"

  # Заполним таблицу Users в базе данных DB
  if [ $i -eq 1 ]; then
    mysql -u root -p$root_password -e "CREATE DATABASE DB;"
    mysql -u root -p$root_password -e "CREATE TABLE DB.Users (username VARCHAR(50), password TEXT);"
  fi

  # Вставим пользователя и пароль в таблицу Users
  encrypted_password=$(echo -n "$password" | sha256sum | awk '{print $1}')
  mysql -u root -proot_password -e "INSERT INTO DB.Users (username, password) VALUES ('u$i', '$encrypted_password');"
done

echo "Пользователи и базы данных созданы успешно!"
