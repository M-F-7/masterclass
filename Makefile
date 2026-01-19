IMG_NAME = app
APP_NAME = masterclass-app-1
JUPYTER_NAME = masterclass-jupyter-1
MODEL_NAME = model.joblib

all:
	@docker compose up --build -d
	@echo "My app is accessible on http://localhost:8080"
	@echo "Jupyter accessible on http://localhost:8888"

help:
	@echo "make: build and launch the services"
	@echo "make shell: enter in the shell of the app container"
	@echo "make cp: Copy the notebook and the model from the container to the local directory"
	@echo "make ps: Show all the services launched"
	@echo "make clear: down and clean the containers"

test:
	docker exec -it $(APP_NAME) bash -c "pytest -v"

shell:
	@docker exec -it $(APP_NAME) bash

ps:
	docker compose ps -a

cp:
	@docker cp $(JUPYTER_NAME):/app/notebooks/model.ipynb notebooks/
	@docker cp $(JUPYTER_NAME):/app/models/$(MODEL_NAME) models/

clear:
	@docker compose down
	@docker rmi masterclass-api:latest masterclass-dev:latest masterclass-test:latest

.PHONY: test