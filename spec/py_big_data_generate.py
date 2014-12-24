from pymongo import DESCENDING, MongoClient
from bson import ObjectId
import json
    
# from 1970-01-01 to 2015-01-01
TIME_OFFSET = 1420070400
DAY_OFFSET = 16436
DEFAULT_TIME_STEP = 60

MONGO_HOST, MONGO_PORT = '127.0.0.1', 27017
MONGO_BIG_DATA_URL = "mongodb://%s:%d/health_miner" % (MONGO_HOST, MONGO_PORT)
MONGO_BIG_DATA_INDEX = "bigdata_index"
MONGO_BIG_DATA_DATA = "bigdata_data"

class MongoBigDataManager:
    MONGO_DB_URL = MONGO_BIG_DATA_URL
    MONGO_TABLE_NAME_INDEX = MONGO_BIG_DATA_INDEX
    MONGO_TABLE_NAME_BIGDATA = MONGO_BIG_DATA_DATA
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
            data_days = list(self.get_db()[self.MONGO_TABLE_NAME_BIGDATA].find(query, limit=len(data_indexes)))
            data_days.sort(key=lambda data: data["start"], reverse=True)
            # TODO: check its speed & mongodb version
            # data_days = self.get_db()[self.MONGO_TABLE_NAME_BIGDATA].find(query, limit=len(data_indexes), sort=('start', DESCENDING))
            data_indexes = None
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
        for data_one_day in data_days:
            type_index = -1
            for type in self.types:
                type_index += 1
                if type not in data_one_day:
                    continue
                data_items = filter(filter_time, data_one_day[type])
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
        return result
    
    def get_filter_by_step(self):
        last = 8388607
        step = self.step
        def filter_item_by_step(item):
            global last
            if item[0] < last:
                last = item[0] / step * step
                return True
            else:
                return False
        def filter_reset():
            global last
            if last != 8388607:
                last = 8388607
        return filter_item_by_step, filter_reset

    @staticmethod
    def clean_connections(self):
        MongoBigDataManager.__CONNS__ = {}
        
    def make_testing_data(self):
        step = self.step if self.step >= 2 else 60
        max_point_num = (self.end - self.start) / 60
        body_temperature = range(max_point_num)
        heart_rate = range(max_point_num)
        blood_pressure = range(max_point_num)
        from random import random as rand
        i = 0; time = self.start
        while time < self.end:
            body_temperature[i] = (time, round((36.8 + 2 * pow(rand(), 3)) * 100) / 100);
            heart_rate[i]       = (time, round((70 + 10 * pow(rand() - 0.4, 3)) * 100) / 100);
            blood_pressure[i]   = (time, round((110 + 25 * pow(rand(), 2)) * 100) / 100, round((70 + 20 * rand()) * 100) / 100);
            i += 1; time += 60
        self.get_db()[self.MONGO_TABLE_NAME_BIGDATA].insert({
            "start": self.start,
            "body_temperature": body_temperature,
            "heart_rate": heart_rate,
            "blood_pressure": blood_pressure
        })
        item = self.get_db()[self.MONGO_TABLE_NAME_BIGDATA].find({
            "start": self.start
        })[0]
        try:
            data_id = item._id
            print "item._id is ", item._id
        except Exception:
            data_id = item["_id"]
            print "item has no member '_id', the _id is ", data_id
        self.get_db()[self.MONGO_TABLE_NAME_INDEX].insert({
            "user": self.user,
            "day": self.start / 86400,
            "data": data_id
        })
        print "new index:", self.get_db()[self.MONGO_TABLE_NAME_INDEX].find({
            "data": data_id
        })[0]

_backup_day = 4
def get_limited_data(day = None):
    dbm = MongoBigDataManager()
    dbm.set_user(29)
    day = _backup_day if day is None else day
    dbm.set_start(day * 86400)
    dbm.set_end(day * 86400 + 86400 + 60)
    dbm.set_step(2)
    dbm.set_types(["body_temperature", "heart_rate", "blood_pressure"])
    result = {"user": "aa", "start": dbm.start, "end": dbm.end, "types": dbm.types}
    if dbm.is_input_valid():
        res = dbm.select_data_to_array()
        j = -1
        for i in dbm.types:
            j += 1
            result[i] = res[j]
    return result
    
def make_data_one_day(day = 4, user=29):
    global _backup_day
    _backup_day = day
    dbm = MongoBigDataManager()
    dbm.set_user(29)
    dbm.set_start(day * 86400)
    dbm.set_end(day * 86400 + 86400)
    dbm.set_step(0)
    dbm.set_types(["body_temperature", "heart_rate", "blood_pressure"])
    result = {"user": "aa", "start": dbm.start, "end": dbm.end, "types": dbm.types}
    if dbm.is_input_valid():
        print "make: valid"
        res = dbm.make_testing_data()
    else:
        print "make: invalid", dbm.start, dbm.end, dbm.types

if __name__ == "__main__":
    data = get_limited_data(6)
    print data["types"]
    for i in data:
        data[i] = len(data[i]) if type(data[i]) is list else data[i]
    print data
