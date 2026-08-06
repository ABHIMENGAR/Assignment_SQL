create table product 
(PID INT, PNAME VARCHAR(20), CITY VARCHAR (20), QUANTITY INT, SALES_UNIT INT)

INSERT INTO PRODUCT VALUES
(101,'MOBILE','VADODARA',100,3),
(102,'LAPTOP','SURAT',150,9),
(103,'HEADPHONE','AHEMDABAD',428,223),
(104,'WASHER','MORBI',150,98),
(105,'PS5','KHEDA',100,55),
(106,'SSD','RAJKOT',250,50),
(107,'CHARGER','PORBANDER',270,256)

--1. Find all products that have a Quantity greater than the average quantity of all products.

SELECT PID, PNAME, CITY, QUANTITY, SALES_UNIT 
FROM PRODUCT
WHERE QUANTITY > ( SELECT AVG(QUANTITY)
FROM PRODUCT )

-- 2.Display the ProductName of products sold in the same city as 'Laptop'.

SELECT PNAME,CITY
FROM PRODUCT
WHERE CITY IN 
   (SELECT CITY
    FROM PRODUCT 
    WHERE PNAME = 'LAPTOP')

-- 3. Find the details of the products with the maximum Quantity.

SELECT PID, PNAME, CITY, QUANTITY, SALES_UNIT
FROM PRODUCT
WHERE QUANTITY = (SELECT MAX(QUANTITY) FROM PRODUCT)

-- 4. List products whose salesUnit is higher than the salesUnit of ProductID 105.

SELECT PID, PNAME, CITY, QUANTITY, SALES_UNIT
FROM PRODUCT
WHERE SALES_UNIT > (
    SELECT SALES_UNIT
    FROM PRODUCT
    WHERE PID = 105
)

-- 5. Find products that have a lower Quantity than the minimum Quantity found in 'Vadodara'.

select * from product
where Quantity <
(select MIN(quality) from product where city = 'vadodara')

-- 6. Display products whose salesUnit is greater than the average salesUnit of product in 'Mumbai'.

SELECT pname, sales_unit 
FROM Product1
WHERE sales_unit > (
    SELECT AVG(sales_unit) 
    FROM Product1
    WHERE city = 'Mumbai'
)


-- 7. Find the product name with the lowest salesUnit.
SELECT pname, sales_unit 
FROM Product1
WHERE sales_unit = (
    SELECT MIN(sales_unit) 
    FROM Product1
)

-- 8. List all products sold in cities that have more than 50 total Quantity across all their products.
SELECT pname AS product_name, city, quantity
FROM Product1
WHERE city IN (
    SELECT city
    FROM Product1
    GROUP BY city
    HAVING SUM(quantity) > 50
)


-- 9. Show products whose Quantity is exactly equal to the salesUnit of 'Smartphone'.
SELECT * 
FROM Product1
WHERE quantity = (
    SELECT sales_unit 
    FROM Product1 
    WHERE pname = 'Smartphone'
)

-- 10. Find the city which has the product with the highest salesUnit. (IN, ALL, ANY & Correlated)
-- Using IN:
SELECT DISTINCT city 
FROM Product1 
WHERE sales_unit IN (SELECT MAX(sales_unit) FROM Product1)

-- Using ALL/ANY:
SELECT DISTINCT city 
FROM Product1 
WHERE sales_unit >= ALL (SELECT sales_unit FROM Product1)

-- Using Correlated Subquery:
SELECT DISTINCT p1.city 
FROM Product1 p1
WHERE NOT EXISTS (
    SELECT 1 FROM Product1 p2 
    WHERE p2.sales_unit > p1.sales_unit
)

-- 11. Find all products sold in cities where at least one product has a Quantity of zero.
SELECT * 
FROM Product1
WHERE city IN (
    SELECT city 
    FROM Product1 
    WHERE quantity = 0
)

-- 12. List products whose salesUnit is greater than the salesUnit of all products in 'Surat'.
select * from product
where salesunit > all
(select salesunit from product where city = 'surat')

--13  Find products that belong to cities where the average salesUnit is greater than 10.
select * from product 
where city in
(select city from product
group by city
having avg (salesunit) > 10)

--14 Display products that have a Quantity greater than any product's Quantity in 'Pune'.

select * from product
where quantity > any
(select quantity from product where city = 'pune')

--15 Find all products whose ProductName is the same as any product sold in 'Ahmedabad'.

select * from product
where pname = any 
(select pname from product where city = 'ahmedabad')

--16 Select products where the Quantity is greater than the average Quantity of their own city

SELECT * 
FROM Product1 p1
WHERE quantity > (
    SELECT AVG(quantity) 
    FROM Product1 p2 
    WHERE p2.city = p1.city
)

-- 17. Find cities where the total salesUnit is higher than the total salesUnit of 'Vadodara'.
SELECT city 
FROM Product1
GROUP BY city
HAVING SUM(sales_unit) > (
    SELECT SUM(sales_unit) 
    FROM Product1 
    WHERE city = 'Vadodara'
)

-- 18. List products that are sold in the city that has the maximum variety (count) of products.
SELECT * 
FROM Product1
WHERE city IN (
    SELECT city 
    FROM Product1 
    GROUP BY city 
    HAVING COUNT(pid) = (
        SELECT MAX(product_count) 
        FROM (
            SELECT COUNT(pid) AS product_count 
            FROM Product1 
            GROUP BY city
        ) AS city_counts
    )
)

-- 19. Find the second highest Quantity from the Product table using a subquery.
SELECT MAX(quantity) AS second_highest_quantity
FROM Product1
WHERE quantity < (
    SELECT MAX(quantity) 
    FROM Product1
)

-- 20. Display the ProductName and a calculated column showing the difference between its Quantity and the global average Quantity.
SELECT pname, 
       quantity, 
       quantity - (SELECT AVG(quantity) FROM Product1) AS diff_from_avg
FROM Product1




