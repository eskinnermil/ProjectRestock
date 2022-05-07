from flask import Flask, render_template, json, redirect
from flask_mysqldb import MySQL
from flask import request
import os

# Connecting the app to the db
app = Flask(__name__)
app.config['MYSQL_HOST'] = 'classmysql.engr.oregonstate.edu'
app.config['MYSQL_USER'] = 'cs340_skinneem'
app.config['MYSQL_PASSWORD'] = '0011'
app.config['MYSQL_DB'] = 'cs340_skinneem'
app.config['MYSQL_CURSORCLASS'] = "DictCursor"
mysql = MySQL(app)


# Defining the app's routes
@app.route('/')
def root():
    return redirect("/index.html")


@app.route('/index.html')
def index():
    return render_template("index.j2")


@app.route('/households', methods=["POST", "GET"])
def households():
    # if request.method == "POST":
    #     if request.form.get("Create_Household"):
    #         name = request.form["name"]
    #         address = request.form["address"]
    query = "SELECT * FROM Households;"
    cursor = mysql.connection.cursor()
    cursor.execute(query)
    mysql.connection.commit()
    results = cursor.fetchall()
    cursor.close()
    return render_template("households.j2", households=results)


@app.route('/households-members')
def households_members():
    query = "SELECT * FROM Households_Members;"
    cursor = mysql.connection.cursor()
    cursor.execute(query)
    mysql.connection.commit()
    results = cursor.fetchall()
    cursor.close()
    return render_template("households-members.j2", households_members=results)


@app.route('/households-members-edit')
def households_members_edit():
    return render_template("households-members-edit.j2")

@app.route('/households-inventories')
def households_inventories():
    query = "SELECT * FROM Households_Inventories;"
    cursor = mysql.connection.cursor()
    cursor.execute(query)
    mysql.connection.commit()
    results = cursor.fetchall()
    cursor.close()
    return render_template("households-inventories.j2", households_inventories=results)


@app.route('/households-inventories-edit')
def households_inventories_edit():
    return render_template("households-inventories-edit.j2")


@app.route('/households-items')
def households_items():
    query = "SELECT * FROM Households_Items;"
    cursor = mysql.connection.cursor()
    cursor.execute(query)
    mysql.connection.commit()
    results = cursor.fetchall()
    cursor.close()
    return render_template("households-items.j2", households_items=results)


@app.route('/items-types')
def items_types():
    query = "SELECT * FROM Items_Types;"
    cursor = mysql.connection.cursor()
    cursor.execute(query)
    mysql.connection.commit()
    results = cursor.fetchall()
    cursor.close()
    return render_template("items-types.j2", items_types=results)


@app.route('/stores-inventories')
def stores_inventories():
    query = "SELECT * FROM Stores_Inventories;"
    cursor = mysql.connection.cursor()
    cursor.execute(query)
    mysql.connection.commit()
    results = cursor.fetchall()
    cursor.close()
    return render_template("stores-inventories.j2", stores_inventories=results)


@app.route('/stores')
def stores():
    query = "SELECT * FROM Stores;"
    cursor = mysql.connection.cursor()
    cursor.execute(query)
    mysql.connection.commit()
    results = cursor.fetchall()
    cursor.close()
    return render_template("stores.j2", stores=results)


# # Listening for the port
# if __name__ == "__main__":
#     port = int(os.environ.get('PORT', 36135))
#     app.run(port=port, debug=True)