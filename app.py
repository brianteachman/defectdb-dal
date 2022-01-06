from datetime import datetime
import random
import os
from dotenv import load_dotenv

from defectmanager import DefectManager

# Defects:
# 
#   NATURAL_KEY = SerialNumber
#   PRIMARY_KEY = DefectId

# TODO:
#   USER_DETERMINATE = LDAP_USER_ID
#

# Fetch credentials from .env file
load_dotenv()
server = os.getenv('DB_SERVER')
database = os.getenv('DB_NAME')
username = os.getenv('DB_USERNAME')
password = os.getenv('DB_PASSWORD')

dm = DefectManager(server, database, username, password)
dm.dumpVersion()

# Seed random FE data
def seed_fe_data(count):
    """ Load Front End test data """
    start = 202201020415
    i = 0
    while i < count:
        d = datetime.now()
        date = '{:%Y-%m-%d}'.format(d)
        time = '{:%H:%M}'.format(d)
        i = i + 1
        serialnum = str(start+i) + 'w'
        cell = random.choice('ABCDEF') + str(random.randint(1, 11))
        origin = random.randint(1, 4)  # First four machines are FE
        defect_type = random.randint(1, 6)  # First six are FE defects
        qa_station = random.randint(1, 4)
        dm.insert(serialnum, cell, origin, 'Operator', date, time, defect_type, qa_station)
    print(str(i) + ' rows inserted.')

# seed_fe_data(500)

# dm.query("SELECT * FROM defect_details;")
dm.select_readable()

dm.dumpRows()
# defects = dm.getDict()
# for defect in defects:
    # print(defect)
