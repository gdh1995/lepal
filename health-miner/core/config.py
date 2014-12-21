# coding=utf-8
from health_miner.settings import ROOT_DIR
import os, uuid
from datetime import date, datetime

def check_dir(dirname):
    if not os.path.exists(dirname):
        os.mkdir(dirname)
    return dirname.replace('\\', '/')

UPLOAD_DIR = os.path.join(ROOT_DIR, 'uploads')
ZIP_FILE_DIR = os.path.join(UPLOAD_DIR, 'zipfiles')
RECORDS_STATIC_FILE_DIR = os.path.join(UPLOAD_DIR, 'records')
IMAGE_FILE_DIR = os.path.join(UPLOAD_DIR, 'image')

check_dir(UPLOAD_DIR)
check_dir(ZIP_FILE_DIR)
check_dir(RECORDS_STATIC_FILE_DIR)
check_dir(IMAGE_FILE_DIR)

def random_id():
    uid = uuid.uuid1()
    uids = str(uid).split('-')
    return uids[0] + uids[3]



def get_new_image_file_path(filename, origin_name=False):
	today = date.today()
	time_str = today.strftime('%Y-%m-%d')
	dirname = check_dir(os.path.join(IMAGE_FILE_DIR, time_str))
	if origin_name:
		filepath = os.path.join(dirname, filename)
	else:
		filepath = os.path.join(dirname, random_id() + os.path.splitext(filename)[1])
	return filepath
	
def get_new_record_file_directory():
    return check_dir(os.path.join(RECORDS_STATIC_FILE_DIR, random_id()))

def get_new_zip_file_path():
    return os.path.join(ZIP_FILE_DIR, random_id())