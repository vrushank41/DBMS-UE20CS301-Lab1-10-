--1. Find the average distance between subsequent stations for every train
select (train_no),max(distance)/(max(to_station_no)-min(from_station_no)) as avg_distance from route_info where distance in
(select distance from route_info where (to_station_no,from_station_no) in (select max(to_station_no),min(from_station_no) from route_info group by train_no)) group by train_no;

--2. Find the average distance between subsequent stations for every train and display them in descending order of distance
select (train_no),max(distance)/(max(to_station_no)-min(from_station_no)) as avg_distance_desc from route_info where distance in
(select distance from route_info where (to_station_no,from_station_no) in (select max(to_station_no),min(from_station_no) from route_info group by train_no)) group by train_no order by avg_distance_desc desc;

--3. Display the list of train numbers and the total distance travelled by each in descending order of the distance travelled
select (train_no),max(distance) as distance_total_desc from route_info where distance in
(select distance from route_info where (to_station_no,from_station_no) in (select max(to_station_no),min(from_station_no) from route_info group by train_no)) group by train_no;

--4. List those trains that have maximum and minimum number compartments and also display number of compartments they have. (2 queries one to find max and other to find min)
select train_number, count(compartment_no) as max_compartment from compartment group by train_number order by max_compartment desc limit 1;
select train_number, count(compartment_no) as min_compartment from compartment group by train_number order by min_compartment asc limit 1;

--5. Display the number of phone numbers corresponding to the user_id(s) ADM_001,USR_006, USR_010 
select user_id, count(phone_no) as Phone_Numbers from user_phone where user_id in ("ADM_001", "USR_006", "USR_010") group by user_id;

--6. Find the average fare per km for each train type specified and display the train type and corresponding average fare per km as ‘Avg_Fare’ in decreasing order of Avg_Fare
select Train_Type, avg(fare_per_km) as Avg_Fare from fare group by Train_Type order by Avg_Fare desc;

--7. Retrieve all details of the oldest passenger.
select * from ticket_passenger where age = (select max(age) from ticket_passenger);

--8. Count the number of passengers whose name consists of ‘Ullal’. (Hint: Use the LIKE operator)
select count(*) as num_passenger from ticket_passenger where name like "%Ullal%";