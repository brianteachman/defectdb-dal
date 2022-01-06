# 
# 
# 

import pyodbc

QUERY_SELECT_ALL = """
SELECT * FROM defect_details
"""

QUERY_SELECT_TOP1000 = """
SELECT TOP(1000) * FROM defect_details
"""

QUERY_INSERT_DEFECT = """
INSERT INTO defects (SerialNumber, CellLocation, OriginId, Cause, DateFound, TimeFound, TypeId, StationId) 
VALUES (?,?,?,?,?,?,?,?)
"""

QUERY_INSERT_DEFECT_TYPE = """
INSERT INTO defects (TypeName, TypeCode) 
VALUES (?,?)
"""

QUERY_INSERT_MACHINE = """
INSERT INTO defects (MachineName, LineNumber, Manufacturer, ModelNumber) 
VALUES (?,?,?,?)
"""

QUERY_INSERT_QA_STATION = """
INSERT INTO qa_stations (StationName, StationCode) 
VALUES (?,?)
"""


class DefectManager():
    """ Doin some shit. """

    dbo = None
    cursor = None

    def __init__(self, server, database, username, password):
        self.dbo = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
        self.cursor = self.dbo.cursor()
        
    def query(self, statement):
        return self.cursor.execute(statement)

    def getCursor(self):
        return self.cursor

    def insert(self, s1,s2, s3, s4, s5, s6, i1, i2):
        num_inserted = self.cursor.execute(
            QUERY_INSERT_DEFECT,
            s1, s2, s3, s4, s5, s6, i1, i2
        ).rowcount
        self.dbo.commit()
        return num_inserted

    def select_readable(self):
        return self.query(QUERY_SELECT_TOP1000)

    def last1000(self):
        return self.cursor.execute(QUERY_SELECT_TOP1000)

    def getDict(self):
        columns = [column[0] for column in self.cursor.description]
        results = []
        for row in self.cursor.fetchall():
            results.append(dict(zip(columns, row)))
        return results
    
    def dumpRows(self):
        row = self.cursor.fetchone()
        while row: 
            print(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7])
            row = self.cursor.fetchone()

    def dumpVersion(self):
        self.query("SELECT @@version;")
        row = self.cursor.fetchone()
        while row: 
            print(row[0])
            row = self.cursor.fetchone()