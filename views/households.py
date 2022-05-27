from flask import Flask, Blueprint, render_template, json, redirect
from flask_mysqldb import MySQL
from flask import request
import os
import database.db_connector as db

db_connection = db.connect_to_database()
view_households = Blueprint('view_households', __name__)


@view_households.route('/', methods=['POST', 'GET'])
def households():
    db_connection = db.connect_to_database()

    # Add a new household
    if request.method == 'POST':
        if request.form.get('Add_Household'):
            name = request.form['name']
            address = request.form['address']
            
            # No null inputs
            query = 'INSERT INTO Households (name, address) VALUES (%s, %s);'
            cursor = db.execute_query(db_connection=db_connection, query=query, query_params=(name, address))
            results = cursor.fetchall()
            return redirect('/households')

    # View all households
    if request.method == 'GET':
        query = 'SELECT Households.id_household AS id, name, address FROM Households;'
        cursor = db.execute_query(db_connection=db_connection, query=query)
        results = cursor.fetchall()
    return render_template('households.j2', households=results)


@view_households.route('/households-edit/<int:id>', methods=['POST', 'GET'])
def households_edit(id):
    db_connection = db.connect_to_database()

    # View selected household
    if request.method == 'GET':
        query = 'SELECT * FROM Households WHERE id_household = %s' % (id)
        cursor = db.execute_query(db_connection=db_connection, query=query)
        results = cursor.fetchall()

        # View households
        query2 = "SELECT id_household, name FROM Households;"
        cursor = db.execute_query(db_connection=db_connection, query=query2)
        data = cursor.fetchall()
        return render_template("households-edit.j2", households=results, households_dropdown=data)
    
    # Update selected household
    if request.method == 'POST':
        if request.form.get('Edit_Household'):
            name = request.form['name']
            address = request.form['address']

            # No null inputs
            query = 'UPDATE Households SET Households.name = %s, Households.address = %s WHERE id_household = %s;'
            cursor = db.execute_query(db_connection=db_connection, query=query, query_params=(name, address, id))
            results = cursor.fetchall()
            return redirect('/households')


@view_households.route('/households-delete/<int:id>')
def households_delete(id):
    db_connection = db.connect_to_database()

    query = 'DELETE FROM Households WHERE id_household = "%s";'
    db.execute_query(db_connection=db_connection, query=query, query_params=(id,))
    return redirect('/households')