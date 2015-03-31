# coding=utf-8

from django.shortcuts import render_to_response
from core.models import *
from django.db.models import Q
from core.view_model import view_model
from django.http.response import HttpResponseRedirect

def login(request):
	return render_to_response('login.html', locals())

def dashboard(request):
	user = request.session.get('user')
	if user is None:
		return HttpResponseRedirect('login')
	user = get_login_user(request)
	user = view_model(user)

	return render_to_response('dashboard.html', locals())

def user_management(request):
	user = request.session.get('user')
	if user is None:
		return HttpResponseRedirect('login')

	if user['role']['id'] not in (User.ADMINISTRATOR, ):
		return HttpResponseRedirect('')

	role_options = [{'name': '', 'display_name': u'全部'},
					{'name': 'admin', 'display_name': u'管理员', 'id': User.ADMINISTRATOR},
				 	{'name': 'doctor', 'display_name': u'医生', 'id': User.DOCTOR},
				 	{'name': 'advisor', 'display_name': '咨询师', 'id': User.ADVISOR},
				 	{'name': 'patient', 'display_name': '微服务用户', 'id': User.PATIENT}]
	roles = role_options[1: ]

	current_role = request.GET.get('role', '')
	query = request.GET.get('query', '')

	all_users = User.objects.filter(deleted=0)
	users = all_users

	if query:
		users = users.filter(Q(name__contains=query) | Q(guid__contains=query) | Q(username__contains=query))

	if current_role == 'admin':
		users = users.filter(role=User.ADMINISTRATOR)
	elif current_role == 'doctor':
		users = users.filter(role=User.DOCTOR)
	elif current_role == 'advisor':
		users = users.filter(role=User.ADVISOR)
	elif current_role == 'patient':
		users = users.filter(role=User.PATIENT)

	users = map(lambda u: view_model(u), users)
	# For some special roles, they have their own behaviors
	all_overseers = map(lambda u: view_model(u), filter(lambda u: u.role in (User.DOCTOR, User.ADVISOR), all_users))

	patient_users = filter(lambda u: u['role']['name'] == 'patient', users)
	for p_user in patient_users:
		patient = Patient.objects.get(user_id=p_user['id'])
		p_user['overseers'] = map(lambda r: view_model(r.overseer), RE_OverseePatients.objects.filter(patient_id=patient.id, overseer__deleted=0, deleted=0))
		# p_user['overseer_ids'] = map(lambda u: u.id, p_user['overseers'])
		p_user['patient'] = patient

	doctor_and_advisor_users = filter(lambda u: u['role']['name'] in ('doctor', 'advisor'), users)
	for overseer in doctor_and_advisor_users:
		oversee_records = RE_OverseePatients.objects.filter(overseer_id=overseer['id'], patient__deleted=0, deleted=0)
		overseeing_patients = map(lambda r: r.patient, oversee_records)

		overseer['overseeing_patients'] = overseeing_patients

	all_patients = Patient.objects.filter(deleted=0)

	return render_to_response('user_management.html', locals())

def logout(request):
	if 'user' in request.session:
		del request.session['user']
	return HttpResponseRedirect('.')

def about(request):
	return render_to_response('about.html', locals())

def is_authenticated(request):
	return request.session.get('user')

def get_login_user(request):
	return User.objects.get(id=request.session.get('user')['id'])

def user_info(request):
	if not is_authenticated(request):
		return HttpResponseRedirect('..')
	nav = 'info'
	return HttpResponseRedirect('info_update')

def user_info_update(request):
	if not is_authenticated(request):
		return HttpResponseRedirect('..')
	nav = 'info_update'
	user = get_login_user(request)

	return render_to_response('user/info_update.html', locals())

def user_change_password(request):
	if not is_authenticated(request):
		return HttpResponseRedirect('..')
	nav = 'change_password'
	user = get_login_user(request)
	return render_to_response('user/change_password.html', locals())

def user_upload_avatar(request):
	if not is_authenticated(request):
		return HttpResponseRedirect('..')
	nav = 'upload_avatar'
	user = get_login_user(request)
	return render_to_response('user/upload_avatar.html', locals())

