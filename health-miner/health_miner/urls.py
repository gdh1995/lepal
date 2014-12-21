# coding=utf-8

from django.conf.urls import patterns, include, url
from django.conf.urls.static import static 
import settings

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()


urlpatterns = patterns('',
    url(r'^api/',                                                          include('core.urls')),
)

urlpatterns += patterns('',
    url(r'^$',                                                             'analysis_views.views.dashboard'),
    url(r'^login$',                                                        'analysis_views.views.login'),
    url(r'^logout$',                                                       'analysis_views.views.logout'),
    url(r'^about$',                                                        'analysis_views.views.about'),
    url(r'^user_management$',                                              'analysis_views.views.user_management'),
    url(r'^user/info$',                                             	   'analysis_views.views.user_info'),
    url(r'^user/info_update$',                                             'analysis_views.views.user_info_update'),
    url(r'^user/change_password$',                                         'analysis_views.views.user_change_password'),
    url(r'^user/upload_avatar$',                                           'analysis_views.views.user_upload_avatar'),
)

if settings.DEBUG:
	urlpatterns += patterns('',
        (r'^uploads/(?P<path>.*)$', 'django.views.static.serve', {
        'document_root': settings.MEDIA_ROOT}))

