create database airline
CREATE TABLE airports (
    airport_id INT PRIMARY KEY IDENTITY(1,1),
    airport_name VARCHAR(150) NOT NULL UNIQUE,
    airport_code CHAR(3) NOT NULL UNIQUE,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    timezone VARCHAR(50) NOT NULL
)

CREATE TABLE airlines (
    airline_id INT PRIMARY KEY IDENTITY(1,1),
    airline_name VARCHAR(100) NOT NULL UNIQUE,
    iata_code CHAR(2) NOT NULL UNIQUE,
    country VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL,
    CONSTRAINT chk_airline_status CHECK (status IN ('Active', 'Suspended'))
)

CREATE TABLE aircrafts (
    aircraft_id INT PRIMARY KEY IDENTITY(1,1),
    aircraft_code VARCHAR(20) NOT NULL UNIQUE,
    model VARCHAR(100) NOT NULL,
    airline_id INT NOT NULL,
    total_seats INT NOT NULL,
    manufacture_year INT NOT NULL,
    CONSTRAINT fk_aircraft_airline
        FOREIGN KEY (airline_id) REFERENCES airlines(airline_id)
)

CREATE TABLE flights (
    flight_id INT PRIMARY KEY IDENTITY(1,1),
    flight_number VARCHAR(10) NOT NULL UNIQUE,
    airline_id INT NOT NULL,
    aircraft_id INT NOT NULL,
    origin_id INT NOT NULL,
    destination_id INT NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    fare DECIMAL(8,2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Scheduled',
    CONSTRAINT fk_flight_airline
        FOREIGN KEY (airline_id) REFERENCES airlines(airline_id),
    CONSTRAINT fk_flight_aircraft
        FOREIGN KEY (aircraft_id) REFERENCES aircrafts(aircraft_id),
    CONSTRAINT fk_flight_origin
        FOREIGN KEY (origin_id) REFERENCES airports(airport_id),
    CONSTRAINT fk_flight_destination
        FOREIGN KEY (destination_id) REFERENCES airports(airport_id),
    CONSTRAINT chk_flight_status
        CHECK (status IN ('Scheduled', 'Delayed', 'Cancelled', 'Completed'))
)

CREATE TABLE passengers (
    passenger_id INT PRIMARY KEY IDENTITY(1,1),
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) UNIQUE,
    passport_no VARCHAR(20) UNIQUE,
    nationality VARCHAR(50) NOT NULL,
    dob DATE NOT NULL
)

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY IDENTITY(1,1),
    passenger_id INT NOT NULL,
    flight_id INT NOT NULL,
    booking_date DATE DEFAULT (CONVERT(date, GETDATE())),
    seat_number VARCHAR(5) NOT NULL,
    seat_class VARCHAR(20),
    amount_paid DECIMAL(8,2) NOT NULL,
    booking_status VARCHAR(20),
    CONSTRAINT fk_booking_passenger
        FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    CONSTRAINT fk_booking_flight
        FOREIGN KEY (flight_id) REFERENCES flights(flight_id),
    CONSTRAINT chk_seat_class
        CHECK (seat_class IN ('Economy', 'Business', 'First')),
    CONSTRAINT chk_booking_status
        CHECK (booking_status IN ('Confirmed', 'Cancelled', 'Pending'))
)

SET IDENTITY_INSERT airports ON
INSERT INTO airports (airport_id, airport_name, airport_code, city, country, timezone) VALUES
(1,'Indira Gandhi International Airport','DEL','New Delhi','India','Asia/Kolkata'),
(2,'Chhatrapati Shivaji Maharaj International Airport','BOM','Mumbai','India','Asia/Kolkata'),
(3,'Kempegowda International Airport','BLR','Bangalore','India','Asia/Kolkata'),
(4,'Chennai International Airport','MAA','Chennai','India','Asia/Kolkata'),
(5,'Netaji Subhas Chandra Bose International Airport','CCU','Kolkata','India','Asia/Kolkata'),
(6,'Rajiv Gandhi International Airport','HYD','Hyderabad','India','Asia/Kolkata'),
(7,'Sardar Vallabhbhai Patel International Airport','AMD','Ahmedabad','India','Asia/Kolkata'),
(8,'Dubai International Airport','DXB','Dubai','UAE','Asia/Dubai'),
(9,'Heathrow Airport','LHR','London','United Kingdom','Europe/London'),
(10,'John F. Kennedy International Airport','JFK','New York','USA','America/New_York'),
(11,'Singapore Changi Airport','SIN','Singapore','Singapore','Asia/Singapore'),
(12,'Sydney Kingsford Smith Airport','SYD','Sydney','Australia','Australia/Sydney'),
(13,'Frankfurt Airport','FRA','Frankfurt','Germany','Europe/Berlin'),
(14,'Bangkok Suvarnabhumi Airport','BKK','Bangkok','Thailand','Asia/Bangkok'),
(15,'Kuala Lumpur International Airport','KUL','Kuala Lumpur','Malaysia','Asia/Kuala_Lumpur');
SET IDENTITY_INSERT airports OFF

SET IDENTITY_INSERT airlines ON
INSERT INTO airlines (airline_id, airline_name, iata_code, country, contact_email, status) VALUES
(1,'Air India','AI','India','support@airindia.in','Active'),
(2,'IndiGo','6E','India','care@goindigo.in','Active'),
(3,'SpiceJet','SG','India','support@spicejet.com','Active'),
(4,'Vistara','UK','India','customercare@airvistara.com','Active'),
(5,'Emirates','EK','UAE','support@emirates.com','Active'),
(6,'British Airways','BA','United Kingdom','help@britishairways.com','Active'),
(7,'Singapore Airlines','SQ','Singapore','customercare@singaporeair.com','Active'),
(8,'AirAsia','AK','Malaysia','support@airasia.com','Suspended');
SET IDENTITY_INSERT airlines OFF

SET IDENTITY_INSERT aircrafts ON
INSERT INTO aircrafts (aircraft_id, aircraft_code, model, airline_id, total_seats, manufacture_year) VALUES
(1,'VT-PPB','Boeing 787-8 Dreamliner',1,256,2015),
(2,'VT-IGL','Airbus A320neo',2,186,2018),
(3,'VT-IGM','Airbus A320neo',2,186,2019),
(4,'VT-SGF','Boeing 737-800',3,189,2016),
(5,'VT-SGG','Boeing 737-800',3,189,2017),
(6,'VT-TTB','Airbus A320',4,158,2020),
(7,'VT-TTC','Boeing 787-9 Dreamliner',4,268,2021),
(8,'A6-ENA','Boeing 777-300ER',5,354,2014),
(9,'A6-ENB','Airbus A380-800',5,489,2013),
(10,'G-XWBA','Airbus A350-1000',6,331,2019),
(11,'9V-SKA','Boeing 777-300ER',7,299,2016),
(12,'9M-AQA','Airbus A320',8,180,2017);
SET IDENTITY_INSERT aircrafts OFF

SET IDENTITY_INSERT flights ON
INSERT INTO flights (flight_id, flight_number, airline_id, aircraft_id, origin_id, destination_id, departure_time, arrival_time, fare, status) VALUES
(1,'AI-101',1,1,1,2,'2024-03-01 06:00:00','2024-03-01 08:10:00',4500.00,'Completed'),
(2,'AI-202',1,1,2,9,'2024-03-02 22:00:00','2024-03-03 04:30:00',32000.00,'Completed'),
(3,'6E-301',2,2,1,3,'2024-03-03 07:30:00','2024-03-03 09:45:00',3200.00,'Completed'),
(4,'6E-402',2,3,3,6,'2024-03-04 11:00:00','2024-03-04 12:30:00',2800.00,'Completed'),
(5,'SG-501',3,4,1,4,'2024-03-05 08:00:00','2024-03-05 10:15:00',3500.00,'Completed'),
(6,'SG-602',3,5,4,7,'2024-03-06 14:00:00','2024-03-06 15:45:00',2600.00,'Delayed'),
(7,'UK-701',4,6,1,5,'2024-03-07 09:30:00','2024-03-07 13:00:00',5200.00,'Scheduled'),
(8,'UK-802',4,7,2,8,'2024-03-08 18:00:00','2024-03-08 21:30:00',18000.00,'Scheduled'),
(9,'EK-901',5,8,8,10,'2024-03-09 02:00:00','2024-03-09 14:00:00',55000.00,'Completed'),
(10,'EK-1002',5,9,8,9,'2024-03-10 08:30:00','2024-03-10 13:00:00',42000.00,'Completed'),
(11,'BA-201',6,10,9,1,'2024-03-11 10:00:00','2024-03-11 23:30:00',48000.00,'Completed'),
(12,'BA-302',6,10,9,13,'2024-03-12 12:00:00','2024-03-12 14:30:00',22000.00,'Cancelled'),
(13,'SQ-401',7,11,11,1,'2024-03-13 00:30:00','2024-03-13 05:00:00',36000.00,'Completed'),
(14,'SQ-502',7,11,11,12,'2024-03-14 09:00:00','2024-03-14 18:30:00',41000.00,'Scheduled'),
(15,'AI-303',1,1,2,4,'2024-03-15 07:00:00','2024-03-15 09:30:00',3800.00,'Completed'),
(16,'6E-503',2,2,1,2,'2024-03-16 06:30:00','2024-03-16 08:40:00',3100.00,'Scheduled'),
(17,'SG-703',3,4,4,1,'2024-03-17 16:00:00','2024-03-17 18:15:00',3300.00,'Delayed'),
(18,'UK-903',4,6,1,3,'2024-03-18 13:00:00','2024-03-18 15:10:00',4100.00,'Scheduled'),
(19,'EK-1103',5,8,8,14,'2024-03-19 03:00:00','2024-03-19 07:30:00',28000.00,'Completed'),
(20,'AK-101',8,12,15,11,'2024-03-20 10:00:00','2024-03-20 12:00:00',8500.00,'Cancelled');
SET IDENTITY_INSERT flights OFF

SET IDENTITY_INSERT passengers ON
INSERT INTO passengers (passenger_id, full_name, email, phone, passport_no, nationality, dob) VALUES
(1,'Aarav Sharma','aarav.sharma@gmail.com','9876543210','P1234567','Indian','1990-04-15'),
(2,'Priya Mehta','priya.mehta@yahoo.com','9823456781','P2345678','Indian','1992-07-22'),
(3,'Rahul Verma','rahul.verma@outlook.com','9712345682','P3456789','Indian','1988-11-05'),
(4,'Sneha Patel','sneha.patel@gmail.com','9634567893','P4567890','Indian','1995-02-18'),
(5,'Vikram Singh','vikram.singh@hotmail.com','9545678904','P5678901','Indian','1985-09-30'),
(6,'Ananya Iyer','ananya.iyer@gmail.com','9456789015','P6789012','Indian','1998-06-12'),
(7,'Karan Kapoor','karan.kapoor@gmail.com','9367890126','P7890123','Indian','1993-03-25'),
(8,'Divya Nair','divya.nair@rediffmail.com','9278901237','P8901234','Indian','1991-12-08'),
(9,'Mohammed Al Farsi','mohammed.alfarsi@email.ae','0551234568','UAE123456','Emirati','1987-08-14'),
(10,'Sarah Johnson','sarah.j@gmail.com','07911123459','GB123456','British','1989-05-20'),
(11,'Liu Wei','liu.wei@163.com','13812345670','CN123456','Chinese','1994-01-17'),
(12,'Emily Watson','emily.watson@yahoo.com','21298765431','US123456','American','1996-10-03'),
(13,'Rohan Desai','rohan.desai@gmail.com','9189012342','P9012345','Indian','1990-07-29'),
(14,'Meera Krishnan','meera.k@gmail.com','9090123453','P0123456','Indian','1997-04-11'),
(15,'Arjun Reddy','arjun.reddy@gmail.com','9901234564','P1122334','Indian','1986-02-28'),
(16,'Fatima Sheikh','fatima.sheikh@email.ae','0559876545','UAE654321','Emirati','1993-09-19'),
(17,'James Miller','james.miller@gmail.com','07922334456','GB654321','British','1984-12-31'),
(18,'Nisha Agarwal','nisha.agarwal@gmail.com','9812345677','P2233445','Indian','1999-08-05'),
(19,'Chen Jing','chen.jing@qq.com','13987654328','CN654321','Chinese','1991-03-16'),
(20,'Siddharth Joshi','siddharth.j@gmail.com','9723456789','P3344556','Indian','1988-06-22');
SET IDENTITY_INSERT passengers OFF

SET IDENTITY_INSERT bookings ON
INSERT INTO bookings (booking_id, passenger_id, flight_id, booking_date, seat_number, seat_class, amount_paid, booking_status) VALUES
(1,1,1,'2024-02-15','12A','Economy',4500.00,'Confirmed'),
(2,2,1,'2024-02-16','14B','Economy',4500.00,'Confirmed'),
(3,3,2,'2024-02-10','3A','Business',64000.00,'Confirmed'),
(4,4,3,'2024-02-20','22C','Economy',3200.00,'Confirmed'),
(5,5,4,'2024-02-22','8D','Economy',2800.00,'Confirmed'),
(6,6,5,'2024-02-25','18E','Economy',3500.00,'Confirmed'),
(7,7,6,'2024-02-26','5A','Business',7800.00,'Confirmed'),
(8,8,7,'2024-02-28','11B','Economy',5200.00,'Pending'),
(9,9,9,'2024-02-05','2A','First',110000.00,'Confirmed'),
(10,10,10,'2024-02-08','1B','First',84000.00,'Confirmed'),
(11,11,13,'2024-02-12','20C','Economy',36000.00,'Confirmed'),
(12,12,11,'2024-02-14','4A','Business',96000.00,'Confirmed'),
(13,13,15,'2024-03-01','9C','Economy',3800.00,'Confirmed'),
(14,14,3,'2024-02-21','25D','Economy',3200.00,'Confirmed'),
(15,15,4,'2024-02-23','7E','Business',8400.00,'Confirmed'),
(16,16,8,'2024-02-27','6B','Business',36000.00,'Pending'),
(17,17,10,'2024-02-09','10A','Economy',42000.00,'Confirmed'),
(18,18,16,'2024-03-05','30F','Economy',3100.00,'Confirmed'),
(19,19,14,'2024-03-02','15C','Economy',41000.00,'Pending'),
(20,20,7,'2024-02-28','2B','Business',15600.00,'Confirmed'),
(21,1,15,'2024-03-03','19A','Economy',3800.00,'Confirmed'),
(22,2,5,'2024-02-24','13B','Economy',3500.00,'Cancelled'),
(23,3,9,'2024-02-06','1A','First',110000.00,'Confirmed'),
(24,5,11,'2024-02-13','22D','Economy',48000.00,'Confirmed'),
(25,6,19,'2024-03-08','17E','Economy',28000.00,'Confirmed'),
(26,7,13,'2024-02-11','5C','Business',72000.00,'Confirmed'),
(27,8,16,'2024-03-06','28F','Economy',3100.00,'Cancelled'),
(28,10,2,'2024-02-11','6A','Economy',32000.00,'Confirmed'),
(29,13,17,'2024-03-10','14D','Economy',3300.00,'Pending'),
(30,15,19,'2024-03-09','3B','Business',56000.00,'Confirmed');
SET IDENTITY_INSERT bookings OFF

-- Q1. CREATE TABLE passengers
-- Already created above with all specified constraints.

-- Q2. CREATE TABLE bookings
-- Already created above with foreign keys and CHECK constraints.

-- Q3. Insert 3 records into airports
INSERT INTO airports (airport_name, airport_code, city, country, timezone) VALUES
('Rajkot International Airport', 'HSR', 'Rajkot', 'India', 'Asia/Kolkata'),
('Goa International Airport', 'GOX', 'Goa', 'India', 'Asia/Kolkata'),
('Jaipur International Airport', 'JAI', 'Jaipur', 'India', 'Asia/Kolkata')

-- Q4. Insert 2 flights: one Delayed and one Scheduled
INSERT INTO flights
(flight_number, airline_id, aircraft_id, origin_id, destination_id,
 departure_time, arrival_time, fare, status)
VALUES
('AI-999', 1, 1, 1, 7, '2024-04-01 09:00:00', '2024-04-01 10:30:00', 5000.00, 'Delayed'),
('6E-999', 2, 2, 2, 3, '2024-04-02 11:00:00', '2024-04-02 12:30:00', 3500.00, 'Scheduled')

-- Q5. Update SpiceJet scheduled flights to Cancelled
UPDATE flights
SET status = 'Cancelled'
WHERE airline_id = 3
  AND status = 'Scheduled'

-- Q6. Delete old cancelled bookings
DELETE FROM bookings
WHERE booking_status = 'Cancelled'
  AND booking_date < '2023-06-01'

-- Q7. CHECK fare > 0
ALTER TABLE flights
ADD CONSTRAINT chk_flight_fare_positive CHECK (fare > 0)

-- Q8. UNIQUE passport_no
-- passport_no is already UNIQUE in the required schema, so no ALTER is needed.
-- The UNIQUE constraint is created in the passengers table definition above.

-- Q9. Attempt duplicate airline iata_code.
-- This statement is intentionally expected to fail because iata_code is UNIQUE.
-- INSERT INTO airlines
-- (airline_name, iata_code, country, contact_email, status)
-- VALUES ('Duplicate Airline', 'AI', 'India', 'duplicate@example.com', 'Active');

-- Q10. NOT NULL seat_number
-- The column is already NOT NULL in the original CREATE TABLE.
ALTER TABLE bookings
ALTER COLUMN seat_number VARCHAR(5) NOT NULL

-- Q11. DEFAULT Scheduled for flights.status
ALTER TABLE flights
ADD CONSTRAINT df_flights_status DEFAULT 'Scheduled' FOR status

-- Q12. Drop existing booking_status CHECK and re-add with Waitlisted
ALTER TABLE bookings
DROP CONSTRAINT chk_booking_status

ALTER TABLE bookings
ADD CONSTRAINT chk_booking_status
CHECK (booking_status IN ('Confirmed', 'Cancelled', 'Pending', 'Waitlisted'))

-- Q13. INNER JOIN
SELECT f.flight_number, a.airline_name, f.departure_time, f.status
FROM flights AS f
INNER JOIN airlines AS a
    ON f.airline_id = a.airline_id

-- Q14. INNER JOIN
SELECT p.full_name, f.flight_number, b.seat_class, b.amount_paid
FROM bookings AS b
INNER JOIN passengers AS p
    ON b.passenger_id = p.passenger_id
INNER JOIN flights AS f
    ON b.flight_id = f.flight_id

-- Q15. INNER JOIN with airports twice
SELECT f.flight_number,
       o.city AS origin_city,
       d.city AS destination_city
FROM flights AS f
INNER JOIN airports AS o
    ON f.origin_id = o.airport_id
INNER JOIN airports AS d
    ON f.destination_id = d.airport_id

-- Q16. INNER JOIN
SELECT p.full_name, f.flight_number, b.amount_paid
FROM passengers AS p
INNER JOIN bookings AS b
    ON p.passenger_id = b.passenger_id
INNER JOIN flights AS f
    ON b.flight_id = f.flight_id

-- Q17. INNER JOIN
SELECT f.flight_number, ac.model, ac.total_seats, f.departure_time
FROM flights AS f
INNER JOIN aircrafts AS ac
    ON f.aircraft_id = ac.aircraft_id
WHERE f.status = 'Scheduled'

-- Q18. INNER JOIN
SELECT ac.aircraft_code,
       a.airline_name,
       ac.model,
       ac.manufacture_year
FROM aircrafts AS ac
INNER JOIN airlines AS a
    ON ac.airline_id = a.airline_id

-- Q19. LEFT JOIN
SELECT p.full_name, p.email
FROM passengers AS p
LEFT JOIN bookings AS b
    ON p.passenger_id = b.passenger_id
WHERE b.booking_id IS NULL

-- Q20. LEFT JOIN + GROUP BY
SELECT f.flight_number,
       COUNT(b.booking_id) AS total_booking_count
FROM flights AS f
LEFT JOIN bookings AS b
    ON f.flight_id = b.flight_id
GROUP BY f.flight_id, f.flight_number
ORDER BY f.flight_id

-- Q21. LEFT JOIN
SELECT a.airline_id, a.airline_name
FROM airlines AS a
LEFT JOIN aircrafts AS ac
    ON a.airline_id = ac.airline_id
WHERE ac.aircraft_id IS NULL

-- Q22. LEFT JOIN
SELECT ap.airport_id,
       ap.airport_name,
       COUNT(f.flight_id) AS departing_flights
FROM airports AS ap
LEFT JOIN flights AS f
    ON ap.airport_id = f.origin_id
GROUP BY ap.airport_id, ap.airport_name
ORDER BY ap.airport_id

-- Q23. LEFT JOIN
SELECT ac.aircraft_code,
       ac.model,
       f.flight_number
FROM aircrafts AS ac
LEFT JOIN flights AS f
    ON ac.aircraft_id = f.aircraft_id
ORDER BY ac.aircraft_id

-- Q24. RIGHT JOIN
SELECT f.flight_number,
       b.booking_id,
       b.seat_number,
       b.booking_status
FROM bookings AS b
RIGHT JOIN flights AS f
    ON b.flight_id = f.flight_id
ORDER BY f.flight_id

-- Q25. INNER JOIN across passengers, bookings, flights
SELECT p.full_name,
       f.flight_number,
       b.seat_class,
       f.departure_time,
       b.booking_status
FROM passengers AS p
INNER JOIN bookings AS b
    ON p.passenger_id = b.passenger_id
INNER JOIN flights AS f
    ON b.flight_id = f.flight_id

-- Q26. INNER JOIN across bookings, passengers, flights, airports twice
SELECT p.full_name,
       f.flight_number,
       o.city AS origin_city,
       d.city AS destination_city,
       b.amount_paid
FROM bookings AS b
INNER JOIN passengers AS p
    ON b.passenger_id = p.passenger_id
INNER JOIN flights AS f
    ON b.flight_id = f.flight_id
INNER JOIN airports AS o
    ON f.origin_id = o.airport_id
INNER JOIN airports AS d
    ON f.destination_id = d.airport_id

-- Q27. INNER JOIN using all 6 tables
SELECT p.full_name,
       p.passport_no,
       f.flight_number,
       al.airline_name,
       ac.aircraft_code,
       b.seat_number,
       b.seat_class,
       f.departure_time
FROM bookings AS b
INNER JOIN passengers AS p
    ON b.passenger_id = p.passenger_id
INNER JOIN flights AS f
    ON b.flight_id = f.flight_id
INNER JOIN airlines AS al
    ON f.airline_id = al.airline_id
INNER JOIN aircrafts AS ac
    ON f.aircraft_id = ac.aircraft_id
INNER JOIN airports AS o
    ON f.origin_id = o.airport_id
INNER JOIN airports AS d
    ON f.destination_id = d.airport_id

-- Q28. INNER JOIN
SELECT p.full_name,
       b.seat_class,
       al.airline_name,
       ac.model
FROM passengers AS p
INNER JOIN bookings AS b
    ON p.passenger_id = b.passenger_id
INNER JOIN flights AS f
    ON b.flight_id = f.flight_id
INNER JOIN airlines AS al
    ON f.airline_id = al.airline_id
INNER JOIN aircrafts AS ac
    ON f.aircraft_id = ac.aircraft_id
WHERE b.seat_class IN ('Business', 'First')

-- Q29. INNER JOIN
SELECT f.flight_number,
       al.airline_name,
       ac.model AS aircraft_model,
       o.city AS origin_city,
       d.city AS destination_city
FROM flights AS f
INNER JOIN airlines AS al
    ON f.airline_id = al.airline_id
INNER JOIN aircrafts AS ac
    ON f.aircraft_id = ac.aircraft_id
INNER JOIN airports AS o
    ON f.origin_id = o.airport_id
INNER JOIN airports AS d
    ON f.destination_id = d.airport_id
WHERE f.status = 'Delayed'

-- Q30. INNER JOIN + GROUP BY + ORDER BY
SELECT TOP 1 o.airport_name,
       o.airport_code,
       COUNT(b.booking_id) AS passenger_bookings
FROM airports AS o
INNER JOIN flights AS f
    ON o.airport_id = f.origin_id
INNER JOIN bookings AS b
    ON f.flight_id = b.flight_id
GROUP BY o.airport_id, o.airport_name, o.airport_code
ORDER BY passenger_bookings DESC

-- Q31. SELF JOIN on passengers
SELECT p1.full_name AS passenger1_name,
       p2.full_name AS passenger2_name,
       p1.nationality
FROM passengers AS p1
INNER JOIN passengers AS p2
    ON p1.nationality = p2.nationality
   AND p1.passenger_id < p2.passenger_id

-- Q32. SELF JOIN on flights
SELECT f1.flight_number AS flight1,
       f2.flight_number AS flight2,
       f1.origin_id,
       f1.destination_id
FROM flights AS f1
INNER JOIN flights AS f2
    ON f1.origin_id = f2.origin_id
   AND f1.destination_id = f2.destination_id
   AND f1.flight_id < f2.flight_id

-- Q33. FULL OUTER JOIN
-- MySQL does not support FULL OUTER JOIN directly.
-- UNION of LEFT JOIN and RIGHT JOIN gives the equivalent result.
SELECT p.passenger_id,
       p.full_name,
       b.booking_id,
       b.flight_id
FROM passengers AS p
LEFT JOIN bookings AS b
    ON p.passenger_id = b.passenger_id

UNION

SELECT p.passenger_id,
       p.full_name,
       b.booking_id,
       b.flight_id
FROM passengers AS p
RIGHT JOIN bookings AS b
    ON p.passenger_id = b.passenger_id;

-- Q34. CROSS JOIN with derived seat-class table
SELECT al.airline_name, sc.seat_class
FROM airlines AS al
CROSS JOIN (
    SELECT 'Economy' AS seat_class
    UNION ALL SELECT 'Business'
    UNION ALL SELECT 'First'
) AS sc

-- Q35.
SELECT al.airline_name,
       COUNT(f.flight_id) AS total_flights
FROM airlines AS al
LEFT JOIN flights AS f
    ON al.airline_id = f.airline_id
GROUP BY al.airline_id, al.airline_name
ORDER BY total_flights DESC

-- Q36.
SELECT f.flight_number,
       COALESCE(SUM(b.amount_paid), 0) AS total_revenue
FROM flights AS f
LEFT JOIN bookings AS b
    ON f.flight_id = b.flight_id
GROUP BY f.flight_id, f.flight_number
ORDER BY total_revenue DESC

-- Q37.
SELECT seat_class,
       COUNT(*) AS booking_count
FROM bookings
GROUP BY seat_class

-- Q38.
SELECT destination_id,
       COUNT(*) AS arriving_flights
FROM flights
GROUP BY destination_id
HAVING COUNT(*) > 10

-- Q39.
SELECT al.airline_name,
       COUNT(ac.aircraft_id) AS aircraft_count
FROM airlines AS al
INNER JOIN aircrafts AS ac
    ON al.airline_id = ac.airline_id
GROUP BY al.airline_id, al.airline_name
HAVING COUNT(ac.aircraft_id) > 5

-- Q40.
SELECT YEAR(booking_date) AS booking_year,
       MONTH(booking_date) AS booking_month,
       COUNT(*) AS booking_count
FROM bookings
GROUP BY YEAR(booking_date), MONTH(booking_date)
ORDER BY booking_year, booking_month

-- Q41.
SELECT p.full_name,
       COUNT(b.booking_id) AS total_bookings
FROM passengers AS p
INNER JOIN bookings AS b
    ON p.passenger_id = b.passenger_id
GROUP BY p.passenger_id, p.full_name
HAVING COUNT(b.booking_id) > 3
ORDER BY total_bookings DESC

-- Q42.
SELECT status,
       COUNT(*) AS flight_count
FROM flights
GROUP BY status

-- Q43.
SELECT seat_class,
       ROUND(AVG(amount_paid), 2) AS avg_amount
FROM bookings
GROUP BY seat_class

-- Q44.
SELECT o.airport_code AS origin_airport_code,
       d.airport_code AS destination_airport_code,
       COUNT(f.flight_id) AS route_count
FROM flights AS f
INNER JOIN airports AS o
    ON f.origin_id = o.airport_id
INNER JOIN airports AS d
    ON f.destination_id = d.airport_id
GROUP BY o.airport_id, o.airport_code, d.airport_id, d.airport_code
HAVING COUNT(f.flight_id) > 2

-- Q45.
SELECT MAX(fare) AS highest_fare,
       MIN(fare) AS lowest_fare,
       ROUND(AVG(fare), 2) AS average_fare
FROM flights

-- Q46.
SELECT al.airline_name,
       COALESCE(SUM(b.amount_paid), 0) AS total_revenue
FROM airlines AS al
INNER JOIN flights AS f
    ON al.airline_id = f.airline_id
LEFT JOIN bookings AS b
    ON f.flight_id = b.flight_id
GROUP BY al.airline_id, al.airline_name
ORDER BY total_revenue DESC

-- Q47.
SELECT p.nationality,
       COUNT(b.booking_id) AS confirmed_bookings
FROM passengers AS p
INNER JOIN bookings AS b
    ON p.passenger_id = b.passenger_id
WHERE b.booking_status = 'Confirmed'
GROUP BY p.nationality

-- Q48.
SELECT TOP 1 p.full_name,
       SUM(b.amount_paid) AS total_spent
FROM passengers AS p
INNER JOIN bookings AS b
    ON p.passenger_id = b.passenger_id
GROUP BY p.passenger_id, p.full_name
ORDER BY total_spent DESC


-- Q49.
SELECT TOP 1 ac.model,
       COUNT(f.flight_id) AS flight_count
FROM aircrafts AS ac
INNER JOIN flights AS f
    ON ac.aircraft_id = f.aircraft_id
GROUP BY ac.aircraft_id, ac.model
ORDER BY flight_count DESC

-- Q50.
SELECT al.airline_name,
       COUNT(DISTINCT f.flight_id) AS total_flights,
       COUNT(DISTINCT b.passenger_id) AS total_passengers,
       COALESCE(SUM(b.amount_paid), 0) AS total_revenue,
       ROUND(AVG(f.fare), 2) AS avg_fare,
       MAX(f.fare) AS max_fare
FROM airlines AS al
LEFT JOIN flights AS f
    ON al.airline_id = f.airline_id
LEFT JOIN bookings AS b
    ON f.flight_id = b.flight_id
GROUP BY al.airline_id, al.airline_name
ORDER BY total_revenue DESC

