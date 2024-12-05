DOCKER_COMPOSE = ./srcs/docker-compose.yml


all:	mkdata build

re:	fclean	all

build:
	@echo "Building images, running containers..."
	docker-compose --f ${DOCKER_COMPOSE} -p inception up --build -d

up:
	@echo "Running containers..."
	docker-compose -f ${DOCKER_COMPOSE} -p inception up -d

down:
	@echo "Stopping containers..."
	docker-compose -f ${DOCKER_COMPOSE} -p inception down 

mkdata:
	@echo "Creating directories..."
	@if [ ! -d /home/adelaloy/data/wordpress ]; then \
		mkdir -p /home/adelaloy/data/wordpress; \
	fi

	@if [ ! -d /home/adelaloy/data/mariadb ]; then \
		mkdir -p /home/adelaloy/data/mariadb; \
	fi
	@echo "Directories created."

rmdata:
	@echo "Removing directories..."
	sudo rm -rf /home/adelaloy/data/wordpress
	sudo rm -rf /home/adelaloy/data/mariadb

rmvolumes:
	@echo "Removing volumes..."
	docker volume rm db_volume
	docker volume rm wp_volume


clean:
	@echo "Cleaning containers..."
	docker-compose -f ${DOCKER_COMPOSE} -p inception down --volumes --rmi all

fclean: rmdata
	@echo "Removing images and data..."
	docker-compose -f ${DOCKER_COMPOSE} -p inception down --volumes --rmi all
	docker system prune -a -f

nginx:
	docker exec -it nginx bash

wordpress:
	docker exec -it wordpress sh

mariadb:
	docker exec -it mariadb bash


.PHONY: all build up down mkdata rmdata clean fclean nginx wordpress mariadb