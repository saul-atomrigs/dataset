/*
 - User type:
 -- user_id, created_at, is_subscriber
 
 - User activity
 -- ts, user_id, activity_id
 
 1. DAU, MAU of the app
 2. Compare the activity by the subscription type
 3. Daily new install
 4. Daily new paying subscribers
 5. Activity by the time of the day
 */
-- 1. Querying data (SELECT)
select list1
from table_name --
select list1,
    list2,
    list3
from table_name -- if multiple tables, separate by comma(,)
    --
select *
from table_name -- select all columns from  
    --
    -- TODO: if embedded on python, do NOT use * (write all column names)
select list1 AS list_alias -- 2. Sorting data (ORDER BY)
    --
select list1
from table_name
ORDER BY column1 ASC -- Default (alphabetically)
    --
select list1
from table_name
ORDER BY column1 DESC -- big number to smaller 
    --
select list1
from table_name
ORDER BY column1,
    column2 -- Sort by column1 and then column2
    --
select list1
from table_name
ORDER BY column1 ASC,
    column2 DESC --
select FIELD(str1, str1, str2, str3) -- returns the POSITION of str in the str1, str2, str3... list (returns 0 if not in the list)
    --
select order_number,
    status
from table_name
ORDER BY FIELD(status, 'In Process', 'On Hold', 'Cancelled')
    /* 
     +-------------+------------+
     | orderNumber | status     |
     +-------------+------------+
     |       10425 | In Process |
     |       10421 | In Process |
     |       10422 | In Process |
     |       10420 | In Process |
     |       10424 | In Process |
     |       10423 | In Process |
     |       10414 | On Hold    |
     |       10401 | On Hold    |
     |       10334 | On Hold    |
     |       10407 | Cancelled  |
     */
    -- TODO: Null values will appear first in ASC order
    -- 3. Filtering data (WHERE, SELECT DISTINCT, AND, OR, IN, NOT IN, BETWEEN, LIKE, LIMIT, IS NULL)
select lastname,
    firstname,
    jobtitle
from table_name
WHERE jobtitle = 'Sales Rep'
    /* 
     +-----------+-----------+-----------+
     | lastname  | firstname | jobtitle  |
     +-----------+-----------+-----------+
     | Jennings  | Leslie    | Sales Rep |
     | Thompson  | Leslie    | Sales Rep |
     | Firrelli  | Julie     | Sales Rep |
     | Patterson | Steve     | Sales Rep |
     | Tseng     | Foon Yue  | Sales Rep |
     | Vanauf    | George    | Sales Rep |
     | Bondur    | Loui      | Sales Rep |
     */
select lastname,
    firstname,
    jobtitle,
    office_code
from table_name
WHERE jobtitle = 'Sales Rep'
    AND office_code = 1 -- AND: 둘 다 성립해야 됨
    /*
     +----------+-----------+-----------+------------+
     | lastname | firstname | jobtitle  | officeCode |
     +----------+-----------+-----------+------------+
     | Jennings | Leslie    | Sales Rep | 1          |
     | Thompson | Leslie    | Sales Rep | 1          |
     +----------+-----------+-----------+------------+
     */
select lastname,
    firstname,
    jobtitle,
    office_code
from table_name
WHERE jobtitle = 'Sales Rep'
    OR office_code = 1 -- OR: 하나만 성립해도 됨
ORDER BY office_code,
    jobtitle
    /*
     +-----------+-----------+--------------------+------------+
     | lastName  | firstName | jobTitle           | officeCode |
     +-----------+-----------+--------------------+------------+
     | Murphy    | Diane     | President          | 1          |
     | Bow       | Anthony   | Sales Manager (NA) | 1          |
     | Jennings  | Leslie    | Sales Rep          | 1          |
     | Thompson  | Leslie    | Sales Rep          | 1          |
     | Firrelli  | Jeff      | VP Marketing       | 1          |
     | Patterson | Mary      | VP Sales           | 1          |
     | Firrelli  | Julie     | Sales Rep          | 2          |
     | Patterson | Steve     | Sales Rep          | 2          |
     | Tseng     | Foon Yue  | Sales Rep          | 3          |
     | Vanauf    | George    | Sales Rep          | 3          |
     | Bondur    | Loui      | Sales Rep          | 4          |
     | Hernandez | Gerard    | Sales Rep          | 4          |
     | Castillo  | Pamela    | Sales Rep          | 4          |
     | Gerard    | Martin    | Sales Rep          | 4          |
     | Nishi     | Mami      | Sales Rep          | 5          |
     | Kato      | Yoshimi   | Sales Rep          | 5          |
     | Fixter    | Andy      | Sales Rep          | 6          |
     | Marsh     | Peter     | Sales Rep          | 6          |
     | King      | Tom       | Sales Rep          | 6          |
     | Bott      | Larry     | Sales Rep          | 7          |
     | Jones     | Barry     | Sales Rep          | 7          |
     +-----------+-----------+--------------------+------------+
     */
SELECT firstName,
    lastName,
    officeCode
FROM employees
WHERE officeCode BETWEEN 1 AND 3
ORDER BY officeCode;
/*
 +-----------+-----------+------------+
 | firstName | lastName  | officeCode |
 +-----------+-----------+------------+
 | Diane     | Murphy    | 1          |
 | Mary      | Patterson | 1          |
 | Jeff      | Firrelli  | 1          |
 | Anthony   | Bow       | 1          |
 | Leslie    | Jennings  | 1          |
 | Leslie    | Thompson  | 1          |
 | Julie     | Firrelli  | 2          |
 | Steve     | Patterson | 2          |
 | Foon Yue  | Tseng     | 3          |
 | George    | Vanauf    | 3          |
 +-----------+-----------+------------+
 */
select firstName,
    secondName
from table_name
WHERE lastName LIKE '%son'
    /*
     
     +-----------+-----------+
     | firstName | lastName  |
     +-----------+-----------+
     | Leslie    | Thompson  |
     | Mary      | Patterson |
     | Steve     | Patterson |
     | William   | Patterson |
     +-----------+-----------+
     */
SELECT firstName,
    lastName,
    officeCode
FROM employees
WHERE officeCode IN (1, 2, 3)
ORDER BY officeCode;
/*
 +-----------+-----------+------------+
 | firstName | lastName  | officeCode |
 +-----------+-----------+------------+
 | Diane     | Murphy    | 1          |
 | Mary      | Patterson | 1          |
 | Jeff      | Firrelli  | 1          |
 | Anthony   | Bow       | 1          |
 | Leslie    | Jennings  | 1          |
 | Leslie    | Thompson  | 1          |
 | Julie     | Firrelli  | 2          |
 | Steve     | Patterson | 2          |
 | Foon Yue  | Tseng     | 3          |
 | George    | Vanauf    | 3          |
 +-----------+-----------+------------+
 */
SELECT lastName,
    firstName,
    reportsTo
FROM employees
WHERE reportsTo IS NULL;
/*
 +----------+-----------+-----------+
 | lastName | firstName | reportsTo |
 +----------+-----------+-----------+
 | Murphy   | Diane     |      NULL |
 +----------+-----------+-----------+
 */
--TODO:
/*
 = Equal
 <>, != Not equal
 > greater than
 < less than
 */
SELECT DISTINCT list1 -- removes DUPLICATE values in the list1 column (keeping only one)
from table_name
    /*
     TODO: MySQL doesn’t have a built-in Boolean type. Instead, it uses the number zero as FALSE and non-zero values as TRUE.
     */
SELECT officeCode,
    city,
    phone,
    country
FROM offices
WHERE country IN ('USA', 'France');
-- 다음과 동일함: country = 'USA' OR country = 'France';
/*
 
 +------------+---------------+-----------------+---------+
 | officeCode | city          | phone           | country |
 +------------+---------------+-----------------+---------+
 | 1          | San Francisco | +1 650 219 4782 | USA     |
 | 2          | Boston        | +1 215 837 0825 | USA     |
 | 3          | NYC           | +1 212 555 3000 | USA     |
 | 4          | Paris         | +33 14 723 4404 | France  |
 +------------+---------------+-----------------+---------+
 */
SELECT officeCode,
    city,
    phone
FROM offices
WHERE country NOT IN ('USA', 'France')
ORDER BY city;
/*
 +------------+--------+------------------+
 | officeCode | city   | phone            |
 +------------+--------+------------------+
 | 7          | London | +44 20 7877 2041 |
 | 6          | Sydney | +61 2 9264 2451  |
 | 5          | Tokyo  | +81 33 224 5000  |
 +------------+--------+------------------+
 */
SELECT productCode,
    productName,
    buyPrice
FROM products
WHERE buyPrice BETWEEN 90 AND 100;
- - 다음과 동일함: buyPrice >= 90
AND buyPrice <= 100;
--
SELECT productCode,
    productName,
    buyPrice
FROM products
WHERE buyPrice NOT BETWEEN 20 AND 100;
- - 다음과 동일함: buyPrice < 20
OR buyPrice > 100;
--
SELECT orderNumber,
    requiredDate,
    status
FROM orders
WHERE requireddate BETWEEN CAST('2003-01-01' AS DATE)
    AND -- CAST = astype()
    CAST('2003-01-31' AS DATE);
--
/*
 s% = sun, six, saturday....
 se_ = see, sea, set
 */
SELECT employeeNumber,
    lastName,
    firstName
FROM employees
WHERE firstName LIKE 'a%';
-- a로 시작하는 것들 (anthony, andy, ...)
--
SELECT employeeNumber,
    lastName,
    firstName
FROM employees
WHERE lastName LIKE '%on';
-- on으로 끝나는 것들 (patterson, thompson...)
--
SELECT employeeNumber,
    lastName,
    firstName
FROM employees
WHERE lastname LIKE '%on%';
-- on이 들어가는 것들 (patterson, jones, bond...)
--
SELECT employeeNumber,
    lastName,
    firstName
FROM employees
WHERE lastName NOT LIKE 'B%';
-- B로 시작하는 것들 제외하고 모든것
--
SELECT select_list
FROM table_name
LIMIT 3, 4;
-- 3번째 row부터 7(3+4)번째 row까지만 출력
LIMIT 5 -- 처음(0번째)부터 5번째 row까지만 (top 5)
    --
SELECT COUNT(*) -- counts the total number of rows
FROM customers;
--
SELECT customerNumber,
    customerName
FROM customers
ORDER BY customerName
LIMIT 10, 10;
-- 10~20번째 row들 출력
--
SELECT select_list
FROM table_name
ORDER BY sort_expression DESC
LIMIT n -1, 1;
-- nth highest row
LIMIT 1, 1;
-- second highest row
--
SELECT customerName,
    country,
    salesrepemployeenumber
FROM customers
WHERE salesrepemployeenumber IS NULL -- 
ORDER BY customerName;
--
SELECT customerName,
    country,
    salesrepemployeenumber
FROM customers
WHERE salesrepemployeenumber IS NOT NULL
ORDER BY customerName;
--
CREATE TABLE IF NOT EXISTS projects (
    id INT AUTO_INCREMENT,
    title VARCHAR(255),
    begin_date DATE NOT NULL,
    complete_date DATE NOT NULL,
    PRIMARY KEY(id)
);
INSERT INTO projects(title, begin_date, complete_date)
VALUES('New CRM', '2020-01-01', '0000-00-00'),
    ('ERP Future', '2020-01-01', '0000-00-00'),
    ('VR', '2020-01-01', '2030-01-01');
SELECT *
FROM projects
WHERE complete_date IS NULL;
--
SELECT [column_1 | expression] AS descriptive_name --
    AS `descriptive name` -- 띄어쓰기가 있으면 '' 넣어줘야 함
FROM table_name;
--                                             
SELECT CONCAT_WS(', ', lastName, firstname) -- 
FROM employees;
--
SELECT CONCAT_WS(', ', lastName, firstname) AS `Full name`
FROM employees;
--
SELECT CONCAT_WS(', ', lastName, firstname) `Full name`
FROM employees
ORDER BY `Full name`;
-- AS는 ORDER BY, GROUP BT, HAVING 등에서 사용 가능
--
SELECT orderNumber `Order no.`,
    SUM(priceEach * quantityOrdered) total
FROM orderDetails
GROUP BY `Order no.`
HAVING total > 60000;
-- AS 는 WHERE 절에는 사용 못함!!
--
SELECT *
FROM employees e;
--AS가 생략될 수 있음
--
SELECT e.firstName,
    e.lastName
FROM employees e
ORDER BY e.firstName;
--
SELECT customerName,
    COUNT(o.orderNumber) total
FROM customers c
    INNER JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY customerName
ORDER BY total DESC;
--
-- Foreign key: 서로 다른 테이블을 조인할 때 공통으로 묶이는 컬럼
--
CREATE TABLE members (
    member_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY (member_id)
);
CREATE TABLE committees (
    committee_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY (committee_id)
);
INSERT INTO members(name)
VALUES('John'),
    ('Jane'),
    ('Mary'),
    ('David'),
    ('Amelia');
INSERT INTO committees(name)
VALUES('John'),
    ('Mary'),
    ('Amelia'),
    ('Joe');
SELECT *
FROM members;
/*
 +-----------+--------+
 | member_id | name   |
 +-----------+--------+
 |         1 | John   |
 |         2 | Jane   |
 |         3 | Mary   |
 |         4 | David  |
 |         5 | Amelia |
 +-----------+--------+
 */
SELECT *
FROM committees;
/*
 +--------------+--------+
 | committee_id | name   |
 +--------------+--------+
 |            1 | John   |
 |            2 | Mary   |
 |            3 | Amelia |
 |            4 | Joe    |
 +--------------+--------+
 */
SELECT column_list
FROM table_1
    INNER JOIN table_2 USING (column_name);
--
SELECT m.member_id,
    m.name AS member,
    c.committee_id,
    c.name AS committee
FROM members m
    INNER JOIN committees c ON c.name = m.name;
-- USING (name) 과 동일
/*
 +-----------+--------+--------------+-----------+
 | member_id | member | committee_id | committee |
 +-----------+--------+--------------+-----------+
 |         1 | John   |            1 | John      |
 |         3 | Mary   |            2 | Mary      |
 |         5 | Amelia |            3 | Amelia    |
 +-----------+--------+--------------+-----------+
 */
SELECT m.member_id,
    m.name AS member,
    c.committee_id,
    c.name AS committee
FROM members m
    LEFT JOIN committees c USING(name);
-- LEFT JOIN: 왼쪽컬럼은 항상 들어가고, 오른쪽컬럼은 NULL값이 있을 수도 있음
/*
 +-----------+--------+--------------+-----------+
 | member_id | member | committee_id | committee |
 +-----------+--------+--------------+-----------+
 |         1 | John   |            1 | John      |
 |         2 | Jane   |         NULL | NULL      |
 |         3 | Mary   |            2 | Mary      |
 |         4 | David  |         NULL | NULL      |
 |         5 | Amelia |            3 | Amelia    |
 +-----------+--------+--------------+-----------+
 */
SELECT m.member_id,
    m.name AS member,
    c.committee_id,
    c.name AS committee
FROM members m
    CROSS JOIN committees c;
--combines every row from the first table with every row from the right table
/*
 +-----------+--------+--------------+-----------+
 | member_id | member | committee_id | committee |
 +-----------+--------+--------------+-----------+
 |         1 | John   |            4 | Joe       |
 |         1 | John   |            3 | Amelia    |
 |         1 | John   |            2 | Mary      |
 |         1 | John   |            1 | John      |
 |         2 | Jane   |            4 | Joe       |
 |         2 | Jane   |            3 | Amelia    |
 |         2 | Jane   |            2 | Mary      |
 |         2 | Jane   |            1 | John      |
 |         3 | Mary   |            4 | Joe       |
 |         3 | Mary   |            3 | Amelia    |
 |         3 | Mary   |            2 | Mary      |
 |         3 | Mary   |            1 | John      |
 |         4 | David  |            4 | Joe       |
 |         4 | David  |            3 | Amelia    |
 |         4 | David  |            2 | Mary      |
 |         4 | David  |            1 | John      |
 |         5 | Amelia |            4 | Joe       |
 |         5 | Amelia |            3 | Amelia    |
 |         5 | Amelia |            2 | Mary      |
 |         5 | Amelia |            1 | John      |
 +-----------+--------+--------------+-----------+*/
SELECT orderNumber,
    productName,
    msrp,
    priceEach
FROM products p
    INNER JOIN orderdetails o ON p.productcode = o.productcode
    AND p.msrp > o.priceEach
WHERE p.productcode = 'S10_1678';
--
CREATE DATABASE IF NOT EXISTS salesdb;
USE salesdb;
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(13, 2)
);
CREATE TABLE stores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    store_name VARCHAR(100)
);
CREATE TABLE sales (
    product_id INT,
    store_id INT,
    quantity DECIMAL(13, 2) NOT NULL,
    sales_date DATE NOT NULL,
    PRIMARY KEY (product_id, store_id),
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO products(product_name, price)
VALUES('iPhone', 699),
    ('iPad', 599),
    ('Macbook Pro', 1299);
INSERT INTO stores(store_name)
VALUES('North'),
    ('South');
INSERT INTO sales(store_id, product_id, quantity, sales_date)
VALUES(1, 1, 20, '2017-01-02'),
    (1, 2, 15, '2017-01-05'),
    (1, 3, 25, '2017-01-05'),
    (2, 1, 30, '2017-01-02'),
    (2, 2, 35, '2017-01-05');
--
SELECT store_name,
    product_name,
    SUM(quantity * price) AS revenue
FROM sales
    INNER JOIN products ON products.id = sales.product_id
    INNER JOIN stores ON stores.id = sales.store_id
GROUP BY store_name,
    product_name;
--
SELECT b.store_name,
    a.product_name,
    IFNULL(c.revenue, 0) AS revenue -- IFNULL() = c.revenue가 NULL이면 0 출력
FROM products AS a
    CROSS JOIN stores AS b
    LEFT JOIN (
        SELECT stores.id AS store_id,
            products.id AS product_id,
            store_name,
            product_name,
            ROUND(SUM(quantity * price), 0) AS revenue
        FROM sales
            INNER JOIN products ON products.id = sales.product_id
            INNER JOIN stores ON stores.id = sales.store_id
        GROUP BY stores.id,
            products.id,
            store_name,
            product_name
    ) AS c ON c.store_id = b.id
    AND c.product_id = a.id
ORDER BY b.store_name;
--
--