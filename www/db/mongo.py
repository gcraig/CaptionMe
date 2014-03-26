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
# exit the program
sys.exit ()
#- – - – END SCRIPT – - – - (do not include this line in the script)


# generic driver, dao, should be layered by CollectionDao
# i.e., ClientsDao, entity service with find/crud methods

class Mongo:

    def __init__(self):
        print("<<< Mongo db driver initialized >>>")        

    def getDatabase(self, databasename):
        return driver[databasename]

    def getCollection(self, databasename, collection):
        driver = MongoClient('WALTER', 27017)
        db = driver[databasename]
        collection = db[collection]
        return collection

    #
    # /////////////////////////////////////////////////////
    #
    
    def test(self):
        print("Example MongoDB client >>>")        
        client = MongoClient('', 27017)
        #client = MongoClient()
        #client = MongoClient('localhost', 27017)
        #client = MongoClient('mongodb://localhost:27017')

        print("Getting database 'local':")
        #db = client['local'] or
        db = client.local

        print("Getting 'Clients' collection:")
        Clients = db.Clients
        #print(Clients)

        #
        # find one
        #
        '''
        c = Clients.find_one()
        client_id = c['_id']
        client = c['name']
        print()
        print("client:", client)
        print("client_id:", client_id)
        #print(str(client_id).upper())
        '''

        #
        # insert one/many
        #

        #
        # find()   limit()
        #
        clients = Clients.find() #.limit(10)
        for client in clients:
            c_id = client['_id']
            c_name = client['name']
            print()
            print("client:", c_name)
            print("client_id:", c_id)

        #
        # update()
        #
        
        #
        # delete()
        #

        '''
        print("Iterating over each post(document in 'Clients' and printing:")
        for c in Clients.find():
            print(c)
        '''

        #system.indexes
