from flask import Flask, render_template, request, flash
import psycopg2
import psycopg2.extras
from psycopg2.errorcodes import UNIQUE_VIOLATION
from psycopg2 import errors

app = Flask(__name__)

connection = psycopg2.connect(user='masterUsername',
                                password='Oftheworld1!',
                                host='rds-postgresql-10mintutorial.cpgbioavvyfo.us-west-1.rds.amazonaws.com',
                                port='5432',
                                database='gbts')

cursor = connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

@app.route('/insert', methods=['GET','POST'])
def insert():
    conn = connection
    cur = cursor

    if request.method == 'POST':
    
        tree_id_value = request.form['tree_id']
        health_value = request.form['health']
        estimated_age_value = request.form['estimated_age']
        work_performed_value = request.form['work_performed']
        date_value = request.form['date']
        tree_species_value = request.form['tree_species']
        address_value = request.form['address']

        try:
            tree_id_value = int(tree_id_value)
            health_value = str(health_value)
            estimated_age_value = int(estimated_age_value)
            work_performed_value = str(work_performed_value)
            if len(work_performed_value) > 200:
                work_performed_value = work_performed_value[:200]
            date_value = str(date_value)
            tree_species_value = str(tree_species_value)
            if len(tree_species_value) > 100:
                tree_species_value = tree_species_value[:100]
            address_value = str(address_value)
            if len(address_value) > 200:
                address_value = address_value[:100]

            cur.execute('INSERT INTO Tree (tree_id, health, estimated_age, work_performed, date, tree_species, address) VALUES (%s, %s, %s, %s, %s, %s, %s)', (tree_id_value, health_value, estimated_age_value, work_performed_value, date_value, tree_species_value, address_value))

            conn.commit()

            success_message = "Data inserted successfully!"

            return success_message
        
        except (ValueError, TypeError) as e:
            return f"Invalid input: {str(e)}"
        except errors.lookup(UNIQUE_VIOLATION) as e:
            return "Error: Tree ID already exists"
        except psycopg2.Error as e:
            return "Headache!"
        
        finally:
            cur.close()
            conn.close()
    return render_template('insert_form.html')

@app.route('/trees')
def trees():
    conn = connection
    cur = cursor
    t = "SELECT * FROM Tree"
    cur.execute(t)
    trees = cur.fetchall()
    return render_template('trees.html', trees = trees)

@app.route('/inventory')
def inventory():
    cursor = connection.cursor(cursor_factory=psycopg2.extras.DictCursor)
    t = "SELECT * FROM Inventory"
    cursor.execute(t)
    inventory = cursor.fetchall()
    return render_template('inventory.html', inventory = inventory)

if __name__ == "__main__":
    app.run(debug=True)
