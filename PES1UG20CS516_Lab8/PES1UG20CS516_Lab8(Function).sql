--Write a function to find the number of tickets booked by a customer. If no of tickets is more than 3 for the current month then display error message as “cannot purchase tickets current limit is over”

DELIMITER $$
CREATE FUNCTION no_of_tic(ticket int)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
DECLARE msg varchar(50);
IF ticket>3 then
set msg="cannot purchase tickets current limit is over";
ELSE 
set msg = "Tickets available";
end if;
return msg;
END $$

with tic_count as (select passenger_id,count(pnr) as cnt from ticket group by passenger_id )
select passenger_id,no_of_tic(cnt) as validate,cnt as ticket_purchased from tic_count;