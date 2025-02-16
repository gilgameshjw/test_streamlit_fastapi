# streamlit_app/app.py
import streamlit as st
import requests

# Define the FastAPI backend URL
BACKEND_URL = "http://localhost:8000/greet"

st.title("FastAPI + Streamlit Integration")

# Input field for the user's name
name = st.text_input("Enter your name", value="World")

# Button to fetch the greeting from the backend
if st.button("Get Greeting"):
    try:
        response = requests.get(BACKEND_URL, params={"name": name})
        if response.status_code == 200:
            data = response.json()
            st.success(f"Message from backend: {data['message']}")
        else:
            st.error(f"Error: {response.status_code} - {response.text}")
    except Exception as e:
        st.error(f"An error occurred: {str(e)}")
