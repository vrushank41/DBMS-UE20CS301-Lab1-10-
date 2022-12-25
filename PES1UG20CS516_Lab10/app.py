import streamlit as st

from create import create
from database import create_table
from delete import delete
from read import read
from update import update



def main():
    st.title("PES1UG20CS516")
    menu = ["Add Trains", "View Trains", "Edit Train", "Remove Trains"]
    choice = st.sidebar.selectbox("Menu", menu)

    create_table()
    if choice == "Add Trains":
        st.subheader("Enter Train Details:")
        create()

    elif choice == "View Trains":
        st.subheader("View created tasks")
        read()

    elif choice == "Edit Train":
        st.subheader("Update train details here")
        update()

    elif choice == "Remove Trains":
        st.subheader("Delete trains here")
        delete()

if __name__ == '__main__':
    main()
