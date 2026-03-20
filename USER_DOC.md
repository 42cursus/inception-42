# Inception-42 User Documentation

## Overview
This project sets up a LEMP stack (Linux, Nginx, MariaDB, PHP-FPM) running WordPress using Docker Compose/Alpine Linux.

## Quick Start
1. **Prerequisites**: Ensure Docker and Make are installed.
2. **Start the project**:
   ```bash
   make all
   ```
   This will build the images and start the containers.

3. **Stop the project**:
   ```bash
   make down
   ```

## Accessing the Application
- **Website**: [https://abelov.42.fr:443](https://abelov.42.fr:443) (or `https://localhost:443` if hosts file not configured)
- **Admin Panel**: [https://abelov.42.fr:443/wp-admin](https://abelov.42.fr:443/wp-admin)

## Credentials
Credentials are stored securely in `srcs/.env` and `secrets/` directory.
- **WordPress Admin User**: `abelov`
- **WordPress Editor User**: `editor_user`
- **Database User**: `wordpress`

#### example content of the .env file:
```bash
DOMAIN_NAME=abelov.42.fr

# MYSQL SETUP
DB_NAME=wordpress
DB_USER=wordpress
DB_HOST=mariadb

WP_ADMIN_USER=abelov
WP_ADMIN_EMAIL=abelov@student.42.fr

WP_USER=editor_user
WP_EMAIL=editor@student.42.fr
```


## Checking Status
To check if all services are running:
```bash
docker compose -f srcs/docker-compose.yml ps
```
