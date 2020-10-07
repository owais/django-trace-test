FROM python:3.7

RUN apt-get update
RUN apt-get install -y nginx sudo vim wget default-libmysqlclient-dev libpython3.7-dev libtool

RUN mkdir /app
WORKDIR /app
ADD requirements.txt /app/

RUN pip install -r requirements.txt
RUN sfx-py-trace-bootstrap

COPY ./src/ /app/
RUN ls 

EXPOSE 8000

RUN mkdir -p /etc/nginx
RUN mkdir -p /srv/logs
COPY ./django_nginx.conf /etc/nginx/sites-available
RUN ln -s /etc/nginx/sites-available/django_nginx.conf /etc/nginx/sites-enabled
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN nginx -t

ENV SIGNALFX_ENDPOINT_URL='http://localhost:9080/v1/trace'

COPY docker-entrypoint.sh /app
# CMD ./manage.py runserver 0.0.0.0:8000
ENTRYPOINT "/app/docker-entrypoint.sh"
