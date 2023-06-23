FROM python:3.12.0b3-alpine3.18

RUN mkdir -p /opt/flask-hello-world
COPY . /opt/flask-hello-world
WORKDIR /opt/flask-hello-world

RUN pip install -r requirements.txt
WORKDIR /opt/flask-hello-world/src
CMD ["flask", "run", "--port", "3001"]
