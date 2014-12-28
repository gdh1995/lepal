from django.conf.urls import patterns, include, url


urlpatterns = patterns('core',
    url(r'^init$',                                                                       'api.init'),
    url(r'^registration_code/create$',                                                   'api.generate_registration_code'),
    url(r'^user/register$',                                                              'api.register'),
    
    url(r'^user/login$',                                                                 'api.login'),
    url(r'^user/create$',                                                                'api.create_user'),
    url(r'^user/update$',                                                                'api.update_user'),
    url(r'^user/delete$',                                                                'api.delete_user'),
    url(r'^users$',                                                                      'api.get_users'),
    url(r'^patient/add_overseer$',                                                       'api.add_overseer'),
    url(r'^patient/remove_overseer$',                                                    'api.remove_overseer'),
    url(r'^patient/set_overseer$',                                                       'api.set_patient_overseer'),

    url(r'^patients$',                                                                   'api.get_overseeing_patients'),
    url(r'^patient/statistic$',                                                          'api.patient_statistic'),

    url(r'^device/get$', 'api.get_user_by_device'),
    url(r'^device/bind$', 'api.bind_device_to_user'),
    url(r'^device/unbind$', 'api.unbind_device'),
    url(r'^device/upload_data$', 'api.upload_device_record'),
    url(r'^medical_records/json$', 'mongo_data.get_limited_data'),

    url(r'^medical_records$',                                                            'api.get_patient_medical_records'),
    url(r'^medical_record/create$',                                                      'api.create_patient_medical_record'),
    url(r'^medical_record/delete$',                                                      'api.delete_patient_medical_record'),
    url(r'^medical_record/comment/add$',                                                 'api.add_comment'),
)
