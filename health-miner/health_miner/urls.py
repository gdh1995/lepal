# coding=utf-8

from django.conf.urls import patterns, include, url
from django.conf.urls.static import static 
import settings
from django.views.generic import RedirectView
from django.http.response import HttpResponsePermanentRedirect

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

MHELP = settings.MHELP_RREFIX
HEALTNIC = settings.HEALTNIC_RREFIX

def home(request):
    return HttpResponsePermanentRedirect("/" + MHELP + "/")

def redirect_tp_wx(request):
    return HttpResponsePermanentRedirect("http://www.healthnic.cn:8000" + request.get_full_path())

urlpatterns = patterns('',
    url(r'^api/',               include('core.urls')),
    url(r'^$',                  RedirectView.as_view(url = '/' + HEALTNIC + '/index.html')),
    url(r'^index.html$',                  RedirectView.as_view(url = '/' + HEALTNIC + '/index.html')),
    url(r'^about$',             RedirectView.as_view(url = '/' + HEALTNIC + '/index.html#contact')),
    url(r'^' + MHELP +  r'$',  home),
    url(r'^' + MHELP + r'/',   include('health_miner.mhelp_urls')),
    url(r'^wx/',  redirect_tp_wx),
)

if settings.DEBUG:
    urlpatterns += patterns('',
        (r'^uploads/(?P<path>.*)$', 'django.views.static.serve', {
        'document_root': settings.MEDIA_ROOT}))
