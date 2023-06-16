from flask import Flask, render_template, request, flash, session, flash, redirect, url_for
import psycopg2
import psycopg2.extras

application = Flask(__name__, template_folder='templates')
application.secret_key = 'bananabread'

CONNECTION = psycopg2.connect(user='masterUsername',
                                password='Oftheworld1!',
                                host='rds-postgresql-10mintutorial.cpgbioavvyfo.us-west-1.rds.amazonaws.com',
                                port='5432',
                                database='gbts')

CURSOR = CONNECTION.cursor(cursor_factory=psycopg2.extras.DictCursor)

@application.route('/')
def home():
    if 'loggedin' in session:
        return render_template('insert_form.html', username=session['username'])
    return redirect(url_for('login'))

@application.route('/login/', methods=['GET', 'POST'])
def login():

    cur = CURSOR

    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
            
        username = request.form['username']
        password = request.form['password']

        cur.execute('SELECT * FROM users WHERE username = %s AND password = %s', (username, password))
        account = cur.fetchone()

        if account:
        
            session['loggedin'] = True
            session['username'] = account['username']

            return redirect(url_for('insert'))
    
        else:
            flash('Incorrect username/password')

    return render_template('login.html')

@application.route('/login/logout')   
def logout():
    session.pop('loggedin', None)
    session.pop('username', None)
    
    return redirect(url_for('login'))


@application.route('/login/insert', methods=['GET','POST'])
def insert():

    if 'loggedin' in session:

        if request.method == 'POST':
        
            health_value = request.form['health']
            estimated_age_value = request.form['estimated_age']
            work_performed_value = request.form['work_performed']
            date_value = request.form['date']
            tree_species_value = request.form['tree_species']
            address_value = request.form['address']

            CURSOR.execute('INSERT INTO Tree (health, estimated_age, work_performed, date, tree_species, address) VALUES (%s, %s, %s, %s, %s, %s)', (health_value, estimated_age_value, work_performed_value, date_value, tree_species_value, address_value))

            CONNECTION.commit()

            flash('Tree inserted successfully') 

        def get_addresses():
            cur = CURSOR
            a = "SELECT address FROM Property"
            cur.execute(a)
            address = [item[0] for item in cur.fetchall()]
            return address

        return render_template('insert_form.html', property = get_addresses())
    
    return redirect(url_for('login'))

@application.route('/login/trees')
def trees():
        
    if 'loggedin' in session:

        cur = CURSOR
        t = "SELECT * FROM Tree"
        cur.execute(t)
        trees = cur.fetchall()
        return render_template('trees.html', trees = trees)
    
    return redirect(url_for('login'))

@application.route('/login/appointment', methods=['GET', 'POST'])
def appointment():
        
    if 'loggedin' in session:

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
    
    return redirect(url_for('login'))

@application.route('/login/inventory')
def inventory():

    if 'loggedin' in session:

        cur = CURSOR
        inv = "SELECT * FROM Inventory ORDER BY Product_ID"
        cur.execute(inv)
        inventory = cur.fetchall()
        return render_template('inventory.html', inventory = inventory)
    
    return redirect(url_for('login'))

if __name__ == "__main__":
    application.run(host='0.0.0.0', port=5000)