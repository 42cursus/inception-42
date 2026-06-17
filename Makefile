# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: abelov <abelov@student.42london.com>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/03/20 13:56:51 by abelov            #+#    #+#              #
#    Updated: 2026/03/20 13:56:51 by abelov           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

USER			= abelov
name			= inception

SRC_DIR			= srcs
BUILD_DIR		= build
SECRETS_DIR		= secrets
DOMAIN_NAME		= $(USER).42.fr
EMAIL			= $(USER)@student.42london.com

COMPOSE_FILE	= $(SRC_DIR)/docker-compose.yml
SECRETS_FILES	:= db_password.txt \
					db_root_password.txt \
					wp_admin_password.txt \
					wp_user_password.txt \
					ftp_password.txt
SSL_CONFIG		:= $(SECRETS_DIR)/req.cnf
SSL_KEY			:= $(SECRETS_DIR)/private.key
SSL_CERT		:= $(SECRETS_DIR)/certificate.crt

SECRETS			:= $(SECRETS_FILES:%=$(SECRETS_DIR)/%)
SSL_ASSETS		:= $(SSL_CONFIG) $(SSL_KEY) $(SSL_CERT)

all: up clion-index

$(SECRETS_DIR)/%.txt:
		@if [ ! -d $(@D) ]; then mkdir -p $(@D); fi
		@openssl rand -base64 12 > $@
		@echo "Generated secret for $@"

$(SSL_DIR):
		@mkdir -p $@

.ONESHELL:
$(SSL_CONFIG): | $(SECRETS_DIR)
		cat <<- EOF > $@
		[req]
		prompt = no
		req_extensions = v3_req
		distinguished_name = req_distinguished_name

		[req_distinguished_name]
		countryName                 = FR
		stateOrProvinceName         = IDF
		localityName                = Paris
		organizationName            = 42
		organizationalUnitName      = 42London
		commonName                  = $(DOMAIN_NAME)
		emailAddress                = $(EMAIL)

		[v3_req]
		basicConstraints = CA:FALSE
		keyUsage = nonRepudiation, digitalSignature, keyEncipherment
		subjectAltName = @alt_names

		[alt_names]
		DNS.1 = $(DOMAIN_NAME)
		DNS.2 = *.$(DOMAIN_NAME)
		DNS.3 = localhost
		EOF
		@echo "Generated SSL config at $@"

$(SSL_KEY): | $(SECRETS_DIR)
		@openssl genrsa -out $@ 2048
		@chmod 600 $@
		@echo "Generated private key at $@"

$(SSL_CERT): $(SSL_CONFIG) $(SSL_KEY)
		@openssl req -new -x509 -sha256 \
			-key $(SSL_KEY) \
			-out $@ \
			-days 365 \
			-config $(SSL_CONFIG) \
			-extensions v3_req
		@echo "Generated certificate at $@"

ssl-config: $(SSL_CONFIG)
ssl-key: $(SSL_KEY)
ssl-cert: $(SSL_CERT)
ssl-assets: ssl-config ssl-key ssl-cert

up: build
		@mkdir -p /home/$(USER)/data/wordpress
		@mkdir -p /home/$(USER)/data/mariadb
		@docker compose -f $(COMPOSE_FILE) up -d --build

build: $(SECRETS) $(SSL_ASSETS)
		@docker compose -f $(COMPOSE_FILE) build

down:
		@docker compose -f $(COMPOSE_FILE) down

## clion-index
clion-index:
	$(CC) -x c -fsyntax-only /dev/null

## clean
clean: down
		for image in $$(docker compose -f $(COMPOSE_FILE) --format json | jq .[].Repository -r || true); do \
			@docker image rm $$image:42 || true;\
		done
		@docker compose -f $(COMPOSE_FILE) down -v
		@docker system prune -af

## fclean
fclean: clean
		@docker run --rm -v /home/$(USER)/data:/data alpine sh -c "rm -rf /data/*" 2>/dev/null || true
		@#rm -f $(SECRETS) $(SSL_ASSETS)
		@docker volume rm $$(docker volume ls -q) 2>/dev/null || true

re: fclean
		+@$(MAKE) all --no-print-directory

.PHONY: all build down re clean fclean ssl-assets ssl-config ssl-key ssl-cert
