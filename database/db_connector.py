from flask_mysqldb import MySQL
import mysql.connector
import os
from dotenv import load_dotenv, find_dotenv

# Load environment variables from .env file
load_dotenv(find_dotenv())

# Setting app variables with environment variables
host = os.environ.get("340DBHOST")
user = os.environ.get("340DBUSER")
passwd = os.environ.get("340DBPW")
db = os.environ.get("340DB")

def connect_to_database(host = host, user = user, passwd = passwd, db = db):
    db_connection = mysql.connector.connect(host,user,passwd,db)
    return db_connection

def execute_query(query):
    cursor = mysql.connection.cursor()
    cursor.execute(query)
    mysql.connection.commit();
    results = cursor.fetchall()
    cursor.close()
    return results