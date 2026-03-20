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

COMPOSE_FILE	= $(SRC_DIR)/docker-compose.yml
SECRETS_FILES	:= db_password.txt \
					db_root_password.txt \
					wp_admin_password.txt \
					wp_user_password.txt

SECRETS			:= $(SECRETS_FILES:%=$(SECRETS_DIR)/%)

all: up

$(SECRETS_DIR)/%.txt:
		@if [ ! -d $(@D) ]; then mkdir -p $(@D); fi
		@openssl rand -base64 12 > $@
		@echo "Generated secret for $@"

up: build
		@mkdir -p /home/$(USER)/data/wordpress
		@mkdir -p /home/$(USER)/data/mariadb
		@docker compose -f $(COMPOSE_FILE) up -d --build

build: $(SECRETS)
		@docker compose -f $(COMPOSE_FILE) build

down:
		@docker compose -f $(COMPOSE_FILE) down

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
		@rm -f $(SECRETS)
		@docker volume rm $$(docker volume ls -q) 2>/dev/null || true

re: fclean
		+@$(MAKE) all --no-print-directory

.PHONY: all build down re clean fclean
