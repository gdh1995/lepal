__author__ = 'gdh1995'

from pymongo import DESCENDING, MongoClient
from bson import ObjectId
from health_miner import settings
from api import ApiException, wrap_json_api, is_device_id_valid
from models import User
from django.http import HttpResponse, HttpRequest
from django.views.decorators.csrf import csrf_exempt
from datetime import datetime
import json
    
# from 1970-01-01 to 2015-01-01
TIME_OFFSET = 1420070400
DAY_OFFSET = 16436
# DEFAULT_TIME_STEP = 60

class MongoBigDataManager:
    MONGO_DB_URL = settings.MONGO_DATABASE_URL
    MONGO_TABLE_NAME_INDEX = settings.MONGO_BIG_DATA_INDEX
    MONGO_TABLE_NAME_BIGDATA = settings.MONGO_BIG_DATA_DATA
    __CONNS__ = None
    
    # map: key => database_url, table_name, val_count
    TYPE_PARAMS_MAP = {
        "body_temperature": ("body_temperature", 1),
        "heart_rate": ("heart_rate", 1),
        "blood_pressure": ("blood_pressure", 2),
    }
    MAX_COUNT = 14400
    
    @staticmethod
    def get_db():
        if MongoBigDataManager.__CONNS__ is None:
            MongoBigDataManager.__CONNS__ = MongoClient(host=MongoBigDataManager.MONGO_DB_URL).get_default_database()
        return MongoBigDataManager.__CONNS__

    def __init__(self):
        self.user = ""
        self.start = 0
        self.end = 0
        self.step = 0
        self.types = ""
        self.limit = self.MAX_COUNT

    def set_user(self, user):
        self.user = int(user)

    def set_start(self, start):
        self.start = start

    def set_end(self, end):
        self.end = end

    def set_step(self, step):
        self.step = step

    def set_limit(self, limit):
        self.limit = limit

    def set_types(self, types):
        all_valid_types = self.TYPE_PARAMS_MAP
        self.types = [i for i in types if i in all_valid_types]

    def is_input_valid(self):
        return len(self.types) > 0 and self.start >= 0 and self.end > self.start

    def select_index(self):
        day_start = self.start / 86400
        day_end = (self.end + 86340) / 86400
        query = {"user": self.user, "day": {"$gte": day_start, "$lt": day_end}}
        try:
            table = self.get_db()[self.MONGO_TABLE_NAME_INDEX]
            return [i["data"] for i in table.find(query, limit=(day_end - day_start))]
        except Exception:
            return ()

    def select_data_to_array(self, data_indexes=None):
        if data_indexes is None:
            data_indexes = self.select_index()
        if len(data_indexes) <= 0 or len(self.types) <= 0:
            return ((),) * len(self.types)
        try:
            query = {"_id": {"$in": data_indexes}}
            #data_days = list(self.get_db()[self.MONGO_TABLE_NAME_BIGDATA].find(query, limit=len(data_indexes)))
            #data_days.sort(key=lambda data: data["start"], reverse=True)
            # TODO: check its speed & mongodb version
            data_days = self.get_db()[self.MONGO_TABLE_NAME_BIGDATA].find(query, limit=len(data_indexes), sort=(('start', DESCENDING),))
        except Exception:
            return ((),) * len(self.types)
        result = [()] * len(self.types)
        type_index = len(self.types)
        while type_index > 0:
            type_index -= 1
            result[type_index] = []
        filter_time = lambda i: self.start <= i[0] < self.end
        if self.step >= 2:
            filter_step, filter_reset = self.get_filter_by_step()
        day_index = -1
        for data_one_day in data_days:
            type_index = -1
            for type in self.types:
                type_index += 1
                if type not in data_one_day:
                    continue
                data_items = data_one_day[type]
                if day_index <= 0:
                    data_items = filter(filter_time, data_items)
                if len(data_items) <= 0:
                    continue
                result_one_type = result[type_index]
                num_over = len(result_one_type) - self.limit
                if num_over >= 0:
                    continue
                if self.step >= 86400:
                    data_items = (data_items[0], )
                elif self.step >= 61:
                    data_items = filter(filter_step, data_items[::-1])
                    filter_reset()
                else:
                    data_items = data_items[num_over:]
                result_one_type.extend(data_items)
                data_items = None
            if day_index == -1:
                day_index = len(data_indexes) - 2
            else:
                day_index -= 1
        return result
    
    def get_filter_by_step(self):
        last = [8388607]
        step = self.step
        def filter_item_by_step(item):
            if item[0] < last[0]:
                last[0] = item[0] / step * step
                return True
            else:
                return False
        def filter_reset():
            last[0] = 8388607
        return filter_item_by_step, filter_reset

    @staticmethod
    def clean_connections(self):
        MongoBigDataManager.__CONNS__ = {}


@wrap_json_api(True, csrf_exempt)
def get_limited_data(request):
    """
    query visiable data which belongs to a patient.
    TODO: Only open to those who having access to the patient.
    Required: json request
    - user: string, user's name which is unique
    - types: string array, data types wanted
    - start: int, second number from UTC Date "2015-01-01 00:00:00"
    - end: int, should be larger than start, excluded
    - step: int, second number of data units' interval in response, default: 0
    Returned: json object
    - user: string, the same user name
    - types: string array, valid types
    - start: the same start
    - end: the same end
    - type1...: a 2-D arrays, each store [time, value1, value2, ...]
        - time: second number from UTC Date "2015-01-01 00:00:00"
        - value1, value2, ...: may be int or float
    """
    # TODO: check if having logged on
    data = request.read()
    if not data:
        raise ApiException("No Request!")
    try:
        data = json.loads(data)
        user_name = str(data["user"])
        types = data["types"]
        start = data["start"]
        end = data["end"]
        step = data["step"] if "step" in data else 0
    except Exception:
        raise ApiException("unknown type of parameters")
    if not (isinstance(types, list) and isinstance(start, int) and isinstance(end, int) and isinstance(step, int)
            and start > 0 and end > 0 and step >= 0 and step <= 86400):
        raise ApiException("bad value(s) of request")
    try:
        user = User.objects.get(username=user_name)
    except User.DoesNotExist:
        raise ApiException("unknown user name")
    if not user.role == User.PATIENT:
        raise ApiException("unknown user name")
    dbm =  MongoBigDataManager()
    dbm.set_user(user.id)
    dbm.set_start(start)
    dbm.set_end(end)
    dbm.set_step(step)
    dbm.set_types(types)
    result = {"user": user_name, "start": dbm.start, "end": dbm.end, "types": dbm.types}
    if dbm.is_input_valid():
        res = dbm.select_data_to_array()
        j = -1
        for i in dbm.types:
            j += 1
            result[i] = res[j]
    return result
