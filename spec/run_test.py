# coding=utf-8
import unittest
from fp_tools.proxy import proxy
import hashlib
import uuid, random
from poster.encode import multipart_encode
from poster.streaminghttp import register_openers
import json, urllib2
from config import HOST
from datetime import datetime

URL_CREATE_USER = HOST + '/api/user/create'
URL_LOGIN = HOST + '/api/user/login'
URL_GET_USERS = HOST + '/api/users'
URL_GENERATE_CODE = HOST + '/api/registration_code/create'
URL_REGISTER = HOST + '/api/user/register'
URL_UPDATE_USER = HOST + '/api/user/update'
URL_ADD_OVERSEER = HOST + '/api/patient/add_overseer'
URL_SET_OVERSEER = HOST + '/api/patient/set_overseer'
URL_REMOVE_OVERSEER = HOST + '/api/patient/remove_overseer'
URL_ADD_RECORD = HOST + '/api/medical_record/create'
URL_GET_RECORDS = HOST + '/api/medical_records'
URL_GET_PATIENTS = HOST + '/api/patients'
URL_ADD_COMMENT = HOST + '/api/medical_record/comment/add'
URL_DELETE_RECORD = HOST + '/api/medical_record/delete'

def random_id():
    uid = uuid.uuid1()
    uids = str(uid).split('-')
    return uids[0] + uids[3]

def password_enctrype(password):
    md5 = hashlib.md5()
    md5.update(password)
    return md5.hexdigest()

def login(username, password):
    return proxy(URL_LOGIN, 'POST', {'username': username, 'password': password})

def update_user(user_id, data):
    data['user_id'] = user_id
    return proxy(URL_UPDATE_USER, 'POST', data)

def get_users(data):
    users = json.loads(proxy(URL_GET_USERS, 'GET', data))['users']
    return users

def get_patients(data):
    return json.loads(proxy(URL_GET_PATIENTS, 'GET', data))['patients']

def add_comment(record_id, content, auth_data=None):
    data = {'medical_record_id': record_id, 'comment': content}
    data.update(auth_data)

    return json.loads(proxy(URL_ADD_COMMENT, 'POST', data))

def set_patient_overseer(overseer_ids, patient_id, auth_data=None):
    data = auth_data or {}
    data.update({'overseer_ids': overseer_ids, 'patient_id': patient_id})
    return proxy(URL_SET_OVERSEER, 'POST', data)

def add_patient_overseer(overseer_id, patient_id, auth_data=None):
    data = auth_data or {}
    data.update({'overseer_id': overseer_id, 'patient_id': patient_id})
    return proxy(URL_ADD_OVERSEER, 'POST', data)

def remove_patient_overseer(overseer_id, patient_id, auth_data=None):
    data = auth_data or {}
    data.update({'overseer_id': overseer_id, 'patient_id': patient_id})
    return proxy(URL_REMOVE_OVERSEER, 'POST', data)

register_openers()
def add_medical_record(patient_username, serial_number, file_path, auth_data=None):
    post_data = {'patient_username': patient_username, 'serial_number': serial_number, 'data_file': open(file_path), 'record_time': datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
    post_data.update(auth_data or {})

    register_openers()
    datagen, headers = multipart_encode(post_data)
    print 'ENCODE DONE'
    request = urllib2.Request(URL_ADD_RECORD, datagen, headers)
    response = urllib2.urlopen(request).read()
    return response

def delete_medical_record(record_id, auth_data=None):
    post_data = {'medical_record_id': record_id}

    post_data.update(auth_data or {})

    res = proxy(URL_DELETE_RECORD, 'POST', post_data)
    return res

def upload_avatar(user_id, img_file_path, auth_data=None):
    post_data = auth_data or {}
    post_data['user_id'] = user_id
    post_data['avatar'] = open(img_file_path)

    datagen, headers = multipart_encode(post_data)

    request = urllib2.Request(URL_UPDATE_USER, datagen, headers)
    response = urllib2.urlopen(request).read()

    return response

def get_medical_records(patient_id, auth_data=None):
    data = auth_data or {}
    data['patient_id'] = patient_id

    return json.loads(proxy(URL_GET_RECORDS, 'POST', data))['records']

class SimpleTestCase(unittest.TestCase):

    def setUp(self):
        self.username = 'admin'
        self.password = password_enctrype('admin')

    def test_create_user_and_login(self):
        for role in (1, 2, 3, 4):
            username = random_id()
            password = password_enctrype(username)
            data = self.get_basic_post_data()

            data['username'] = username
            data['password'] = password
            data['name'] = u'name' + username
            data['role'] = role

            proxy(URL_CREATE_USER, 'POST', data)
            login(username, password)

    def get_basic_post_data(self):
        return {'auth_username': self.username, 'auth_password': self.password}

    def test_user_update(self):
        users = get_users(self.get_basic_post_data())

        for user in users:
            if user['role']['name'] in ('admin', ):
                continue

            user_id = user['id']

            data = self.get_basic_post_data()

            data['password'] = password_enctrype(random_id())
            data['role'] = random.randint(2, 4)
            data['email'] = random_id()
            data['phone'] = random_id()
            data['address'] = random_id()

            update_user(user_id, data)

            login(user['username'], data['password'])

    def test_patient_overseer(self):
        users = get_users(self.get_basic_post_data())

        doctors_and_advisors = filter(lambda u: u['role']['name'] in ('doctor', 'advisor'), users)
        all_patients = get_patients(self.get_basic_post_data())

        def is_overseer(overseer_id, patient_id):
            overseer = next(u for u in doctors_and_advisors if u['id'] == overseer_id)
            patients = get_patients({'auth_username': overseer['username'], 'auth_password': overseer['password']})

            return patient_id in map(lambda p: p['id'], patients)
        
        for patient in all_patients:
            random.shuffle(doctors_and_advisors)
            overseers = doctors_and_advisors[:5]
            set_patient_overseer(overseer_ids=','.join(map(lambda u: str(u['id']), overseers)), patient_id=patient['id'], auth_data=self.get_basic_post_data())

            for overseer in overseers:
                self.assertTrue(is_overseer(overseer['id'], patient['id']))

            for overseer in filter(lambda v: v not in overseers, doctors_and_advisors):
                self.assertFalse(is_overseer(overseer['id'], patient['id']))

            for overseer in overseers:
                remove_patient_overseer(overseer_id=overseer['id'], patient_id=patient['id'], auth_data=self.get_basic_post_data())   
                self.assertFalse(is_overseer(overseer['id'], patient['id']))

                add_patient_overseer(overseer_id=overseer['id'], patient_id=patient['id'], auth_data=self.get_basic_post_data())   
                self.assertTrue(is_overseer(overseer['id'], patient['id']))


    def test_medical_records(self):
        # return
        all_patients = get_patients(self.get_basic_post_data())

        random.shuffle(all_patients)

        all_patients = all_patients[:5]

        for patient in all_patients:
            for round_index in range(5):
                print 'PROCESSING PATIENT %d' %(patient['id'])
                print 'GETTING RECORDS'
                records = get_medical_records(patient['id'], self.get_basic_post_data())

                new_serial_number = random_id()
                print 'POST NEW RECORD'
                add_medical_record(patient['user']['username'], new_serial_number, 'upload_data.zip', self.get_basic_post_data())

                print 'GETTING NEW RECORDS'
                new_records = get_medical_records(patient['id'], self.get_basic_post_data())

                self.assertEqual(len(new_records), len(records) + 1)
                self.assertEqual(new_records[0]['serial_number'], new_serial_number)

            new_records = get_medical_records(patient['id'], self.get_basic_post_data())
            random.shuffle(new_records)
            random_record = new_records[0]

            # Delete it
            delete_medical_record(random_record['id'], self.get_basic_post_data())
            records_after_delete = get_medical_records(patient['id'], self.get_basic_post_data())

            self.assertEqual(len(records_after_delete) + 1, len(new_records))
            for r in records_after_delete:
                self.assertTrue(r['id'] != random_record['id'])

    def test_register(self):
        for role in (2, 3, 4):
            post_data = self.get_basic_post_data()
            post_data['user_role'] = role

            res = proxy(URL_GENERATE_CODE, 'POST', post_data)
            code = json.loads(res)['code']

            username = random_id()
            password = password_enctrype(username)

            post_data = {'username': username, 'password': password, 'name': random_id(), 'user_role': role, 'registration_code': code}
            proxy(URL_REGISTER, 'POST', post_data)

            login(username, password)

    def test_upload_avatar(self):
        # return
        all_users = get_users(self.get_basic_post_data())
        for user in all_users:
            print 'UPLOADING FOR USER %d' %(user['id'])
            upload_avatar(user['id'], 'test.jpg', self.get_basic_post_data())

    def test_add_comment(self):
        patients = get_patients(self.get_basic_post_data())
        random.shuffle(patients)

        selected_patient = patients#[: 5]
        for patient in selected_patient:
            records = get_medical_records(patient['id'], self.get_basic_post_data())
            for record in records:
                res = add_comment(record['id'], content=random_id(), auth_data=self.get_basic_post_data())

            new_records = get_medical_records(patient['id'], self.get_basic_post_data())
            for idx, record in enumerate(records):
                new_record = next(r for r in new_records if r['id'] == record['id'])
                self.assertTrue(len(record['comments']) + 1, len(new_record['comments']))

if __name__ == '__main__':
    unittest.main()