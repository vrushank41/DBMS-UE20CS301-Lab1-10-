import pandas as pd
import streamlit as st
from database import view_all_data


def read():
    result = view_all_data()
    df = pd.DataFrame(result, columns=['Train_id','Train_name','Train_type','Source','Destination','Availability'])
    if st.button("View all Trains"):
        st.dataframe(df)
    