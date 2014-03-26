#!/usr/bin/env python
# -*- coding: utf-8 -*-

# automate?
# dependencies:
# 1. install python 3.3
# 2. easy_install virtualenv
# 3. mkdir project; cd project; virtualenv venv
# 4. activate: venv\scripts\activate
# 5. pip install Flask

import cymysql
import sys

def ping():
    # open a database connection
    # be sure to change the host IP address, username, password and database name to match your own
    connection = cymysql.connect (host = "localhost", user = "root", passwd = "", db = "caption_me")
    # prepare a cursor object using cursor() method
    cursor = connection.cursor ()
    # execute the SQL query using execute() method.
    cursor.execute ("SELECT VERSION()")
    # fetch a single row using fetchone() method.
    row = cursor.fetchone ()
    # print the row[0]
    # (Python starts the first row in an array with the number zero – instead of one)
    print("Server version:", row[0])
    # close the cursor object
    cursor.close ()
    # close the connection
    connection.close ()
    #- – - – END PING

# generic driver, dao, should be layered by CollectionDao
# i.e., ClientsDao, entity service with find/crud methods
class reg(object):
    def __init__(self, cursor, row):
        for (attr, val) in zip((d[0] for d in cursor.description), row) :
            setattr(self, attr, val)

class MySQL:

    def __init__(self):
        self.connection = cymysql.connect (host = "localhost", user = "root", passwd = "", db = "caption_me")
        print("<<< MySQL db driver initialized >>>")
        #self.connection = connection

    def execute(self, sql):
        print("Execute: " + sql)
        try:
            cursor = self.connection.cursor()
            print("Cursor: " + str(cursor))
            cursor.execute(sql)
            resultset = cursor.fetchall()
            results = []
            #for row in cursor.fetchall() :
            #    r = reg(cursor, row)
            #    print("REG: ", r.id, r.name, r.description, r.status)

            for row in resultset :
                r = reg(cursor, row)
                results.append(r)
                #print("REG: ", r.id, r.name, r.description, r.status)

            #rdef = namedtuple('dataset', ' '.join([x[0] for x in cursor.description])) 
            #for r in map(rdef._make, cursor.fetchall()): 
            #    print r.field1, r.field2, r.etc

            #print(data)
            #return data
            return results
        except Exception as e:
            print(e)
            #sys.exit(1)
        finally:
            if cursor:
                cursor.close()

    def close_connection(self):
        if self.connection:
            self.connection.close()

    def getData(self, table):
        if table is None:
            return
        return self.execute("select * from %s where status = 'A'" % table)

    def getCaption(self, video_id):
        if video_id is None:
            return
        try:
            cursor = self.connection.cursor()
            print("Cursor: " + str(cursor))
            cursor.execute("select video_caption_text from video_captions where video_id = %s and status = 'A'" % video_id)
            row = cursor.fetchone()
            return row
        except Exception as e:
            print(e)
        finally:
            if cursor:
                cursor.close()
    
    def test(self):
        print("Test")
        print(self.getData("videos"))
        print(self.getData("video_captions"))


if __name__ == '__main__':
    
    print("MySQL db driver")
    ping()

    mysql = MySQL()
    mysql.test()
    mysql.destruct()