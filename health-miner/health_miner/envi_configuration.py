__author__ = 'Oppy'

import settings, os, uuid
from datetime import datetime, date

#HOST='115.29.147.203'
#HOST='nhsdlctab.com'

HOST = 'nhsdlctab.com'
# HOST = '127.0.0.1:8000'
def make_uuid():
    uid = str(uuid.uuid1()).split('-')
    return uid[0] + uid[3]

def check_dir(dir):
    if not os.path.isdir(dir):
        os.mkdir(dir)
    return dir

def get_absolute_path(relative_dir):
    return settings.ROOT_DIR + relative_dir

check_dir(get_absolute_path('/upload'))
check_dir(get_absolute_path('/upload/img'))
check_dir(get_absolute_path('/upload/excel'))

def get_upload_img_path_relative(filename):
    fns = os.path.splitext(filename)
    today_dir = '/upload/img/' + date.today().strftime('%Y-%m-%d')
    check_dir(get_absolute_path(today_dir))
    return today_dir + '/' + make_uuid() + fns[1]

def get_upload_excel_path_relative(filename, random=True):
    today_dir = '/upload/excel/' + date.today().strftime('%Y-%m-%d')
    check_dir(get_absolute_path(today_dir))
    if random:
        fns = os.path.splitext(filename)
        return today_dir + '/' + make_uuid() + fns[1]
    else:
        return today_dir + '/' + filename
