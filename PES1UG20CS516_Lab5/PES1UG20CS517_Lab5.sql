/*1. Update price of the ticket.

a. Create a view compute_price as below
CREATE VIEW compute_price AS
SELECT Ticket.PNR, Ticket.Train_No, Ticket.Departure, Ticket.Arrival,
Route_Info.Distance, Fare.fare_per_km
FROM Ticket, Route_Info, Fare
WHERE (Ticket.Train_No = Route_Info.Train_No AND
Ticket.Departure = Route_Info.From_Station_Name AND
Ticket.Arrival = Route_Info.To_Station_Name AND
Fare.Train_Type=Ticket.Train_Type AND
Fare.Compartment_Type =Ticket.Compartment_type);

b. Create a View passenger_num
CREATE VIEW passenger_num AS select PNR, count(PNR) as numbers from
Ticket_Passenger group by PNR;

c. Update Payment_info.price as below
UPDATE Payment_Info AS p INNER JOIN compute_price AS cs ON p.PNR =
cs.PNR INNER JOIN passenger_num AS pn ON cs.PNR = pn.PNR SET p.Price =
cs.Distance * cs.Fare_Per_KM * pn.numbers;*/

--a.
create view compute_rate as select ticket.pnr , ticket.train_no, ticket.departure, 
ticket.arrival,route_info.distance,fare.fare_per_km from (ticket join route_info on 
ticket.train_no=route_info.train_no and ticket.departure=route_info.from_station_name and 
ticket.arrival=route_info.to_station_name) join fare on ticket.train_type=fare.train_type and 
ticket.compartment_type=fare.compartment_type;

--b.
create view view_2 as select count(*) as passenger_number,pnr from ticket_passenger group by pnr;

--c.
update payment_info as p inner join (select view_2.pnr,view_2.passenger_number, 
view_1.fare_per_km,view_1.distance from view_1 inner join view_2 on view_1.pnr=view_2.pnr ) as 
p2 on p.pnr=p2.pnr set p.price=p2.distance*p2.passenger_number *p2.fare_per_km;

/*
2. Retrieve the all stations along route of the Trains along with the distance between the
stations*/
select train_no,from_station_name,to_station_name,distance from route_info where to_station_no-from_station_no=1 order by train_no;

/*INNER JOIN (equijoin)*/
--3.Retrieve the Train no of train which is leaving Bengaluru and arriving at Chennai with compartments availability greater than 10
select route_info.train_no from route_info inner join compartment on route_info.train_no = compartment.train_number 
where compartment.availability > 10 and from_station_name = "bengaluru" and to_station_name = "chennai";

--4.Retrieve first and last name of users who have booked a ticket with price greater than 500
select distinct name from ticket_passenger inner join payment_info on ticket_passenger.pnr=payment_info.pnr where payment_info.price>500;

/*LEFT OUTER JOIN*/
--5. Retrieve the first name, last name, DOB and ticket PNR if they’ve bought it for all users.
select firstname, lastname, dob, pnr from train_user left join ticket on user_id = passenger_id;

--6. Retrieve the first name, last name,of the Users who have not bought a ticket.
select firstname, lastname, dob from train_user left join ticket on user_id = passenger_id where user_id not in (select passenger_id from ticket); 

/*RIGHT OUTER JOIN*/
--7. Retrieve the ticket PNR, Train number, travel date and along with all users first name and last name.
select pnr, train_no, travel_date, firstname, lastname from ticket right join train_user on user_id = passenger_id;

--8. Retrieve the user id if they’ve traveled in a train along with train id and name of all trains.
select passenger_id,ticket.train_no,train_name from ticket RIGHT OUTER JOIN train on ticket.train_no=train.train_no;

/*NESTED QUERIES*/
--9. Retrieve the train no and name of trains whose destination is not Mangaluru and distance is not less than 100km and departure time is not 8:30:00 PM. (Correlated)
SELECT t1.train_no,t1.train_name from train as t1, (select distinct t2.train_no from route_info as 
t2,(select distinct train_no from ticket where departure_time!="20:30:00") as t3 where 
(t2.train_no=t3.train_no) and (t2.Distance>100)) as t2 where (t1.train_no=t2.train_no) and 
(t1.Destination!="Mangaluru");


--10. Retrieve the User ID who has spent more than the average ticket price. (Uncorrelated)
select distinct passenger_id from ticket join payment_info on ticket.pnr=payment_info.pnr where payment_info.price>(select avg(price) from payment_info);