# coding=utf-8

from django.conf.urls import patterns, url

urlpatterns = patterns('analysis_views.views',
    url(r'^$',                     'dashboard'),
    url(r'^login$',                'login'),
    url(r'^logout$',               'logout'),
    url(r'^about$',                'about'),
    url(r'^user_management$',      'user_management'),
    url(r'^user/info$',            'user_info'),
    url(r'^user/info_update$',     'user_info_update'),
    url(r'^user/change_password$', 'user_change_password'),
    url(r'^user/upload_avatar$',   'user_upload_avatar'),
)
