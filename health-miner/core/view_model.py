import models
import bson

def view_model(m):
    if isinstance(m, models.User):
        return UserViewModel(m).dumps()
    elif isinstance(m, models.MedicalRecord):
        return MedicalRecordViewModel(m).dumps()
    elif isinstance(m, models.Patient):
        return PatientViewModel(m).dumps()
    elif isinstance(m, models.RegistrationCode):
        return RegistrationCodeViewModel(m).dumps()
    elif isinstance(m, models.RecordComment):
        return RecordCommentViewModel(m).dumps()
    else:
        raise Exception('UNKNOWN MODEL')

def get_medical_record_data(data_id, db):
    return db.MedicalRecordData.find_one({'_id': bson.ObjectId(data_id)})

class ViewModel:
    def __init__(self, m):
        self.model = m

    def dumps(self):
        pass


class UserViewModel(ViewModel):
    def dumps(self):
        assert isinstance(self.model, models.User)

        data = {}
        for field in ('username', 'password', 'email', 'phone', 'id', 'name', 'guid', 'sex', 'age', 'address', 'avatar_url'):
            data[field] = getattr(self.model, field)

        data['register_time'] = self.model.register_time.strftime('%Y-%m-%d %H:%M:%S')

        if self.model.role == models.User.ADMINISTRATOR:
            role_name = 'admin'
        elif self.model.role == models.User.DOCTOR:
            role_name = 'doctor'
        elif self.model.role == models.User.ADVISOR:
            role_name = 'advisor'
        elif self.model.role == models.User.PATIENT:
            role_name = 'patient'

        data['role'] = {'id': self.model.role, 'name': role_name}

        return data

class PatientViewModel(ViewModel):
    def dumps(self):
        assert isinstance(self.model, models.Patient)

        data = {'user': view_model(self.model.user), 'id': self.model.id}

        return data

class MedicalRecordViewModel(ViewModel):
    def dumps(self):
        assert isinstance(self.model, models.MedicalRecord)

        data = {}
        for field in ('upload_time', 'data_id', 'id', 'serial_number', 'record_time'):
            data[field] = getattr(self.model, field)

        data['patient'] = view_model(self.model.patient)

        return data

class RegistrationCodeViewModel(ViewModel):
    def dumps(self):
        assert isinstance(self.model, models.RegistrationCode)

        data = {}
        for field in ('id', 'generate_time', 'state', 'code', 'user_role'):
            data[field] = getattr(self.model, field)

        return data


class RecordCommentViewModel(ViewModel):
    def dumps(self):
        assert isinstance(self.model, models.RecordComment)

        data = {}
        for field in ('id', 'content', 'comment_time', 'update_time', 'record_id'):
            data[field] = getattr(self.model, field)

        data['commentor'] = view_model(self.model.commentor)
        
        return data