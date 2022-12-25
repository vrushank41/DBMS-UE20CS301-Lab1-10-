--PES1UG20CS516
--VRUSHANK G
--SEC-I

--SET No 2:
--4. List the name and IDs of the patients who did not get the exact blood group as their own. Also display the blood group of blood unit and their actual blood group

SELECT patient.patient_name, patient.patient_id, requests.blood_group AS bloodgroup_unit , patient.blood_group AS actual_bloodgroup
FROM patient 
INNER JOIN patient_request 
ON patient.patient_id = patient_request.patient_id 
INNER JOIN requests 
ON patient_request.request_id = requests.request_id
WHERE patient.blood_group != requests.blood_group;

--5. Write a query to display the number of donors and the number of request for particular blood groups in the ascending order of requests

SELECT * FROM
(SELECT blood_group, COUNT(d_id) AS no_of_donors
FROM donor
GROUP BY blood_group) AS t1
NATURAL JOIN 
(SELECT blood_group, COUNT(request_id) AS no_of_requests
FROM requests
GROUP BY blood_group) AS t2
ORDER BY no_of_requests;


--6. Write a function to set the health status of a donor. If the donor has some associated disease set health status to ‘Fair’, otherwise to ‘Good’

DELIMITER $$
CREATE OR REPLACE FUNCTION health_status(disease VARCHAR(50))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE SET_MSG VARCHAR(10);
    IF disease = "NIL" OR disease = "Nil" THEN
    SET SET_MSG ="Good";
    ELSE
    SET SET_MSG ="Fair";
    END IF;
    RETURN SET_MSG;
END; $$ 
DELIMITER ;

SELECT d_id, d_name, d_surname, d_disease, health_status(d_disease) as health_status FROM donor;