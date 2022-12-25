import pandas as pd
import streamlit as st
from database import view_all_data, view_train_names, delete_data


def delete():
    result = view_all_data()
    df = pd.DataFrame(result, columns=['Train_id','Train_name','Train_type', 'Source', 'Destination','Availability'])
    with st.expander("Current data"):
        st.dataframe(df)

    list_of_Trains = [i[0] for i in view_train_names()]
    selected_train = st.multiselect("Task to Delete", list_of_Trains)
    st.warning("Do you want to delete : {}".format(selected_train))
    
    if st.button("Delete Train"):
        for trains in list_of_Trains:
            if trains in selected_train:
                delete_data(trains)
        st.success("Selected trains have been deleted successfully")
                
    new_result = view_all_data()
    df2 = pd.DataFrame(new_result, columns=['Train_id','Train_name','Train_type', 'Source', 'Destination','Availability'])
    with st.expander("Updated data"):
        st.dataframe(df2)