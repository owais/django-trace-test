from django.shortcuts import render
from django.http import HttpResponse
import requests_oauthlib
from oauthlib.oauth2 import BackendApplicationClient


def hello(request):
    return HttpResponse("hello, world")


def oauth_test(request):
    backend_client = BackendApplicationClient(client_id='OAuth client ID', client_secret='OAuth client secret key')
    session = requests_oauthlib.OAuth2Session(client=backend_client)
    session.fetch_token('https://www.domain.com/oauth2/token', include_client_id=True, client_secret='OAuth client secret key')
    session.request('GET', url='https://www.domain.com/oauth2/authenticated/endpoint', params={}, headers={})
    return HttpResponse(b'Test successful - should report some span(s)')
