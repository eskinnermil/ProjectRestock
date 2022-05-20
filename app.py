from flask import Flask, render_template, json, redirect
from flask_mysqldb import MySQL
from flask import request
import os

# Connecting the app to the db
app = Flask(__name__)
app.config['MYSQL_HOST'] = 'us-cdbr-east-05.cleardb.net'
app.config['MYSQL_USER'] = 'bb9fb61850da11'
app.config['MYSQL_PASSWORD'] = '2268e468'
app.config['MYSQL_DB'] = 'heroku_01134a3df2efed9'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
mysql = MySQL(app)


# Defining the app's routes
@app.route('/')
def root():
    return redirect('/index.html')


@app.route('/index.html')
def index():
    return render_template('index.j2')


@app.route('/households', methods=['POST', 'GET'])
def households():
    if request.method == 'POST':
        if request.form.get('Add_Household'):
            name = request.form['name']
            address = request.form['address']
            
            # no null inputs
            query = 'INSERT INTO Households (name, address) VALUES (%s, %s);'
            cursor = mysql.connection.cursor()
            cursor.execute(query, (name, address))
            mysql.connection.commit()
            return redirect('/households')

    if request.method == 'GET':
        query = 'SELECT Households.id_household AS id, name, address FROM Households;'
        cursor = mysql.connection.cursor()
        cursor.execute(query)
        mysql.connection.commit()
        results = cursor.fetchall()
    return render_template('households.j2', households=results)


@app.route('/households-edit/<int:id>', methods=['POST', 'GET'])
def households_edit(id):
    if request.method == 'GET':
        query = 'SELECT * FROM Households WHERE id_household = %s' % (id)
        cursor = mysql.connection.cursor()
        cursor.execute(query)
        results = cursor.fetchall()
        query2 = "SELECT id_household, name FROM Households;"
        cursor = mysql.connection.cursor()
        cursor.execute(query2)
        data = cursor.fetchall()
        return render_template("households-edit.j2", results=results, address=data)
    
    if request.method == 'POST':
        if request.form.get('Edit_Household'):
            name = request.form['name']
            address = request.form['address']

            # no null inputs
            query = 'UPDATE Households SET Households.name = %s, Households.address = %s WHERE id_household = %s;'
            cursor = mysql.connection.cursor()
            cursor.execute(query, (name, address, id))
            mysql.connection.commit()
            return redirect('/households')



@app.route('/households-delete/<int:id>')
def households_delete(id):
    query = 'DELETE FROM Households WHERE id_household = "%s";'
    cursor = mysql.connection.cursor()
    cursor.execute(query, (id,))
    mysql.connection.commit()
    return redirect('/households')


@app.route('/households-members')
def households_members():
    query = "SELECT Households_Members.id_household_member AS id, Households_Members.name AS name, Households_Members.runner_status AS 'runner status', Households.name AS household FROM Households_Members INNER JOIN Households ON Households_Members.id_household = Households.id_household;"
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
    query = "SELECT Households_Inventories.id_household_inventory AS id, Households.name AS household, Households_Items.name AS items, Households_Inventories.amount_left AS 'amount left', Households_Inventories.restock_status AS 'restock status' FROM Households_Inventories INNER JOIN Households ON Households.id_household = Households_Inventories.id_household INNER JOIN Households_Items ON Households_Items.id_item = Households_Inventories.id_item ORDER BY Households_Inventories.id_household_inventory ASC;"
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
    query = "SELECT Households_Items.id_item AS id, Items_Types.name AS type, Households_Items.name AS name, Households_Items.best_if_used_by AS 'best if used by' FROM Households_Items INNER JOIN Items_Types ON Items_Types.id_item_type = Households_Items.id_item_type;"
    cursor = mysql.connection.cursor()
    cursor.execute(query)
    mysql.connection.commit()
    results = cursor.fetchall()
    cursor.close()
    return render_template("households-items.j2", households_items=results)


@app.route('/items-types')
def items_types():
    query = "SELECT Items_Types.id_item_type AS id, Items_Types.name AS name FROM Items_Types;"
    cursor = mysql.connection.cursor()
    cursor.execute(query)
    mysql.connection.commit()
    results = cursor.fetchall()
    cursor.close()
    return render_template("items-types.j2", items_types=results)


@app.route('/stores-inventories')
def stores_inventories():
    query = "SELECT Items_Types.name AS 'item types', Stores.name AS stores FROM Stores_Inventories INNER JOIN Items_Types ON Items_Types.id_item_type = Stores_Inventories.id_item_type INNER JOIN Stores ON Stores.id_store = Stores_Inventories.id_store;"
    cursor = mysql.connection.cursor()
    cursor.execute(query)
    mysql.connection.commit()
    results = cursor.fetchall()
    cursor.close()
    return render_template("stores-inventories.j2", stores_inventories=results)


@app.route('/stores')
def stores():
    query = "SELECT Stores.id_store AS id, Stores.name AS name, Stores.address AS address, Stores.hours_open AS 'hours open' FROM Stores;"
    cursor = mysql.connection.cursor()
    cursor.execute(query)
    mysql.connection.commit()
    results = cursor.fetchall()
    cursor.close()
    return render_template("stores.j2", stores=results)

@app.route('/stores-edit')
def stores_edit():
    return render_template("stores-edit.j2")



# Listening for the port
if __name__ == "__main__":
    app.run(debug=True)
#     port = int(os.environ.get('PORT', 36135))
#     app.run(port=port, debug=True)