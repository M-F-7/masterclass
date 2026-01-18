IMG_NAME = app
CONTAINER_NAME = masterclass-app-1
JUPYTER_NAME = masterclass-jupyter-1
MODEL_NAME = model.joblib

all:
	@docker compose up --build -d
	@echo "My app is accessible on http://localhost:8080"
	@echo "Jupyter accessible on http://localhost:8888"

help:
	@echo "make: build and launch the services"
	@echo "make shell: enter in the shell of the app container"
	@echo "make cp: Copy the notebook in the container to the local directory"
	@echo "make ps: Show all the services launched"
	@echo "make clear: down and clean the containers"

shell:
	@docker exec -it $(CONTAINER_NAME) bash
stop:
	@docker down$(CONTAINER_NAME)

ps:
	docker compose ps

cp:
	@docker cp $(JUPYTER_NAME):/app/notebooks/model.ipynb notebooks/
	@docker cp $(JUPYTER_NAME):/app/models/$(MODEL_NAME) models/

clear:
	@docker cp $(JUPYTER_NAME):/app/notebooks/model.ipynb notebooks/
	@docker compose down