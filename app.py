from flask import Flask, render_template, request, redirect, url_for
import numpy as np
import pickle
import mysql.connector
from datetime import datetime
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from io import BytesIO
import base64

# Initialize the Flask app
app = Flask(__name__)

# Load the trained model from the pickle file
with open('logistic_regression_model.pkl', 'rb') as file:
    model = pickle.load(file)

# MySQL database connection
def get_db_connection():
    return mysql.connector.connect(
        host='localhost',
        user='azi',
        password='0000',
        database='loan_db'
    )

# Home route
@app.route('/')
def home():
    return render_template('index.html')  # Make sure 'index.html' is in the templates folder

# Predict route
@app.route('/predict', methods=['POST'])
def predict():
    if request.method == 'POST':
        # Get form data (string values for database storage)
        Gender = request.form['Gender']
        Married = request.form['Married']
        Dependents = request.form['Dependents']
        Education = request.form['Education']
        Self_Employed = request.form['Self_Employed']
        ApplicantIncome = float(request.form['ApplicantIncome'])
        CoapplicantIncome = float(request.form['CoapplicantIncome'])
        LoanAmount = float(request.form['LoanAmount'])
        Loan_Amount_Term = float(request.form['Loan_Amount_Term'])
        Credit_History = float(request.form['Credit_History'])
        Property_Area = request.form['Property_Area']

        # Store the string values directly in the database
        conn = get_db_connection()
        cursor = conn.cursor()

        try:
            # Insert the string values directly into the database (not numeric encoded)
            cursor.execute("""
                INSERT INTO loan_applications (gender, married, dependents, education, self_employed, 
                applicant_income, coapplicant_income, loan_amount, loan_amount_term, credit_history, property_area, submission_date)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (Gender, Married, Dependents, Education, Self_Employed, 
                  ApplicantIncome, CoapplicantIncome, LoanAmount, Loan_Amount_Term, Credit_History, Property_Area, datetime.now()))
            conn.commit()

        except Exception as e:
            print(f"An error occurred while inserting into the database: {e}")
            conn.rollback()
        finally:
            cursor.close()
            conn.close()

        # Mapping categorical data to the numerical values for model prediction only
        gender_map = {'Male': 1, 'Female': 0}
        married_map = {'Yes': 1, 'No': 0}
        education_map = {'Graduate': 1, 'Not Graduate': 0}
        self_employed_map = {'Yes': 1, 'No': 0}
        property_area_map = {'Urban': 2, 'Semiurban': 1, 'Rural': 0}

        # Convert the categorical inputs to the encoded format for the model (numeric values only for prediction)
        Gender_encoded = gender_map[Gender]
        Married_encoded = married_map[Married]
        Education_encoded = education_map[Education]
        Self_Employed_encoded = self_employed_map[Self_Employed]
        Property_Area_encoded = property_area_map[Property_Area]

        # Create the input array for the model (with encoded values)
        input_data = np.array([[Gender_encoded, Married_encoded, Dependents, Education_encoded, Self_Employed_encoded,
                                ApplicantIncome, CoapplicantIncome, LoanAmount, Loan_Amount_Term,
                                Credit_History, Property_Area_encoded]], dtype=float)

        # Make the prediction
        try:
            prediction_value = model.predict(input_data)[0]

            # Determine the loan status
            loan_status = 'Approved' if prediction_value == 1 else 'Rejected'

            # Connect to the database to update loan status based on the prediction
            conn = get_db_connection()
            cursor = conn.cursor()

            try:
                # Update the loan status after the prediction is made
                cursor.execute("""
                    UPDATE loan_applications
                    SET loan_status = %s
                    WHERE submission_date = (
                        SELECT MAX(submission_date)
                        FROM loan_applications
                    )
                """, (loan_status,))
                conn.commit()

            except Exception as e:
                print(f"An error occurred while updating the loan status: {e}")
                conn.rollback()
            finally:
                cursor.close()
                conn.close()

            # Redirect based on prediction result
            if loan_status == 'Approved':
                return redirect(url_for('approved'))
            else:
                return redirect(url_for('rejected'))

        except ValueError as ve:
            print(f"Error with prediction: {ve}")
            return "An error occurred with prediction."

# Approved route
@app.route('/approved')
def approved():
    return render_template('approved.html')  # Make sure 'approved.html' exists in the templates folder

# Rejected route
@app.route('/rejected')
def rejected():
    return render_template('rejected.html')  # Make sure 'rejected.html' exists in the templates folder

# Route to display the form and get the user's details
@app.route('/get_loan_recommendation', methods=['GET', 'POST'])
def get_loan_recommendation():
    if request.method == 'POST':
        # Get user input from the form
        user_income = float(request.form['income'])
        user_property_area = request.form['property_area']

        # Connect to the database
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        # Query to get loan products based on user's income and property area
        query = """
        SELECT * FROM loan_products 
        WHERE min_income_requirement <= %s AND max_income_limit >= %s 
        AND property_area = %s
        """
        cursor.execute(query, (user_income, user_income, user_property_area))
        loan_products = cursor.fetchall()

        # Close the connection
        cursor.close()
        conn.close()

        # Render the template with loan products data
        return render_template('loan_recommendation.html', loan_products=loan_products)

    return render_template('loan_form.html')

if __name__ == '__main__':
    app.run(debug=True)
