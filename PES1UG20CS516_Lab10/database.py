import mysql.connector

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="train"
)
c = mydb.cursor()


def create_table():
    c.execute('CREATE TABLE IF NOT EXISTS TRAIN(Train_id TEXT, Train_name TEXT, Train_type TEXT, Source TEXT,Destination TEXT,Availability TEXT)')


def add_data(Train_id,Train_name, Train_type, Source, Destination,Availability):
    c.execute('INSERT INTO TRAIN(Train_id,Train_name, Train_type, Source, Destination,Availability) VALUES (%s,%s,%s,%s,%s,%s)',
              (Train_id,Train_name, Train_type, Source, Destination,Availability))
    mydb.commit()


def view_all_data():
    c.execute('SELECT * FROM TRAIN')
    data = c.fetchall()
    return data


def view_train_names():
    c.execute('SELECT Train_name FROM TRAIN')
    data = c.fetchall()
    return data


def view_trains(Train_name):
    c.execute('SELECT * FROM TRAIN WHERE Train_name="{}"'.format(Train_name))
    data = c.fetchall()
    return data


def edit_train(new_Train_id, new_Train_name, new_Train_type, new_Source, new_Destination,new_Availability, Train_id, Train_name, Train_type, Source, Destination,Availability):
    c.execute("UPDATE TRAIN SET Train_id=%s, Train_name=%s, Train_type=%s, Source=%s, Destination=%s, Availability=%s WHERE "
              "Train_id=%s and Train_name=%s and Train_type=%s and Source=%s and Destination=%s and Availability=%s", (new_Train_id, new_Train_name, new_Train_type, new_Source, new_Destination,new_Availability, Train_id, Train_name, Train_type, Source, Destination,Availability))
    mydb.commit()
    data = c.fetchall()
    return data


def delete_data(Train_name):
    c.execute('DELETE FROM TRAIN WHERE Train_name="{}"'.format(Train_name))
    mydb.commit()
