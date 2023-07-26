# Great-Basin-Tree-Service
This project was completed as a capstone for my Master's in Data Science. The goal was to create a relational database for a small tree company. This database could be updated in the field by the use of a webapp which I coded in Flask and Python

## Prerequisites

Before running the application, make sure you have the following prerequisites installed:

Python (version 3.11)
PostgreSQL
psycopg2 library (can be installed using pip install psycopg2)
Heroku CLI (command-line interface)

	All other libraries are included in the requirements.txt file

## Setting up the Database

Install PostgreSQL on your local machine if you haven't already done so.
Create a new PostgreSQL database for your application.
Update the database connection details in the Flask app code. 

## Local Development

Clone the repository and navigate to the project directory.	
Create a virtual environment: python -m venv 
Activate the virtual environment:
On Windows: venv\Scripts\activate
On macOS/Linux: source venv/bin/activate
Install the required dependencies: pip install -r requirements.txt.
Run the Flask application: python app.py.
Open your web browser and access http://localhost:5000 to see the application in action.

## Deployment to Heroku

Sign up for a free Heroku account if you haven't already.
Install the Heroku CLI by following the instructions provided in the official Heroku documentation.
Log in to your Heroku account using the CLI: heroku login.
Create a new Heroku application: heroku create.
Deploy your code to Heroku: git push heroku main.
Once the deployment is complete, visit the URL provided by Heroku to see your application live.

## Folder Structure

The folder structure of this Flask application is as follows:

└── Application
    ├── app.py
    ├── Procfile
    ├── README.txt
    ├── requirements.txt
    └── Templates
        ├── appointment.html
        ├── base.html
        ├── index.html
        ├── insert_form.html
        ├── inventory.html
        ├── login.html
        └── trees.html

## Troubleshooting

If you encounter any issues with the PostgreSQL database connection, ensure that you have provided the correct database URL and the necessary credentials.
If you face problems with the Heroku deployment, refer to the Heroku documentation or consult their support resources.


