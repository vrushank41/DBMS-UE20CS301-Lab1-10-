--Write a stored procedure to calculate the age of the customer when the date of birth is given.Update the column named age in the customer table.

DELIMITER $$
CREATE procedure calc_age(IN Uid varchar(10),IN DOB date, OUT msg varchar(50))
BEGIN
DECLARE age int;
IF DOB>sysdate() THEN
set msg= 'Invalid DOB';
ELSE
update train_user
set Age=(datediff(sysdate(),DOB))/365
where user_id= Uid;
update train_user
set dob=DOB
where user_id=Uid;
set msg='Age updated successfully';
END IF;
END $$

CALL calc_age('ADM_001','1989-04-14',@Age);
SELECT @Age;