from flask import Flask, render_template, request, flash
import psycopg2
import psycopg2.extras
from psycopg2.errorcodes import UNIQUE_VIOLATION
from psycopg2 import errors

app = Flask(__name__)

CONNECTION = psycopg2.connect(user='masterUsername',
                                password='Oftheworld1!',
                                host='rds-postgresql-10mintutorial.cpgbioavvyfo.us-west-1.rds.amazonaws.com',
                                port='5432',
                                database='gbts')

CURSOR = CONNECTION.cursor(cursor_factory=psycopg2.extras.DictCursor)

@app.route('/')
def index():
    return render_template('index.html')



@app.route('/insert', methods=['GET','POST'])
def insert():

    if request.method == 'POST':
    
        health_value = request.form['health']
        estimated_age_value = request.form['estimated_age']
        work_performed_value = request.form['work_performed']
        date_value = request.form['date']
        tree_species_value = request.form['tree_species']
        address_value = request.form['address']

        CURSOR.execute('INSERT INTO Tree (health, estimated_age, work_performed, date, tree_species, address) VALUES (%s, %s, %s, %s, %s, %s)', (health_value, estimated_age_value, work_performed_value, date_value, tree_species_value, address_value))

        CONNECTION.commit()

    def get_addresses():
        cur = CURSOR
        a = "SELECT address FROM Property"
        cur.execute(a)
        address = [item[0] for item in cur.fetchall()]
        return address

    return render_template('insert_form.html', property = get_addresses())

@app.route('/trees')
def trees():
    cur = CURSOR
    t = "SELECT * FROM Tree"
    cur.execute(t)
    trees = cur.fetchall()
    return render_template('trees.html', trees = trees)

@app.route('/inventory', methods=['GET', 'POST'])
def inventory():
    cursor = CONNECTION.cursor(cursor_factory=psycopg2.extras.DictCursor)
    t = "SELECT * FROM Inventory ORDER BY Product_ID"

    if request.method == 'POST':

        row_id = request.form['row_id']
        q = request.form['quantity']

        cursor.execute("UPDATE Inventory SET Quantity = %s WHERE SKU = %s", (q, row_id))
        CONNECTION.commit()

    cursor.execute(t)
    inventory = cursor.fetchall()

    return render_template('inventory.html', inventory = inventory)

if __name__ == "__main__":
    app.run(debug=True)
