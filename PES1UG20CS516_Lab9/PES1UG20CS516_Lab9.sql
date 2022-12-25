--Write a trigger on insert to compartment table when a new compartment gets added to a train and make sure that total number of compartments available in the train does not exceed more than 4.
DELIMITER $$
CREATE TRIGGER compartment_no_check BEFORE INSERT on compartment for each row
BEGIN
IF (SELECT count(compartment_no) FROM compartment WHERE train_number=NEW.train_number)>=4 THEN 
SIGNAL SQLSTATE '45000' SET message_text="Cannot add more than 4 compartments to a train";
END IF;
END $$
DELIMITER ;


--Create a new table called 'backup' in the railway reservation database with all the attributes of ticket, ticket passenger and paymentinfo. 
--You are supposed to initiate a 'deletetrigger' whenever a ticket record is deleted from ticket table. 
--This deletetrigger has to Fetch the data to be deleted from all the three tables(  ticket, ticket passenger and paymentinfo) with the given ticket info and add the same into backup table.After that, deletion of ticket record should be allowed.

--Enabling Cascade on delete
ALTER TABLE `ticket_passenger` DROP FOREIGN KEY `ticket_passenger_ibfk_1`; ALTER TABLE `ticket_passenger` ADD CONSTRAINT `ticket_passenger_ibfk_1` FOREIGN KEY (`pnr`) REFERENCES `ticket`(`pnr`) ON DELETE CASCADE ON UPDATE RESTRICT;
--Enabling Cascade on delete
ALTER TABLE `payment_info` DROP FOREIGN KEY `payment_info_ibfk_1`; ALTER TABLE `payment_info` ADD CONSTRAINT `payment_info_ibfk_1` FOREIGN KEY (`pnr`) REFERENCES `ticket`(`pnr`) ON DELETE CASCADE ON UPDATE RESTRICT;

create table backup like payment_info;
DELIMITER //
CREATE TRIGGER delete_before
BEFORE DELETE on ticket
for each row
BEGIN
insert into backup select * from payment_info where pnr=old.pnr;
delete from payment_info where pnr=old.pnr;
delete from ticket_passenger where pnr=old.pnr;
END//
DELIMITER ;
delete from ticket where pnr="pnr021";

select * from backup;

--insert into ticket VALUES("pnr021",62621,"2021-10-22","Bengaluru","Chennai","16:00:00","20:30:00","USR_008","Superfast","I Class","F01");
--INSERT INTO `ticket_passenger` (`seat_no`, `name`, `age`, `pnr`) VALUES ('F02', 'Sathvik', '20', 'pnr021');
--INSERT INTO `payment_info` (`transaction_no`, `bank`, `card_no`, `price`, `pnr`) VALUES ('146449', 'SBI', '123456789', '900.00', 'pnr021');


