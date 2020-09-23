"""
WSGI config for tracetest project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.0/howto/deployment/wsgi/
"""
from signalfx_tracing import create_tracer, auto_instrument
auto_instrument(create_tracer())

import os

from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'tracetest.settings')

application = get_wsgi_application()
