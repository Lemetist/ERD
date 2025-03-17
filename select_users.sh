#!/bin/bash

# Вывод всех пользователей с их зашифрованными паролями
psql -d DB -c "SELECT username, password FROM Users;"
	
