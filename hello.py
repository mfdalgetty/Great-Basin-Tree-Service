




from flask import Flask, render_template, request, redirect, url_for, flash
import psycopg2
import psycopg2.extras

app = Flask(__name__)
app.secret_key = "bananabread"

connection = psycopg2.connect(user='masterUsername',
                                password='Oftheworld1!',
                                host='rds-postgresql-10mintutorial.cpgbioavvyfo.us-west-1.rds.amazonaws.com',
                                port='5432',
                                database='gbts')

@app.route('/')
def index():
    cursor = connection.cursor(cursor_factory=psycopg2.extras.DictCursor)
    t = "SELECT * FROM Tree"
    cursor.execute(t)
    list_users = cursor.fetchall()
    return render_template('index.html', list_users = list_users)
    print(list_users)
    return(list_users)

if __name__ == "__main__":
    app.run()



