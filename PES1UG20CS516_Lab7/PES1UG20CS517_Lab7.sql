/* 
1. Find the list of passengers (user_id, user_type First name and
last name) who have traveled from Bengaluru to Chennai during
the month of Oct 2021 and Aug 2022
*/
select user_id, user_type, firstname, lastname from train_user, ticket where user_id = passenger_id
    and (travel_date >= "2021-10-01" and travel_date <= "2021-10-31") and (departure = "Bengaluru" and arrival = "Chennai")
    union
    select user_id, user_type, firstname, lastname from train_user, ticket where user_id = passenger_id
    and (travel_date >= "2022-08-01" and travel_date <= "2022-08-31") and (departure = "Bengaluru" and arrival = "Chennai");

/*
2. Find the list of passengers (user_id, user_type First name and last name) 
who have travelled from Bengaluru to Chennai during the month of Oct 2021 and also during Aug 2022.
*/
select user_id, user_type, firstname, lastname from train_user, ticket where user_id = passenger_id
    and (travel_date >= "2021-10-01" and travel_date <= "2021-10-31") and (departure = "Bengaluru" and arrival = "Chennai")
    INTERSECT
    select user_id, user_type, firstname, lastname from train_user, ticket where user_id = passenger_id
    and (travel_date >= "2022-08-01" and travel_date <= "2022-08-31") and (departure = "Bengaluru" and arrival = "Chennai");

/*
3. Find the list of passengers (user_id, user_type First name and
last name) who have traveled from Bengaluru to Chennai during
the month of Aug 2022 and not in Oct 2021
*/
select user_id, user_type, firstname, lastname from train_user, ticket where (user_id = passenger_id
    and (travel_date >= "2022-08-01" and travel_date <= "2022-08-31") and (departure = "Bengaluru" and arrival = "Chennai"))
    AND NOT EXISTS
    (select user_id, user_type, firstname, lastname from train_user, ticket where user_id = passenger_id
    and (travel_date >= "2021-10-01" and travel_date <= "2021-10-31") and (departure = "Bengaluru" and arrival = "Chennai"));

/*
4. Find the list of passengers (user_id, user_type, First name and
last name) who have traveled from Bengaluru to Chennai and
returned to Bengaluru within a week.
*/
select U.user_id, U.user_type, U.firstname, U.lastname from train_user AS U, ticket AS T where U.user_id = T.passenger_id
    AND (T.departure = "Bengaluru" and T.arrival = "Chennai")
    AND EXISTS
    (select U1.user_id, U1.user_type, U1.firstname, U1.lastname from train_user AS U1, ticket AS T1 where U1.user_id = T1.passenger_id
    AND (T1.departure = "Chennai" and T1.arrival = "Bengaluru")
    AND (T1.travel_date BETWEEN T.travel_date AND DATE_ADD(T.travel_date, INTERVAL 7 DAY))
    );

/* 
5. Find the list of passengers (user_id, user_type, First name and
last name) who have traveled from Bengaluru to Chennai and did
not return to Bengaluru (in other words, only one way travel
from Bengaluru to Chennai)
*/
select U.user_id, U.user_type, U.firstname, U.lastname  from ticket as T, train_user as U
where T.passenger_id = U.user_id and T.departure = 'Bengaluru' and T.Arrival = 'Chennai'
and NOT EXISTS (select pnr from ticket as T1 where T.passenger_id = T1.passenger_id and T1.Arrival = 'Bengaluru');
