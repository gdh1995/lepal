from models import *
from django.views.decorators.csrf import csrf_exempt
from django.db import transaction
from django.http import HttpResponse, HttpResponseBadRequest, HttpResponseForbidden
import config, hashlib
from view_model import view_model
import zipfile, os
from datetime import datetime, timedelta
from health_miner import settings
import random
from bson import ObjectId

DEFAULT_TIME_FORMAT = '%Y-%m-%d %X'

class ComplexEncoder(json.JSONEncoder):
    item_separator = ','
    key_separator = ':'
    def default(self, obj):
        if isinstance(obj, datetime):
            return obj.strftime(DEFAULT_TIME_FORMAT)
        if isinstance(obj, ObjectId):
            return str(obj)
        return json.JSONEncoder.default(self, obj)

def get_auth_user(request, data=None):
    data = data or request.REQUEST

    user = request.session.get('user')

    if user: 
        user = User.objects.filter(id=user['id'])
        if not user.exists():
            return None

        return user[0]
    else:
        # TODO: add a timestamp
        user = user_auth(data.get('auth_username', None), data.get('auth_password', None))
        return user

def user_auth(username, password):
    user = User.objects.filter(username=username, password=password, deleted=0)

    if not user.exists():
        print 'USER NOT EXIST %s %s' %(username, password)
        return None

    return user[0]

def to_md5(string):
    m = hashlib.md5()
    m.update(string)
    return m.hexdigest()

def is_field_missing(data, fields):
    for field in fields:
        if not data.has_key(field):
            return HttpResponseBadRequest('%s is required' %(field))
    return None

def get_users(request):
    user = get_auth_user(request)

    if not user or user.role != User.ADMINISTRATOR:
        return HttpResponseBadRequest()

    return HttpResponse(json.dumps({'users': map(lambda u: view_model(u), User.objects.filter(deleted=0))}, cls=ComplexEncoder))

def is_overseer(overseer_id, patient_id):
    return RE_OverseePatients.objects.filter(overseer_id=overseer_id, patient_id=patient_id, deleted=0).exists()

def is_user_having_access_to_patient(user, patient):
    if user.role in (User.DOCTOR, User.ADVISOR) and not is_overseer(overseer_id=user.id, patient_id=patient.id):
        return False

    if user.is_patient() and user.id != patient.user_id:
        return False

    return True

def create_user_and_role(username, password, name, role):
    user = User.objects.create(username=username, password=password, role=role, name=name, register_time=datetime.now())
    user.generate_guid()
    
    if role == User.ADMINISTRATOR:
        administrator = Administrator.objects.create(user=user)
    elif User.DOCTOR == role:
        doctor = Doctor.objects.create(user=user)
    elif User.ADVISOR == role:
        advisor = Advisor.objects.create(user=user)
    elif User.PATIENT == role:
        patient = Patient.objects.create(user=user)

    return user

# ---------------------------------------------------- #
#                      API AREAS                       #
# ---------------------------------------------------- #

"""
Testing
"""
@transaction.commit_on_success
def init(request):
    admin_user = create_user_and_role(username='admin', 
                                      password=to_md5('admin'),
                                      name='admin',
                                      role=User.ADMINISTRATOR) 

    for name, role, cls in [('doctor', User.DOCTOR, Doctor), 
                            ('advisor', User.ADVISOR, Advisor), 
                            ('patient', User.PATIENT, Patient)]:
        for i in range(5):
            username = '%s%d' %(name, i)
            user = create_user_and_role(username=username, password=to_md5(username), role=role, name=username)

    return HttpResponse({'success': True})

@csrf_exempt
@transaction.commit_on_success
def generate_registration_code(request):
    """
    Generate a registration_code upon request
    Only admin, doctor, advisor and request this
    Required data:
    - user_role: indicator what kind of role this registration_code is for, int

    Response:
    The information contains the code
    """
    auth_user = get_auth_user(request)
    if not auth_user:
        return HttpResponseForbidden('AUTHENTICATION FAIL')
    if not auth_user.role in (User.ADMINISTRATOR, User.DOCTOR, User.ADVISOR, ):
        return HttpResponseForbidden('USER ROLE NOT ALLOWED')

    data = request.REQUEST
    if not data.has_key('user_role'):
        return HttpResponseBadRequest('user_role is required')

    role = int(data['user_role'])

    if role in (User.ADMINISTRATOR, ):
        return HttpResponseForbidden()
    elif role in (User.DOCTOR, User.ADVISOR,):
        if not auth_user.is_admin():
            return HttpResponseForbidden()
    elif role in (User.PATIENT, ):
        pass
    else:
        return HttpResponseBadRequest('INVALID ROLE')


    code_obj = RegistrationCode.objects.create(code=config.random_id(), 
                                               generator_id=auth_user.id, 
                                               generate_time=datetime.now(),
                                               state=RegistrationCode.NEWLY_CREATED,
                                               user_role=role)

    return HttpResponse(json.dumps(view_model(code_obj), cls=ComplexEncoder))



@csrf_exempt
@transaction.commit_on_success
def register(request):
    """
    Required data:
    - registration_code, string
    - username, string and unique
    - password, string, md5 of user input password
    - name, string

    Non-required
    - sex: 1 or 2, 1 - male, 2 - female
    - phone, string
    - address, string
    - email, string
    - avatar, file stream
    """
    data = request.REQUEST
    # print data

    registration_code = data.get('registration_code', None)
    if registration_code is None:
        return HttpResponseBadRequest('NO REGISTRATION CODE')

    code_obj = RegistrationCode.objects.filter(code=registration_code)
    if not code_obj.exists():
        return HttpResponseBadRequest('INVALID REGISTRATION CODE')

    code_obj = code_obj[0]
    
    res = is_field_missing(data, ('username', 'password', 'name'))
    if res is not None:
        return res

    username      = data['username']
    password      = data['password']
    name          = data['name']
    sex           = data.get('sex', None)
    phone         = data.get('phone', None)
    address       = data.get('address', None)
    email         = data.get('email', None)
    user_role     = code_obj.user_role #int(data['user_role'])

    #if not user_role == code_obj.user_role:
    #    return HttpResponseBadRequest('USER ROLE NOT CONSISTENT WITH CODE ROLE')

    exist_user = User.objects.filter(username=username)
    if exist_user.exists():
        return HttpResponseBadRequest('USERNAME EXIST')

    if sex is not None:
        sex = int(sex)
        if sex not in (1, 2):
            return HttpResponseBadRequest('sex must be 1 or 2')

    for field, value, length_limit in [('username', username, 100), 
                                       ('name', name, 250), 
                                       ('email', email, 250), 
                                       ('phone', phone, 100), 
                                       ('address', address, 500)]:
        if value is not None:
            if len(value) > length_limit:
                return HttpResponseBadRequest('%s cannot be longer than %d' %(field, length_limit))

    user = create_user_and_role(username=username, password=password, name=name, role=user_role)
    user.sex = sex
    user.phone = phone
    user.address = address
    user.email = email
    user.save()

    if request.FILES.has_key('avatar'):
        fs = request.FILES['avatar']
        try:
            user.update_avatar(fs) # fix a bug of typo
        except FileNotQualifiedException as e:
            return HttpResponseBadRequest(e.get_msg())

    code_obj.state = RegistrationCode.USED
    code_obj.used_user = user
    code_obj.used_time = datetime.now()
    code_obj.save()

    if user.is_patient() and code_obj.generator.role in (User.ADVISOR, User.DOCTOR):
        patient = Patient.objects.get(user_id=user.id)
        RE_OverseePatients.objects.add_overseer(patient, code_obj.generator)

    return HttpResponse(json.dumps({'success': True, 'user': view_model(user)}, cls=ComplexEncoder))

@csrf_exempt
@transaction.commit_on_success
def create_user(request):
    """
    This is used for admin to add user
    required:
    - username, string, unique
    - password, md5 of password,
    - name, string
    - role, int
    """
    user = get_auth_user(request)
    if user is None or user.role != User.ADMINISTRATOR:
        return HttpResponseForbidden('NO PREVILEGE')

    data = request.REQUEST

    for key in ('username', 'password', 'role', 'name'):
        if not data.get(key, None):
            return HttpResponseBadRequest('DATA FIELD %s MISSING' %(key))

    username = data['username']
    password = data['password']
    name     = data['name']
    role     = int(data['role'])

    if not role in User.ROLES:
        return HttpResponseBadRequest('INVALID ROLE')

    exist_user = User.objects.filter(username=username)
    if exist_user.exists():
        return HttpResponseBadRequest('USERNAME EXIST')

    create_user_and_role(username=username, password=password, name=name, role=role)

    return HttpResponse(json.dumps({'success': True}))

@csrf_exempt
@transaction.commit_on_success
def delete_user(request):
    """
    Only open for admin
    required:
    - user_id, int
    """
    data = request.REQUEST
    res = is_field_missing(data, ('user_id', ))
    if res is not None: return res

    auth_user = get_auth_user(request)
    if not auth_user.is_admin(): return HttpResponseForbidden('ONLY OPEN FOR ADMIN')

    user_id = int(data['user_id'])
    if user_id == auth_user.id: return HttpResponseBadRequest('CANNOT DELETE YOURSELF')

    target_user = User.objects.get(id=user_id)
    target_user.deleted = 1
    target_user.save()

    
    if User.ADMINISTRATOR == target_user.role:
        cls = Administrator
    elif User.DOCTOR == target_user.role:
        cls = Doctor
    elif User.ADVISOR == target_user.role:
        cls = Advisor
    elif User.PATIENT == target_user.role:
        cls = Patient
    cls.objects.filter(user_id=target_user.id).update(deleted=1)

    return HttpResponse(json.dumps({'success': True}))

@csrf_exempt
@transaction.commit_on_success
def login(request):
    """
    Required:
    - username
    - password
    """
    data = request.REQUEST
    
    res = is_field_missing(data, ('username', 'password'))
    if res is not None:
        return res

    username = data['username']
    passwd   = data['password']

    transaction.set_autocommit(False)

    user = user_auth(username=username, password=passwd)
    if user is None:
        transaction.rollback()
        return HttpResponse(json.dumps({'error': 'INVALID'}))

    request.session['user'] = view_model(user)

    transaction.commit()
    return HttpResponse(json.dumps({'success': True, 'user': view_model(user)}, cls=ComplexEncoder))

@csrf_exempt
@transaction.commit_on_success
def update_user(request):
    """
    Required:
    - user_id, int

    For any of the follow fields:
    - password
    - name
    - address
    - phone
    - email
    - avatar
    if the post data contains it as a key, then update it according to the posted value
    """
    data = request.REQUEST
    # print data
    if not data.has_key('user_id'):
        return HttpResponseBadRequest('user_id is required')

    user_id = int(data['user_id'])

    user = get_auth_user(request)

    if user is None or (user.role != User.ADMINISTRATOR and user.id != user_id):
        return HttpResponseForbidden('NO PREVILEGE')

    target_user = User.objects.get(id=user_id)

    for key in ('password', 'name', 'sex', 'address', 'phone', 'email'):
        if data.has_key(key):
            if key == 'password':
                # Two different behaviors for password
                # 1. Post data contains old password. This is usually for normal user to change their password
                # 2. Requester is admin, so old password is not required.
                # Other case would fail
                if data.has_key('old_password'):
                    old_password = data['old_password']
                    if not user.password == old_password:
                        return HttpResponseForbidden('OLD PASSWORD NOT MATCHED')
                else:
                    if not user.is_admin():
                        return HttpResponseForbidden('ONLY ADMIN CAN ALTER PASSWORD WITHOUT OLD PASSWORD')

            if key == 'sex':
                value = int(data[key])
                if not value in (1, 2):
                    return HttpResponseBadRequest('sex must be 1 or 2')

            value = data[key]

            setattr(target_user, key, value)

    if request.FILES.has_key('avatar'):
        fs = request.FILES['avatar']
        try:
            target_user.update_avatar(fs)
        except FileNotQualifiedException as e:
            return HttpResponseBadRequest(e.get_msg())

    target_user.save()

    return HttpResponse(json.dumps({'success': True}))

@csrf_exempt
@transaction.commit_on_success
def set_patient_overseer(request):
    """
    Set which doctor/advisor have access to a patient
    Required:
    - patient_id, int
    - overseer_ids, string, in the format of 1,2,3,4,5

    """
    user = get_auth_user(request)

    if user is None or not user.is_admin():
        return HttpResponseForbidden()

    data = request.REQUEST
    
    res = is_field_missing(data, ('overseer_ids', 'patient_id'))
    if res is not None: return res

    overseer_ids = data['overseer_ids']
    overseer_ids = map(lambda v: int(v), overseer_ids.split(','))
    patient_id  = data['patient_id']

    patient  = Patient.objects.get(id=int(patient_id))
    
    for overseer_id in overseer_ids:
        overseer = User.objects.get(id=int(overseer_id))

        if overseer.role not in (User.ADVISOR, User.DOCTOR):
            return HttpResponseBadRequest('INVALID OVERSEER ROLE')

        if not is_overseer(overseer.id, patient.id):
            RE_OverseePatients.objects.add_overseer(patient, overseer)

    for relation in RE_OverseePatients.objects.filter(patient_id=patient.id, deleted=0):
        if relation.overseer_id in overseer_ids:
            continue
        else:
            relation.deleted = 1
            relation.save()

    return HttpResponse(json.dumps({'success': True}))


@csrf_exempt
@transaction.commit_on_success
def add_overseer(request):
    """
    Add a doctor/advisor as overseer of a patient
    Required:
    - overseer_id, int
    - patient_id, int
    """
    user = get_auth_user(request)

    if user is None or not user.is_admin():
        return HttpResponseForbidden()

    data = request.REQUEST
    res = is_field_missing(data, ['overseer_id', 'patient_id'])
    if res: return res

    overseer_id = data['overseer_id']
    patient_id  = data['patient_id']

    overseer = User.objects.get(id=int(overseer_id))

    if overseer.role not in (User.ADVISOR, User.DOCTOR):
        return HttpResponseBadRequest('INVALID OVERSEER ROLE')

    patient  = Patient.objects.get(id=int(patient_id))
    
    if not is_overseer(overseer.id, patient.id):
        relation = RE_OverseePatients(overseer_id=overseer.id, patient_id=patient.id)

        if overseer.role == User.ADVISOR:
            relation.overseer_type = RE_OverseePatients.ADVISOR
        elif overseer.role == User.DOCTOR:
            relation.overseer_type = RE_OverseePatients.DOCTOR

        relation.save()

        return HttpResponse(json.dumps({'success': True, 'patient': view_model(patient), 'overseer': view_model(overseer)}))
    else:
        return HttpResponseBadRequest('CANNOT ADD TWICE')

@csrf_exempt
@transaction.commit_on_success
def remove_overseer(request):
    """
    Remove the access of a doctor/advisor towards a patient
    Required:
    - overseer_id, int
    - patient_id, int
    """
    user = get_auth_user(request)

    if user is None or not user.is_admin():
        return HttpResponseForbidden()

    data = request.REQUEST
    res = is_field_missing(data, ['overseer_id', 'patient_id'])
    if res: return res

    overseer_id = data['overseer_id']
    patient_id  = data['patient_id']

    overseer = User.objects.get(id=int(overseer_id))

    if overseer.role not in (User.ADVISOR, User.DOCTOR):
        return HttpResponseBadRequest('INVALID OVERSEER ROLE')

    patient = Patient.objects.get(id=int(patient_id))

    relation = RE_OverseePatients.objects.filter(overseer_id=overseer.id, patient_id=patient.id)

    relation.update(deleted=1)

    return HttpResponse(json.dumps({'success': True, 'patient': view_model(patient), 'overseer': view_model(overseer)}))


@csrf_exempt
@transaction.commit_on_success
def get_overseeing_patients(request):
    """
    Get the patient list a user have access to 
    Admin: All patients
    Doctor/Advisor: Patients they're responding to
    Patient: Only himself/herself
    """
    user = get_auth_user(request)
    if user is None:
        return HttpResponseForbidden()

    all_patients = Patient.objects.filter(deleted=0)
    if user.role == User.ADMINISTRATOR:
        patients = all_patients
    elif user.role in(User.DOCTOR, User.ADVISOR):
        if user.role == User.DOCTOR:
            overseer_type = RE_OverseePatients.DOCTOR
        elif user.role == User.ADVISOR:
            overseer_type = RE_OverseePatients.ADVISOR

        patients = all_patients.filter(id__in=map(lambda r: r.patient_id, RE_OverseePatients.objects.filter(overseer_id=user.id, overseer_type=overseer_type, deleted=0)))
    elif user.role == User.PATIENT:
        patients = [Patient.objects.get(user_id=user.id)]

    patients_data = map(lambda p: view_model(p), patients)

    return HttpResponse(json.dumps({'patients': patients_data}, cls=ComplexEncoder))

@csrf_exempt
@transaction.commit_on_success
def get_patient_medical_records(request):
    """
    Required:
    - patient_id, int
    """
    # 1. Check login
    auth_user = get_auth_user(request)
    if auth_user is None:
        return HttpResponseForbidden('NOT AUTH')

    # 2. Check if the data is valid
    data = request.REQUEST
    res = is_field_missing(data, ('patient_id',))
    if res is not None: return res

    # 3. The requester must have access to the patient
    patient_id = int(data['patient_id'])
    patient = Patient.objects.get(id=patient_id)

    if not is_user_having_access_to_patient(user=auth_user, patient=patient):
        return HttpResponseForbidden()

    # 4. Retrieve records
    medical_records = MedicalRecord.objects.filter(patient_id=patient.id, deleted=0).order_by('-id')
    ## Records having the same serial number are removed excepts the one with largest id
    serial_number_occur_map = {}
    filtered_medical_records = []
    for record in medical_records:
        if not serial_number_occur_map.has_key(record.serial_number):
            filtered_medical_records.append(record)
            serial_number_occur_map[record.serial_number] = True

    # 5. Make the record json serializable
    records = map(lambda r: view_model(r), filtered_medical_records)

    db = get_mongo_db()
    for record in records:
        data_obj = find_medical_record_data(record['data_id'], db=db)
        if data_obj:
            del data_obj['_id']

        record['data'] = data_obj
        record['comments'] = map(lambda c: view_model(c), RecordComment.objects.filter(deleted=0, record_id=record['id']))

    return HttpResponse(json.dumps({'records': records}, cls=ComplexEncoder))

@csrf_exempt
@transaction.commit_on_success
def create_patient_medical_record(request):
    """
    Take upload data and create a medical record for a patient
    Only open to admin, related doctor/advisor
    Required:
    - patient_username, patient's username
    - serial_number, serial_number for this check record
    - record_time, when was it recorded
    - data_file, a zip file following a certain directory structure like this:
        root
            data.json ---- Contains a json string. Field diagnosis_routine must exists as a list. All image/audio path is relative
            other files
    """
    data = request.REQUEST
    files = request.FILES
    
    # 1. Authentication    
    user = get_auth_user(request)

    if user is None:
        return HttpResponseForbidden('AUTHENTICATION FAIL')

    if user.role not in (User.DOCTOR, User.ADMINISTRATOR, User.ADVISOR):
        return HttpResponseForbidden('YOUR USER ROLE HAS NO SUCH PREVILEGE')

    # 2. Check if any field is missing
    for field in (u'patient_username', u'serial_number', 'record_time'):
        if data.get(field, None) is None:
            return HttpResponseBadRequest('%s FIELD MUST BE PROVIDED' %(field))

    for file_field in (u'data_file', ):
        if not files.has_key(file_field):
            return HttpResponseBadRequest('%s FIELD MUST BE PROVIDED' %(file_field))

    # 3. check if field valid
    patient_username = data['patient_username']
    serial_number = data['serial_number']
    record_time = data['record_time']

    patient = Patient.objects.get(user=User.objects.get(username=patient_username))

    if user.role in (User.DOCTOR, User.ADVISOR,) and not is_overseer(user.id, patient.id):
        return HttpResponseForbidden('YOUR USER ROLE HAS NO SUCH PREVILEGE')

    try:
        record_time = datetime.strptime(record_time, DEFAULT_TIME_FORMAT)
    except Exception as e:
        print type(e), e
        return HttpResponseBadRequest('record_time format must follow %s' %(DEFAULT_TIME_FORMAT))
    
    # 4. Extract the file
    save_zip_path = config.get_new_zip_file_path()
    print "SAVING ZIP TO", save_zip_path

    fs = open(save_zip_path, 'wb')
    fs.write(files['data_file'].read())
    fs.close()

    record_file_dir = config.get_new_record_file_directory()
    zip_file_obj = zipfile.ZipFile(save_zip_path, 'r')
    zip_file_obj.extractall(record_file_dir)
    print 'UNZIP TO %s' %(record_file_dir)    

    # 5. There must be a file called data.json
    data_file = os.path.join(record_file_dir, 'data.json')

    if not os.path.exists(data_file):
        print 'NO DATA.JSON'
        return HttpResponseBadRequest('UPLOAD FILE CONTAINS NO data.json')

    # 6. Load content and insert into db
    data_content = json.loads(open(data_file).read())
    def replace_file_path(obj):
        if isinstance(obj, dict):
            if obj.has_key('file'):
                obj['file'] = os.path.join(record_file_dir, obj['file']).replace('\\', '/').replace(settings.ROOT_DIR, '')

            for key in obj.keys():
                print key
                replace_file_path(obj[key])
        elif isinstance(obj, list):
            for item in obj:
                replace_file_path(item)

    replace_file_path(data_content)
    
    if not data_content.has_key('diagnosis_routine') or not isinstance(data_content['diagnosis_routine'], list) :
        return HttpResponseBadRequest('diagnosis_routine field is required in data.json and must be a list')

    mongo_db = get_mongo_db()
    data_id = add_medical_record_data(data_content, db=mongo_db)

    ## Read some special content to index
    diagnosis_routine_data = data_content['diagnosis_routine']
    record_data = []
    for diagnosis_routine_item in diagnosis_routine_data:
        for result in diagnosis_routine_item['results']:
            if result.has_key('key') and result.has_key('value') and result.has_key('time'):
                try:
                    time = datetime.strptime(result['time'], DEFAULT_TIME_FORMAT)
                except Exception as e:
                    print 'WARNING: time field must follow %s. Skipping.' %(DEFAULT_TIME_FORMAT)

                key = result['key']
                if not key in MedicalRecord.RECORD_STATISTIC_KEYS:
                    print 'WARNING: %s KEY NOT IN RECORD_STATISTIC_KEYS' %(key)
                else:
                    new_data = {'key': key, 
                                'time': time, 
                                'upload_time': datetime.now(),
                                'patient_id': patient.id,
                                'data_id': str(data_id),}

                    if key == MedicalRecord.RECORD_STATISTIC_BLOOD_PRESSURE:
                        if result.has_key('low') and result.has_key('high'):
                            new_data['low'] = float(result['low'])
                            new_data['high'] = float(result['high'])
                        else:
                            print 'WARNING: BLOOD_PRESSURE HAS NOT LOW AND HIGH VALUE'
                            continue
                    else:
                        new_data['value'] = float(result['value'])

                    record_data.append(new_data)

    if len(record_data) > 0:
        insert_patient_statistic(record_data)
    
    medical_record = MedicalRecord(patient_id=patient.id, 
                                   serial_number=serial_number, 
                                   uploader_id=user.id,
                                   upload_time=datetime.now(),
                                   data_id=str(data_id),
                                   record_time=record_time)

    medical_record.save()

    return HttpResponse(json.dumps({'success': True, 'medical_record': view_model(medical_record)}, cls=ComplexEncoder))

@csrf_exempt
@transaction.commit_on_success
def delete_patient_medical_record(request):
    """
    Only open to admin or uploader
    Required:
    - medical_record_id, int
    """
    auth_user = get_auth_user(request)
    if not auth_user:
        return HttpResponseForbidden('AUTHENTICATION FAIL OR NOT LOGGED IN')

    data = request.REQUEST

    medical_record_id = data['medical_record_id']
    medical_record  = MedicalRecord.objects.get(id=int(medical_record_id))

    if not auth_user.is_admin() and not auth_user.id == medical_record.uploader_id:
        return HttpResponseForbidden('LACK PREVILEGE')

    # Delete MedicalRecord
    medical_record.deleted = 1
    medical_record.save()

    # Delete data in mongodb
    db = get_mongo_db()
    remove_medical_record_data(medical_record.data_id, db=db)
    remove_patient_statistic(medical_record.data_id, db=db)

    # Delete comments
    RecordComment.objects.filter(record_id=medical_record.id).update(deleted=1)

    return HttpResponse(json.dumps(view_model(medical_record), cls=ComplexEncoder))

@csrf_exempt
@transaction.commit_on_success
def add_comment(request):
    """
    Only open to admin or related doctor
    Required:
    - comment, string
    - medical_record_id, int
    """
    # 0. Is logged on
    auth_user = get_auth_user(request)
    if not auth_user:
        return HttpResponseForbidden('AUTHENTICATION FAIL')

    # 1. Check data format
    data = request.REQUEST
    response = is_field_missing(data, ['comment', 'medical_record_id'])
    if response is not None:
        return response

    comment_content = data['comment']
    medical_record = MedicalRecord.objects.get(id=int(data['medical_record_id']))
    patient = medical_record.patient

    # 2. Check privillege
    if not auth_user.is_doctor() and not auth_user.is_admin():
        return HttpResponseForbidden('COMMENTS ARE ONLY AVAILABLE TO DOCTOR AND ADMIN')

    if auth_user.is_doctor() and not is_overseer(overseer_id=auth_user.id, patient_id=patient.id):
        return HttpResponseForbidden('PATIENT NOT UNDER SUPERVISION OF DOCTOR')

    # 3. Add comment
    comment_obj = RecordComment(record_id=medical_record.id, 
                                content=comment_content, 
                                comment_time=datetime.now(), 
                                commentor_id=auth_user.id)
    comment_obj.save()

    return HttpResponse(json.dumps(view_model(comment_obj), cls=ComplexEncoder))


@csrf_exempt
@transaction.commit_on_success
def patient_statistic(request):
    """
    Getting statistic like BLOOD_PRESSURE, BODY_TEMPERATURE, etc
    Only open to those who having access to the patient
    Required:
    - patient_id
    Non-required:
    - start_time, string
    - end_time, string
    both in the format of yyyy-mm-dd HH:MM:SS
    """
    auth_user = get_auth_user(request)
    if auth_user is None:
        return HttpResponseForbidden('AUTHENTICATION FAIL OR NOT LOGGED IN')

    data = request.REQUEST
    res = is_field_missing(data, ['patient_id'])
    if res: return res

    patient_id = data['patient_id']
    patient = Patient.objects.get(id=int(patient_id))

    if not is_user_having_access_to_patient(user=auth_user, patient=patient):
        return HttpResponseForbidden('HAVE NO ACCESS TO PATIENT')

    start_time = data.get('start_time', None)
    end_time = data.get('end_time', None)
    if start_time: start_time = datetime.strptime(start_time, DEFAULT_TIME_FORMAT)
    if end_time:   end_time   = datetime.strptime(end_time, DEFAULT_TIME_FORMAT)

    response_data = {}
    print data
    for key in MedicalRecord.RECORD_STATISTIC_KEYS:
        if data.has_key(key):
            response_data[key] = []

            statistic = get_patient_statistic(patient.id, key, limit=100, start_time=start_time, end_time=end_time)
            response_data[key] = statistic

    return HttpResponse(json.dumps(response_data, cls=ComplexEncoder))

def is_device_id_valid(device_id):
    return True if device_id and len(device_id) == 48 else False

class ApiException(Exception):
    def __init__(self, message):
        self.message = message
    def __str__(self):
        return self.message

def wrap_json_api(more, *args):
    if more is True:
        backup_args = args
        def wrap_json_api_(func):
            def wrapper(request):
                try:
                    result = func(request)
                except Exception, exception:
                    result = {"error": str(exception)}
                return HttpResponse(json.dumps(result, cls=ComplexEncoder), content_type="application/json")
            ret = wrapper
            for wrap_i in backup_args[::-1]:
                ret = wrap_i(ret)
            return ret
        return wrap_json_api_
    def wrapper(request):
        try:
            result = more(request)
        except ApiException, exception:
            result = {"error": str(exception)}
        return HttpResponse(json.dumps(result, cls=ComplexEncoder), content_type="application/json")
    return wrapper

class DeviceNotExistException(ApiException):
    def __init__(self):
        self.message = "Please give a valid device id"

@wrap_json_api(True, csrf_exempt)
def get_user_by_device(request):
    """
    Getting a user's information using a device id.
    All allowed.
    Required:
    - device_id (in GET or POST)
    """
    device_id = request.REQUEST.get('device_id', '')
    if not is_device_id_valid(device_id):
        raise DeviceNotExistException()
    device_id = device_id.lower()
    try:
        bind_re = RE_DeviceBind.objects.get(device_id=device_id)
    except RE_DeviceBind.DoesNotExist:
        raise DeviceNotExistException()
    user = bind_re.used_user
    if not user or user.deleted or not user.role == User.PATIENT:
        raise ApiException("Device \"" + device_id + "\" is not registered!")
    return {
        "username": user.username,
        "guid": user.guid,
        "name": user.name,
        "avatar_url": user.avatar_url,
        "bindtime": bind_re.bind_time
    }

@wrap_json_api(True, transaction.atomic, csrf_exempt)
def bind_device_to_user(request):
    """
    bind a device to a patient.
    Only open to those who having access to the patient.
    Required:
    - device_id
    """
    auth_user = get_auth_user(request)
    if auth_user is None:
        raise ApiException('AUTHENTICATION FAIL OR NOT LOGGED IN')
    device_id = request.POST.get('device_id', '')
    if not is_device_id_valid(device_id):
        raise DeviceNotExistException()
    device_id = device_id.lower()
    try:
        bind_re = RE_DeviceBind.objects.get(device_id=device_id)
        if bind_re.used_user and not bind_re.used_user.deleted:
            if not bind_re.used_user.username == auth_user.username:
                raise ApiException("Device \"" + device_id + "\" has been bound to others!")
            else:
                return {"result": "OK", "bind_time": bind_re.bind_time, "has_bound": True}
        else:
            bind_re.used_user = auth_user
            bind_re.save()
            return {"result": "OK", "bind_time": bind_re.bind_time}
    except RE_DeviceBind.DoesNotExist:
        raise DeviceNotExistException()

@wrap_json_api(True, transaction.atomic, csrf_exempt)
def unbind_device(request):
    """
    unbind a device which belonged to a patient.
    Only open to those who having access to the patient.
    Required:
    - device_id
    """
    auth_user = get_auth_user(request)
    if auth_user is None:
        raise ApiException('AUTHENTICATION FAIL OR NOT LOGGED IN')
    device_id = request.POST.get('device_id', '')
    if not is_device_id_valid(device_id):
        raise DeviceNotExistException()
    device_id = device_id.lower()
    try:
        bind_re = RE_DeviceBind.objects.get(device_id=device_id)
        if bind_re.used_user:
            if bind_re.used_user.deleted or bind_re.used_user.username == auth_user.username:
                bind_re.used_user = None
                bind_re.save()
                return {"result": "OK", "unbind_time": bind_re.bind_time}
            else:
                raise ApiException("Device \"" + device_id + "\" does not belong to this user!")
        else:
            return {"result": "OK", "unbind_time": bind_re.bind_time}
    except RE_DeviceBind.DoesNotExist:
        raise DeviceNotExistException()


@wrap_json_api(True, transaction.commit_on_success, csrf_exempt)
def upload_device_record(request):
    """
    Take upload data got by a device and create a medical record for a patient
    Only open to patients
    Required:
    - (auth), a patient user
    - device_id, [string] a device's license
    - record_time, [string] when was it uploaded
    - data_file, [file] a zip file following a certain directory structure like this:
        root
            data.json ---- Contains a json string; All image/audio path is relative
                username
                license
                recordtime
                ...
            other files
    """
    data = request.POST
    files = request.FILES
    
    # 1. Authentication    
    user = get_auth_user(request)

    if user is None or not user.role == User.PATIENT or user.deleted:
        raise ApiException('AUTHENTICATION FAIL OR NOT LOGGED IN')
    # 2. Check if any field is missing
    for field in (u'device_id', u'record_time'):
        if data.get(field, None) is None:
            raise ApiException('%s FIELD MUST BE PROVIDED' %(field))

    if not files.has_key(u'data_file'):
        raise ApiException('data_file FIELD MUST BE PROVIDED')

    record_time = data['record_time']
    try:
        record_time = datetime.strptime(record_time, DEFAULT_TIME_FORMAT)
    except Exception:
        raise ApiException('record_time format must follow %s' %(DEFAULT_TIME_FORMAT))
    
    # 4. Extract the file
    save_zip_path = config.get_new_zip_file_path()
    print "SAVING ZIP TO", save_zip_path

    fs = open(save_zip_path, 'wb')
    fs.write(files['data_file'].read())
    fs.close()

    record_file_dir = config.get_new_record_file_directory()
    zip_file_obj = zipfile.ZipFile(save_zip_path, 'r')
    zip_file_obj.extractall(record_file_dir)
    print 'UNZIP TO %s' %(record_file_dir)    

    # 5. There must be a file called data.json
    data_file = os.path.join(record_file_dir, 'data.json')

    if not os.path.exists(data_file):
        raise ApiException('UPLOAD FILE CONTAINS NO data.json')

    # 6. Load content and insert into db
    data_content = json.loads(open(data_file).read())
    def replace_file_path(obj):
        if isinstance(obj, dict):
            if obj.has_key('file'):
                obj['file'] = os.path.join(record_file_dir, obj['file']).replace('\\', '/').replace(settings.ROOT_DIR, '')

            for key in obj.keys():
                print key
                replace_file_path(obj[key])
        elif isinstance(obj, list):
            for item in obj:
                replace_file_path(item)

    replace_file_path(data_content)

    mongo_db = get_mongo_db()
    data_id = add_medical_record_data(data_content, db=mongo_db)
    
    # medical_record = MedicalRecord(patient_id=patient.id, 
                                   # serial_number=serial_number, 
                                   # uploader_id=user.id,
                                   # upload_time=datetime.now(),
                                   # data_id=str(data_id),
                                   # record_time=record_time)

    # medical_record.save()

    return {'success': True, 'json': data_content}
