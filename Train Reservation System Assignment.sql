
CREATE TABLE Trains (
    train_id INT PRIMARY KEY,
    train_name VARCHAR(100) NOT NULL,
    source VARCHAR(50) NOT NULL,
    destination VARCHAR(50) NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    distance_km INT CHECK (distance_km > 0) NOT NULL
)

INSERT INTO Trains (train_id, train_name, source, destination, departure_time, arrival_time, distance_km)
VALUES
(1, 'Rajdhani Exp', 'Delhi', 'Mumbai', '2025-09-01 08:00', '2025-09-01 20:00', 1380),
(2, 'Garib Rath', 'Kolkata', 'Delhi', '2025-09-02 09:00', '2025-09-02 22:00', 1500),
(3, 'Shatabdi Exp', 'Chennai', 'Bangalore', '2025-09-03 07:00', '2025-09-03 12:00', 350),
(4, 'Duronto Exp', 'Delhi', 'Kolkata', '2025-09-04 06:00', '2025-09-04 18:00', 1450),
(5, 'Intercity Exp', 'Mumbai', 'Pune', '2025-09-05 10:00', '2025-09-05 12:30', 200)


CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT CHECK (age > 0) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M','F')) NOT NULL,
    city VARCHAR(50)
)

INSERT INTO Passengers (passenger_id, name, age, gender, city)
VALUES
(101, 'Amit Sharma', 45, 'M', 'Delhi'),
(102, 'Priya Mehta', 32, 'F', 'Mumbai'),
(103, 'Rahul Verma', 55, 'M', 'Kolkata'),
(104, 'Sneha Patel', 28, 'F', 'Vadodara'),
(105, 'Arjun Singh', 22, 'M', 'Delhi'),
(106, 'Neha Kapoor', 38, 'F', 'Chennai'),
(107, 'Ravi Iyer', 60, 'M', 'Mumbai'),
(108, 'Anita Desai', 41, 'F', 'Delhi'),
(109, 'Karan Joshi', 27, 'M', 'Pune'),
(110, 'Meera Nair', 35, 'F', 'Kolkata')


CREATE TABLE Reservations (
    res_id INT PRIMARY KEY,
    passenger_id INT FOREIGN KEY REFERENCES Passengers(passenger_id),
    train_id INT FOREIGN KEY REFERENCES Trains(train_id),
    travel_date DATE NOT NULL,
    class VARCHAR(20) CHECK (class IN ('Sleeper','AC1','AC2','AC3')) NOT NULL,
    fare DECIMAL(10,2) CHECK (fare >= 0) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Confirmed','Waiting','Cancelled')) NOT NULL
)

INSERT INTO Reservations (res_id, passenger_id, train_id, travel_date, class, fare, status)
VALUES
(1001, 101, 1, '2025-09-01', 'AC1', 2500, 'Confirmed'),
(1002, 102, 1, '2025-09-01', 'Sleeper', 800, 'Confirmed'),
(1003, 103, 2, '2025-09-02', 'AC2', 1200, 'Waiting'),
(1004, 104, 3, '2025-09-03', 'AC3', 600, 'Cancelled'),
(1005, 105, 4, '2025-09-04', 'Sleeper', 700, 'Confirmed'),
(1006, 106, 3, '2025-09-03', 'AC2', 950, 'Confirmed'),
(1007, 107, 1, '2025-09-01', 'AC3', 1100, 'Confirmed'),
(1008, 108, 2, '2025-09-02', 'Sleeper', 500, 'Confirmed'),
(1009, 109, 5, '2025-09-05', 'AC1', 1500, 'Waiting'),
(1010, 110, 4, '2025-09-04', 'AC2', 1300, 'Confirmed')


-- 1. List all trains running from Delhi
SELECT * FROM Trains WHERE source = 'Delhi'

-- 2. Passengers above 40 years
SELECT * FROM Passengers WHERE age > 40

-- 3. Total number of reservations
SELECT COUNT(*) AS total_reservations FROM Reservations

-- 4. Count confirmed reservations
SELECT COUNT(*) AS confirmed_count FROM Reservations WHERE status = 'Confirmed'

-- 5. Average fare per train
SELECT train_id, AVG(fare) AS avg_fare FROM Reservations GROUP BY train_id

-- 6. Reservations ordered by fare descending
SELECT * FROM Reservations ORDER BY fare DESC

-- 7. Passengers who booked AC2 or AC3
SELECT DISTINCT p.* 
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id
WHERE r.class IN ('AC2','AC3')

-- 8. Total revenue per train (Confirmed only)
SELECT train_id, SUM(fare) AS total_revenue
FROM Reservations
WHERE status = 'Confirmed'
GROUP BY train_id

-- 9. Train with maximum distance
SELECT TOP 1 * FROM Trains ORDER BY distance_km DESC

-- 10. Number of male and female passengers
SELECT gender, COUNT(*) AS count FROM Passengers GROUP BY gender

-- 11. Passenger names booked Sleeper class
SELECT DISTINCT p.name
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id
WHERE r.class = 'Sleeper'

-- 12. Reservations per city
SELECT p.city, COUNT(r.res_id) AS total_reservations
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id
GROUP BY p.city

-- 13. Train name and passenger count
SELECT t.train_name, COUNT(r.passenger_id) AS passenger_count
FROM Trains t
JOIN Reservations r ON t.train_id = r.train_id
GROUP BY t.train_name
ORDER BY passenger_count DESC

-- 14. Average age of confirmed passengers
SELECT AVG(p.age) AS avg_age
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id
WHERE r.status = 'Confirmed'

-- 15. Reservations per travel_date
SELECT travel_date, COUNT(*) AS total_reservations
FROM Reservations
GROUP BY travel_date

-- 16. Reservations with fare > 1000
SELECT * FROM Reservations WHERE fare > 1000

-- 17. Passengers from Delhi or Mumbai
SELECT * FROM Passengers WHERE city IN ('Delhi','Mumbai')

-- 18. Trains with distance > 1200 km
SELECT * FROM Trains WHERE distance_km > 1200

-- 19. Reservations not Cancelled
SELECT * FROM Reservations WHERE status <> 'Cancelled'

-- 20. Trains with "Exp" in name
SELECT * FROM Trains WHERE train_name LIKE '%Exp%'

-- 21. Passengers ordered by age descending
SELECT * FROM Passengers ORDER BY age DESC

-- 22. Reservations sorted by travel_date
SELECT * FROM Reservations ORDER BY travel_date ASC

-- 23. Trains ordered by distance
SELECT * FROM Trains ORDER BY distance_km DESC

-- 24. Passengers ordered alphabetically
SELECT * FROM Passengers ORDER BY name ASC

-- 25. Reservations ordered by class then fare
SELECT * FROM Reservations ORDER BY class, fare

-- 26. Passengers per city
SELECT city, COUNT(*) AS passenger_count FROM Passengers GROUP BY city

-- 27. Total fare from Confirmed reservations
SELECT SUM(fare) AS total_fare FROM Reservations WHERE status = 'Confirmed'

-- 28. Min, Max, Avg age of passengers
SELECT MIN(age) AS min_age, MAX(age) AS max_age, AVG(age) AS avg_age FROM Passengers

-- 29. Highest fare in Sleeper class
SELECT MAX(fare) AS max_sleeper_fare FROM Reservations WHERE class = 'Sleeper'

-- 30. Average fare per travel_date
SELECT travel_date, AVG(fare) AS avg_fare FROM Reservations GROUP BY travel_date

-- 31. Reservations per class
SELECT class, COUNT(*) AS total_reservations FROM Reservations GROUP BY class

-- 32. Trains with more than 1 reservation
SELECT train_id, COUNT(*) AS res_count
FROM Reservations
GROUP BY train_id
HAVING COUNT(*) > 1

-- 33. Cities with more than 1 passenger
SELECT city, COUNT(*) AS passenger_count
FROM Passengers
GROUP BY city
HAVING COUNT(*) > 1

-- 34. Gender-wise average age
SELECT gender, AVG(age) AS avg_age FROM Passengers GROUP BY gender

-- 35. Passengers with more than 1 ticket
SELECT passenger_id, COUNT(*) AS ticket_count
FROM Reservations
GROUP BY passenger_id
HAVING COUNT(*) > 1

-- 36. Passenger name, train name, fare
SELECT p.name, t.train_name, r.fare
FROM Reservations r
JOIN Passengers p ON r.passenger_id = p.passenger_id
JOIN Trains t ON r.train_id = t.train_id

-- 37. List all passengers and the train name they booked (if any)
SELECT p.name, t.train_name
FROM Passengers p
LEFT JOIN Reservations r ON p.passenger_id = r.passenger_id
LEFT JOIN Trains t ON r.train_id = t.train_id

-- 38. Show all trains and number of passengers booked
SELECT t.train_name, COUNT(r.passenger_id) AS passenger_count
FROM Trains t
LEFT JOIN Reservations r ON t.train_id = r.train_id
GROUP BY t.train_name

-- 39. Passengers who booked Rajdhani Exp
SELECT DISTINCT p.name
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id
JOIN Trains t ON r.train_id = t.train_id
WHERE t.train_name = 'Rajdhani Exp'

-- 40. Passenger names with travel_date and status
SELECT p.name, r.travel_date, r.status
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id

-- 41. Top 2 highest fare reservations
SELECT TOP 2 * FROM Reservations ORDER BY fare DESC

-- 42. Train with lowest average fare
SELECT TOP 1 train_id, AVG(fare) AS avg_fare
FROM Reservations
GROUP BY train_id
ORDER BY avg_fare ASC

-- 43. Train(s) where total distance travelled > 1000 km
SELECT t.train_name, SUM(t.distance_km) AS total_distance
FROM Trains t
JOIN Reservations r ON t.train_id = r.train_id
GROUP BY t.train_name
HAVING SUM(t.distance_km) > 1000

-- 44. Passengers with "Waiting" reservations
SELECT DISTINCT p.name
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id
WHERE r.status = 'Waiting'

-- 45. Passenger(s) who paid maximum fare overall
SELECT p.name, r.fare
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id
WHERE r.fare = (SELECT MAX(fare) FROM Reservations)

-- 46. Passengers aged between 20 and 40
SELECT * FROM Passengers WHERE age BETWEEN 20 AND 40

-- 47. Trains starting from Kolkata or Chennai
SELECT * FROM Trains WHERE source IN ('Kolkata','Chennai')

-- 48. Reservations made after 2025-09-05
SELECT * FROM Reservations WHERE travel_date > '2025-09-05'

-- 49. Passengers whose name starts with 'A'
SELECT * FROM Passengers WHERE name LIKE 'A%'

-- 50. Passengers whose city is NOT Delhi
SELECT * FROM Passengers WHERE city <> 'Delhi'

-- 51. 3 youngest passengers
SELECT TOP 3 * FROM Passengers ORDER BY age ASC

-- 52. 2 longest-distance trains
SELECT TOP 2 * FROM Trains ORDER BY distance_km DESC

-- 53. 5 most expensive reservations
SELECT TOP 5 * FROM Reservations ORDER BY fare DESC

-- 54. Trains in alphabetical order
SELECT * FROM Trains ORDER BY train_name ASC

-- 55. Passengers sorted by age (youngest first)
SELECT * FROM Passengers ORDER BY age ASC

-- 56. Average fare of all reservations
SELECT AVG(fare) AS avg_fare FROM Reservations

-- 57. Total number of male passengers
SELECT COUNT(*) AS male_count FROM Passengers WHERE gender = 'M'

-- 58. Maximum distance among all trains
SELECT MAX(distance_km) AS max_distance FROM Trains

-- 59. Total Sleeper class reservations
SELECT COUNT(*) AS sleeper_count FROM Reservations WHERE class = 'Sleeper'

-- 60. Total fare paid by passengers from Mumbai
SELECT SUM(r.fare) AS total_mumbai_fare
FROM Reservations r
JOIN Passengers p ON r.passenger_id = p.passenger_id
WHERE p.city = 'Mumbai'

-- 61. Reservations per status
SELECT status, COUNT(*) AS count FROM Reservations GROUP BY status

-- 62. Passengers per gender
SELECT gender, COUNT(*) AS count FROM Passengers GROUP BY gender

-- 63. Average fare for each class
SELECT class, AVG(fare) AS avg_fare FROM Reservations GROUP BY class

-- 64. Number of trains starting from each source
SELECT source, COUNT(*) AS train_count FROM Trains GROUP BY source

-- 65. Total reservations grouped by travel_date
SELECT travel_date, COUNT(*) AS total_reservations
FROM Reservations GROUP BY travel_date

-- 66. Passenger name, city, train_name booked
SELECT p.name, p.city, t.train_name
FROM Passengers p
LEFT JOIN Reservations r ON p.passenger_id = r.passenger_id
LEFT JOIN Trains t ON r.train_id = t.train_id

-- 67. Reservations with passenger name and status
SELECT p.name, r.status
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id

-- 68. Train_name and number of confirmed passengers
SELECT t.train_name, COUNT(r.passenger_id) AS confirmed_count
FROM Trains t
JOIN Reservations r ON t.train_id = r.train_id
WHERE r.status = 'Confirmed'
GROUP BY t.train_name

-- 69. All passengers with train_name (NULL if not booked)
SELECT p.name, t.train_name
FROM Passengers p
LEFT JOIN Reservations r ON p.passenger_id = r.passenger_id
LEFT JOIN Trains t ON r.train_id = t.train_id

-- 70. Passengers who booked Garib Rath train
SELECT DISTINCT p.name
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id
JOIN Trains t ON r.train_id = t.train_id
WHERE t.train_name = 'Garib Rath'

-- 71. Train_id and total fare collected (fare > 1000)
SELECT train_id, SUM(fare) AS total_fare
FROM Reservations
WHERE fare > 1000
GROUP BY train_id

-- 72. Source cities with more than 1 train
SELECT source, COUNT(*) AS train_count
FROM Trains
GROUP BY source
HAVING COUNT(*) > 1

-- 73. Passengers grouped by city where count > 1
SELECT city, COUNT(*) AS passenger_count
FROM Passengers
GROUP BY city
HAVING COUNT(*) > 1

-- 74. Classes that earned more than 2000 fare
SELECT class, SUM(fare) AS total_fare
FROM Reservations
GROUP BY class
HAVING SUM(fare) > 2000

-- 75. Trains with at least 2 passengers booked
SELECT train_id, COUNT(DISTINCT passenger_id) AS passenger_count
FROM Reservations
GROUP BY train_id
HAVING COUNT(DISTINCT passenger_id) >= 2

-- 76. Passenger(s) with highest age
SELECT * FROM Passengers
WHERE age = (SELECT MAX(age) FROM Passengers)

-- 77. Train(s) with shortest distance
SELECT * FROM Trains
WHERE distance_km = (SELECT MIN(distance_km) FROM Trains)

-- 78. Reservation(s) with lowest fare
SELECT * FROM Reservations
WHERE fare = (SELECT MIN(fare) FROM Reservations)

-- 79. Passengers who paid above average fare
SELECT DISTINCT p.name
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id
WHERE r.fare > (SELECT AVG(fare) FROM Reservations)

-- 80. Trains whose distance > average train distance
SELECT * FROM Trains
WHERE distance_km > (SELECT AVG(distance_km) FROM Trains)

-- 81. Reservations in September 2025
SELECT * FROM Reservations
WHERE MONTH(travel_date) = 9 AND YEAR(travel_date) = 2025

-- 82. Earliest travel_date booked
SELECT MIN(travel_date) AS earliest_date FROM Reservations

-- 83. Latest travel_date booked
SELECT MAX(travel_date) AS latest_date FROM Reservations

-- 84. Reservations per day
SELECT travel_date, COUNT(*) AS total_reservations
FROM Reservations
GROUP BY travel_date

-- 85. Passengers who booked tickets on same date
SELECT travel_date, COUNT(*) AS passenger_count
FROM Reservations
GROUP BY travel_date
HAVING COUNT(*) > 1

-- 86. Passenger name, train_name, distance travelled
SELECT p.name, t.train_name, t.distance_km
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id
JOIN Trains t ON r.train_id = t.train_id

-- 87. City with highest number of passengers
SELECT TOP 1 city, COUNT(*) AS passenger_count
FROM Passengers
GROUP BY city
ORDER BY passenger_count DESC

-- 88. Each train and its average fare (confirmed only)
SELECT t.train_name, AVG(r.fare) AS avg_fare
FROM Trains t
JOIN Reservations r ON t.train_id = r.train_id
WHERE r.status = 'Confirmed'
GROUP BY t.train_name

-- 89. Passengers who booked tickets in more than one class
SELECT p.name
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id
GROUP BY p.name
HAVING COUNT(DISTINCT r.class) > 1

-- 90. Train_name with maximum reservations
SELECT TOP 1 t.train_name, COUNT(r.res_id) AS reservation_count
FROM Trains t
JOIN Reservations r ON t.train_id = r.train_id
GROUP BY t.train_name
ORDER BY reservation_count DESC

-- 91. Show classes and total reservations
SELECT class, COUNT(*) AS total_reservations
FROM Reservations
GROUP BY class

-- 92. Find passengers who booked more than 1 ticket
SELECT p.name, COUNT(r.res_id) AS ticket_count
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id
GROUP BY p.name
HAVING COUNT(r.res_id) > 1

-- 93. Show passenger name, train name, and fare
SELECT p.name, t.train_name, r.fare
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id
JOIN Trains t ON r.train_id = t.train_id

-- 94. List passengers and train name they booked (if any)
SELECT p.name, t.train_name
FROM Passengers p
LEFT JOIN Reservations r ON p.passenger_id = r.passenger_id
LEFT JOIN Trains t ON r.train_id = t.train_id

-- 95. Show train_name and number of confirmed passengers
SELECT t.train_name, COUNT(r.passenger_id) AS confirmed_count
FROM Trains t
JOIN Reservations r ON t.train_id = r.train_id
WHERE r.status = 'Confirmed'
GROUP BY t.train_name

-- 96. Display all passengers with train_name (NULL if not booked)
SELECT p.name, t.train_name
FROM Passengers p
LEFT JOIN Reservations r ON p.passenger_id = r.passenger_id
LEFT JOIN Trains t ON r.train_id = t.train_id

-- 97. Find passengers who booked Garib Rath train
SELECT DISTINCT p.name
FROM Passengers p
JOIN Reservations r ON p.passenger_id = r.passenger_id
JOIN Trains t ON r.train_id = t.train_id
WHERE t.train_name = 'Garib Rath'

-- 98. Show train_id and total fare collected (fare > 1000)
SELECT train_id, SUM(fare) AS total_fare
FROM Reservations
WHERE fare > 1000
GROUP BY train_id

-- 99. List source cities with more than 1 train
SELECT source, COUNT(*) AS train_count
FROM Trains
GROUP BY source
HAVING COUNT(*) > 1

-- 100. Find passengers grouped by city where count > 1
SELECT city, COUNT(*) AS passenger_count
FROM Passengers
GROUP BY city
HAVING COUNT(*) > 1
