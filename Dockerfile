FROM python:3.7

RUN apt-get install -y nginx sudo vim wget default-libmysqlclient-dev libpython3.7-dev libtool

RUN mkdir /app
WORKDIR /app
ADD requirements.txt /app/

RUN pip install -r requirements.txt
RUN sfx-py-trace-bootstrap

COPY ./src/ /app/
RUN ls 

EXPOSE 8000

COPY ./django_nginx.conf /etc/nginx/sites-available
RUN ln -s /etc/nginx/sites-available/django_nginx.conf /etc/nginx/sites-enabled
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN nginx -t

ENV SIGNALFX_ENDPOINT_URL='http://localhost:9080/v1/trace'

ADD ./docker-entrypoint.sh /app/
ENTRYPOINT ["./docker-entrypoint.sh"]
