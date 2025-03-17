#!/bin/bash

# Резервное копирование базы данных DB
pg_dump -U postgres DB > db_backup.sql

echo "Резервное копирование завершено!"
