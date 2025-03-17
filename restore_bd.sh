#!/bin/bash

# Восстановление базы данных DB из резервной копии
psql -U postgres -f db_backup.sql

echo "Восстановление базы данных завершено!"
