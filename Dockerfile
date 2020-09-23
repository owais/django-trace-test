FROM python:3.7

RUN mkdir /app
WORKDIR /app
ADD requirements.txt /app/

RUN pip install -r requirements.txt
RUN pip install signalfx-tracing && sfx-py-trace-bootstrap

COPY ./src/ /app/
RUN ls 

EXPOSE 8000

ENV SIGNALFX_ENDPOINT_URL='http://localhost:9080/v1/trace'

CMD ./manage.py runserver 0.0.0.0:8000