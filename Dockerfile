#using a version of python > 3.9
FROM python:3.12

WORKDIR /app

#copy the  local requirements.txt in the container
COPY ./requirements.txt requirements.txt

#copy the src of the app in the container
COPY src/ ./src

COPY data/ ./data

COPY notebooks/ ./notebooks

#--no-cache-dir -> force pip to reinstall all the necessary for the differents libraries 
RUN pip install --no-cache-dir -r /app/requirements.txt

#set the port 8080 exposed for the app
EXPOSE 8080

#expose the default port of jupyterlab
EXPOSE 8888

CMD ["uvicorn", "src.app:app", "--host", "0.0.0.0", "--port", "8080"]