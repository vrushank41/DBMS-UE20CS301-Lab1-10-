START TRANSACTION;
SAVEPOINT S1;
UPDATE ticket_passenger
SET
    seat_no = "S01-29",
    name = "vrushank",
    age = 19

WHERE pnr = "PNR015";
(SELECT * FROM ticket_passenger ORDER BY pnr DESC limit 5) ORDER BY pnr ASC;

SAVEPOINT S2;

INSERT INTO ticket_passenger
VALUES
(
    "S01-30",
    "Y Srinivas",
    20,
    "PNR020"
);
(SELECT * FROM ticket_passenger ORDER BY pnr DESC limit 5) ORDER BY pnr ASC;

ROLLBACK TO S2;
(SELECT * FROM ticket_passenger ORDER BY pnr DESC limit 5) ORDER BY pnr ASC;

ROLLBACK TO S1;
(SELECT * FROM ticket_passenger ORDER BY pnr DESC limit 5) ORDER BY pnr ASC;
