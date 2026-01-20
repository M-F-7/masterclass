############################
# 1) BUILD STAGE
############################
FROM python:3.12 AS dev

WORKDIR /app

COPY requirements-dev.txt .
RUN pip install --no-cache-dir -r requirements-dev.txt


COPY src/ ./src
COPY models/ ./models
COPY data/ ./data
COPY notebooks/ ./notebooks

# to get the package src
ENV PYTHONPATH="/app"

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token="]


############################
# 2) TEST STAGE
############################
FROM dev AS tester

COPY test/ ./test

# Lauch the test, stop if fail
RUN pytest -v


############################
# 3) PRODUCTION STAGE
############################
FROM python:3.12-slim AS prod

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
# install curl for the healthcheck
RUN apt-get update && apt-get install -y curl && apt-get clean


COPY --from=dev /app/src ./src
COPY --from=dev /app/models ./models

ENV PYTHONPATH="/app"

EXPOSE 8080

CMD ["uvicorn", "src.app:app", "--host", "0.0.0.0", "--port", "8080"]