from django.conf.urls import patterns, include, url


urlpatterns = patterns('core.api',
    url(r'^init$',                       'init'),
    url(r'^registration_code/create$',   'generate_registration_code'),
    url(r'^user/register$',              'register'),

    url(r'^user/login$',                 'login'),
    url(r'^user/create$',                'create_user'),
    url(r'^user/update$',                'update_user'),
    url(r'^user/delete$',                'delete_user'),
    url(r'^users$',                      'get_users'),
    url(r'^patient/add_overseer$',       'add_overseer'),
    url(r'^patient/remove_overseer$',    'remove_overseer'),
    url(r'^patient/set_overseer$',       'set_patient_overseer'),

    url(r'^patients$',                   'get_overseeing_patients'),
    url(r'^patient/statistic$',          'patient_statistic'),

    url(r'^device/get$',                 'get_user_by_device'),
    url(r'^device/bind$',                'bind_device_to_user'),
    url(r'^device/unbind$',              'unbind_device'),
    url(r'^device/upload_data$',         'upload_device_record'),

    url(r'^medical_records$',            'get_patient_medical_records'),
    url(r'^medical_record/create$',      'create_patient_medical_record'),
    url(r'^medical_record/delete$',      'delete_patient_medical_record'),
    url(r'^medical_record/comment/add$', 'add_comment'),
)

urlpatterns += patterns('core.mongo_data',
    url(r'^medical_records/json$', 'get_limited_data'),
)