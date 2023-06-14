from flask import Flask, render_template, request, flash
import psycopg2
import psycopg2.extras

app = Flask(__name__)

CONNECTION = psycopg2.connect(user='masterUsername',
                                password='Oftheworld1!',
                                host='rds-postgresql-10mintutorial.cpgbioavvyfo.us-west-1.rds.amazonaws.com',
                                port='5432',
                                database='gbts')

CURSOR = CONNECTION.cursor(cursor_factory=psycopg2.extras.DictCursor)

@app.route('/', methods=['GET','POST'])
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

@app.route('/appointment', methods=['GET', 'POST'])
def appointment():
    cursor = CONNECTION.cursor(cursor_factory=psycopg2.extras.DictCursor)
    t = "SELECT * FROM Appointment ORDER BY Appointment_ID"

    if request.method == 'POST':

        row_id = request.form['row_id']
        q = request.form['quantity_used']

        cursor.execute("UPDATE Appointment SET Quantity_used = %s WHERE Appointment_ID = %s", (q, row_id))
        CONNECTION.commit()

    cursor.execute(t)
    appointments = cursor.fetchall()

    return render_template('appointment.html', appointments = appointments)

@app.route('/inventory')
def inventory():
    cur = CURSOR
    inv = "SELECT * FROM Inventory ORDER BY Product_ID"
    cur.execute(inv)
    inventory = cur.fetchall()
    return render_template('inventory.html', inventory = inventory)

if __name__ == "__main__":
    app.run(debug=True)
