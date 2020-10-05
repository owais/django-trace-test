#!/bin/bash
python3.7 manage.py migrate
python3.7 manage.py collectstatic --no-input

touch /srv/logs/gunicorn.log
touch /srv/logs/access.log
tail -n 0 -f /srv/logs/gunicorn.log /srv/logs/access.log &

echo Starting Nginx
echo Starting Gunicorn

gunicorn .wsgi:application \
    --name tea \
    --bind unix:django_app.sock \
    --workers 10 \
    --timeout 60 \
    --log-level info \
    --log-file /srv/logs/gunicorn.log \
    --access-logfile /srv/logs/access.log \
    --preload \
    --worker-class gthread &

exec service nginx start
