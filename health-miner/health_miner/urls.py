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

import hashlib

def validate(request):
    signature = request.GET.get("signature", "")
    timestamp = request.GET.get("timestamp", "")
    nonce = request.GET.get("nonce", "")
    token = 'healthnic'
    tmpArr = [token, timestamp, nonce]
    tmpArr.sort()
    tmpStr = ''.join(tmpArr)
    tmpStr = hashlib.sha1(tmpStr).hexdigest()
    return tmpStr == signature

def on_weixin(request):
    if request.method == 'POST':
        return HttpResponse("NO POST")
    elif request.GET.get("signature"): #access token
        if validate(request):
            return HttpResponse(request.GET.get('echostr', ""))
        else:
            return HttpResponse('false')
    return HttpResponse("Unknown Method")

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
    url(r'^weixin',  on_weixin),
)

if settings.DEBUG:
    urlpatterns += patterns('',
        (r'^uploads/(?P<path>.*)$', 'django.views.static.serve', {
        'document_root': settings.MEDIA_ROOT}))
