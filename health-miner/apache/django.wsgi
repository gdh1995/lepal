import os
import sys

root_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
# sys.path.insert(0, os.path.abspath(os.path.join(root_path, 'venv/lib/pathon2.7/site-packages/')))
sys.path.insert(0, os.path.abspath(os.path.join(root_path)))
# sys.path.insert(0, os.path.abspath(os.path.join(root_path, )))

os.environ['DJANGO_SETTINGS_MODULE'] = 'health_miner.settings'

import django.core.handlers.wsgi
application = django.core.handlers.wsgi.WSGIHandler()
