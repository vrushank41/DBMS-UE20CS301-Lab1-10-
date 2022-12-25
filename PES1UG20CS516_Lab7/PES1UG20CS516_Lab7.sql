--1. Find the list of passengers (user_id, user_type First name and last name) who have traveled from Bengaluru to Chennai during the month of Oct 2021 and Aug 2022
select tu.user_id,tu.user_type,tu.firstname,tu.lastname from train_user as tu,ticket as ti where tu.user_id = ti.passenger_id and ti.departure='Bengaluru' and ti.arrival='Chennai' and ti.travel_date<'2021-11-1' UNION select tu.user_id,tu.user_type,tu.firstname,tu.lastname from train_user as tu,ticket as ti where tu.user_id = ti.passenger_id and ti.departure='Bengaluru' and ti.arrival='Chennai' and ti.travel_date>'2022-07-31';

--2. Find the list of passengers (user_id, user_type First name and last name) who have traveled from Bengaluru to Chennai during the month of Oct 2021 and also during Aug 2022
select tu.user_id,tu.user_type,tu.firstname,tu.lastname from train_user as tu,ticket as ti where tu.user_id = ti.passenger_id and ti.departure='Bengaluru' and ti.arrival='Chennai' and (ti.travel_date<'2021-11-1' and ti.travel_date>'2021-09-30') INTERSECT select tu.user_id,tu.user_type,tu.firstname,tu.lastname from train_user as tu,ticket as ti where tu.user_id = ti.passenger_id and ti.departure='Bengaluru' and ti.arrival='Chennai' and (ti.travel_date>'2022-07-31' and ti.travel_date<'2022-09-01');
 

--3. Find the list of passengers (user_id, user_type First name and last name) who have traveled from Bengaluru to Chennai during the month of Aug 2022 and not in Oct 2021
select tu.user_id,tu.user_type,tu.firstname,tu.lastname from train_user as tu,ticket as ti where tu.user_id = ti.passenger_id and ti.departure='Bengaluru' and ti.arrival='Chennai' and not(ti.travel_date<'2021-11-1' and ti.travel_date>'2021-09-30') union (select tu.user_id,tu.user_type,tu.firstname,tu.lastname from train_user as tu,ticket as ti where tu.user_id = ti.passenger_id and ti.departure='Bengaluru' and ti.arrival='Chennai' and (ti.travel_date>'2022-07-31' and ti.travel_date<'2022-09-01'));


--4. Find the list of passengers (user_id, user_type, First name and last name) who have traveled from Bengaluru to Chennai and returned to Bengaluru within a week.
select tu.user_id, tu.user_type,tu.firstname, tu.lastname  from ticket as t, train_user as tu where t.passenger_id = tu.user_id and t.Departure = 'Bengaluru' and t.Arrival = 'Chennai' and exists(select pnr from ticket as ti where t.passenger_id = ti.passenger_id and ti.Departure = 'Chennai' and ti.Arrival = 'Bengaluru' and (DATEDIFF(ti.travel_date,t.travel_date) BETWEEN 0 and 7));


--5. Find the list of passengers (user_id, user_type, First name and last name) who have traveled from Bengaluru to Chennai and did not return to Bengaluru (in other words, only one way travel from Bengaluru to Chennai)
select tu.user_id, tu.user_type,tu.firstname, tu.lastname  from ticket as t, train_user as tu where t.passenger_id = tu.user_id and t.Departure = 'Bengaluru' and t.Arrival = 'Chennai' and not exists(select pnr from ticket as ti where t.passenger_id = ti.passenger_id and ti.Departure = 'Chennai' and ti.Arrival = 'Bengaluru');
