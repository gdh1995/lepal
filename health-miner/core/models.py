
from django.db import models
import uuid
from health_miner import settings
from django.shortcuts import *
import random
from django.db.models.query import Q
from pymongo import MongoClient
import json
from health_miner import settings
from bson import ObjectId
import config
import os
from pymongo import DESCENDING

class FileNotQualifiedException(Exception):

    def __init__(self, msg):
        self.msg = msg

    def get_msg(self):
        return self.msg

class User(models.Model):
    ADMINISTRATOR = 1
    DOCTOR        = 2
    ADVISOR       = 3
    PATIENT       = 4
    ROLES = (1, 2, 3, 4)

    username        = models.CharField(max_length=100, unique=True)
    password        = models.CharField(max_length=100)
    guid            = models.CharField(max_length=50, null=True)
    name            = models.CharField(max_length=250)
    email           = models.CharField(max_length=250, null=True)
    phone           = models.CharField(max_length=100, null=True)
    sex             = models.IntegerField(null=True) # 1 for male, 2 for female
    age             = models.IntegerField(null=True)
    address         = models.CharField(max_length=500, null=True)
    register_time   = models.DateTimeField()
    role            = models.IntegerField()
    avatar_url      = models.TextField(null=True)
    deleted         = models.BooleanField(default=0)

    """
    User role:
    1. Admin 2. Doctor 3. Advisor 4. Patient
    """
    def is_admin(self):
        return self.role == User.ADMINISTRATOR

    def is_doctor(self):
        return self.role == User.DOCTOR

    def is_advisor(self):
        return self.role == User.ADVISOR

    def is_patient(self):
        return self.role == User.PATIENT

    def generate_guid(self):
        self.guid = 'M0' + str(self.role) + str(1000000000 + self.id)
        self.save()

    def update_avatar(self, file_stream):
        if not os.path.splitext(file_stream.name)[1].lower() in ('.jpg', '.png', '.bmp', '.tif'):
            raise FileNotQualifiedException('ONLY SUPPORT: jpg, png, bmp, tif')

        content = file_stream.read()
        
        IMAGE_SIZE_LIMIT = 1024 * 1024 * 4; # 8M
        print len(content)
        if len(content) > IMAGE_SIZE_LIMIT:
            raise FileNotQualifiedException('FILE SIZE IS %d, MUST BE LESS THAN %d(4M)' %(len(content), IMAGE_SIZE_LIMIT))

        new_image_path = config.get_new_image_file_path(file_stream.name)
        ofs = open(new_image_path, 'wb')
        ofs.write(content)
        ofs.close()

        self.avatar_url = new_image_path.replace(settings.ROOT_DIR, '').replace('\\', '/')
        self.save()

class Administrator(models.Model):
    user            = models.ForeignKey(User, unique=True)
    deleted         = models.BooleanField(default=0)

class Doctor(models.Model):
    user            = models.ForeignKey(User, unique=True)
    deleted         = models.BooleanField(default=0)

class Advisor(models.Model):
    user            = models.ForeignKey(User, unique=True)
    deleted         = models.BooleanField(default=0)

class Patient(models.Model):
    user            = models.ForeignKey(User, unique=True)
    deleted         = models.BooleanField(default=0)

class RE_OverseePatientsManager(models.Manager):
    def add_overseer(self, patient, overseer):
        relation = RE_OverseePatients(overseer_id=overseer.id, patient_id=patient.id)

        if overseer.role == User.ADVISOR:
            relation.overseer_type = RE_OverseePatients.ADVISOR
        elif overseer.role == User.DOCTOR:
            relation.overseer_type = RE_OverseePatients.DOCTOR

        relation.save()

class RE_OverseePatients(models.Model):
    DOCTOR = 1
    ADVISOR = 2

    objects         = RE_OverseePatientsManager()
    overseer        = models.ForeignKey(User)
    overseer_type   = models.IntegerField() # 1. Doctor, 2. Advisor
    patient         = models.ForeignKey(Patient)
    deleted         = models.BooleanField(default=0)

    

class MedicalRecord(models.Model):
    RECORD_STATISTIC_KEYS               = ('blood_pressure', 'blood_glucose', 'body_temperature', 'heart_rate')
    RECORD_STATISTIC_BLOOD_PRESSURE     = 'blood_pressure'
    RECORD_STATISTIC_BLOOD_GLUCOSE      = 'blood_glucose'
    RECORD_STATISTIC_BODY_TEMPERATURE   = 'body_temperature'
    RECORD_STATISTIC_HEART_RATE         = 'heart_rate'

    uploader        = models.ForeignKey(User, null=True)
    upload_time     = models.DateTimeField()
    record_time     = models.DateTimeField()
    patient         = models.ForeignKey(Patient)
    serial_number   = models.CharField(max_length=150)
    data_id         = models.CharField(max_length=250, unique=True)
    deleted         = models.BooleanField(default=0)

class RecordComment(models.Model):
    record          = models.ForeignKey(MedicalRecord)
    commentor       = models.ForeignKey(User)
    target_comment  = models.ForeignKey('RecordComment', null=True)
    content         = models.TextField()
    comment_time    = models.DateTimeField()
    update_time     = models.DateTimeField(auto_now=True)
    deleted         = models.BooleanField(default=0)

class RegistrationCode(models.Model):
    NEWLY_CREATED   = 1
    USED            = 2
    OVERDUE         = 3

    code            = models.CharField(max_length=100, unique=True)
    generator       = models.ForeignKey(User, related_name='generated by whom')
    generate_time   = models.DateTimeField()
    user_role       = models.IntegerField()
    state           = models.IntegerField() # 0: Newly created, 1: Used, 2: Overdue
    used_user       = models.ForeignKey(User, null=True, related_name='used for who') # Who register using this
    used_time       = models.DateTimeField(null=True)
    deleted         = models.BooleanField(default=0)

def get_mongo_db():
    return MongoClient(host=settings.MONGO_HOST, port=settings.MONGO_PORT).health_miner

def add_medical_record_data(data, db=None):
    db = db or get_mongo_db()
    return db.MedicalRecordData.insert(data)

def remove_medical_record_data(data_id, db=None):
    db = db or get_mongo_db()
    return db.MedicalRecordData.remove({'_id': ObjectId(data_id)})

def find_medical_record_data(data_id, db=None):
    db = db or get_mongo_db()
    return db.MedicalRecordData.find_one({'_id': ObjectId(data_id)})

def insert_patient_statistic(record_list, db=None):
    db = db or get_mongo_db()
    for record in record_list:
        for field in ('time', 'key', 'data_id', 'upload_time', 'patient_id'):
            assert record.has_key(field)

        if record['key'] == MedicalRecord.RECORD_STATISTIC_BLOOD_PRESSURE:
            assert record.has_key('low')
            assert record.has_key('high')
        else:
            assert record.has_key('value')

    return db.PatientStatistic.insert(record_list)

def remove_patient_statistic(record_data_id, db=None):
    db = db or get_mongo_db()
    return db.PatientStatistic.remove({'data_id': str(record_data_id)})

def get_patient_statistic(patient_id, key, db=None, limit=None, start_time=None, end_time=None):
    db = db or get_mongo_db()
    query = {'patient_id': patient_id, 'key': key}
    if start_time or end_time:
        query['time'] = {}
        if start_time:
            query['time']['$gte'] = start_time
            query['time']['$lte'] = end_time

    return list(db.PatientStatistic.find(query, limit=limit, sort=[('time', DESCENDING)]))







