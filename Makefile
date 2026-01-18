IMG_NAME = app
CONTAINER_NAME = masterclass-app-1
JUPYTER_NAME = masterclass-jupyter-1

all:
# 	@docker build -t $(IMG_NAME) .
	@docker compose up --build -d
	@echo "My app is accessible on http://localhost:8080"
	@echo "Jupyter accessible on http://localhost:8888"
# 	@docker run -d --name $(CONTAINER_NAME) -p 8080:8080 8888:8888 $(IMG_NAME)

help:
	@echo "TODO"

shell:
	@docker exec -it $(CONTAINER_NAME) bash
stop:
	@docker down$(CONTAINER_NAME)

ps:
	docker compose ps

cp:
	@docker cp $(JUPYTER_NAME):/app/notebooks/model.ipynb notebooks/

clear:
	@docker cp $(JUPYTER_NAME):/app/notebooks/model.ipynb notebooks/
	@docker compose down