9.1 Create Database 
sql 
CREATE DATABASE MarketResearchDB; 
USE MarketResearchDB; 
9.2 Table Creation 
Customer Table 
sql 
CREATE TABLE Customer ( 
customer_id INT AUTO_INCREMENT PRIMARY KEY, 
name VARCHAR(50) NOT NULL, 
age INT, 
gender VARCHAR(10), 
email VARCHAR(100) UNIQUE NOT NULL 
); 
Product Table 
sql 
CREATE TABLE Product ( 
product_id INT AUTO_INCREMENT PRIMARY KEY, 
product_name VARCHAR(100) NOT NULL, 
category VARCHAR(50) 
); 
Survey Table 
sql 
CREATE TABLE Survey ( 
survey_id INT AUTO_INCREMENT PRIMARY KEY, 
survey_date DATE NOT NULL, 
customer_id INT NOT NULL, 
FOREIGN KEY (customer_id) REFERENCES - 
 
21 
Customer(customer_id) 
ON DELETE CASCADE 
ON UPDATE CASCADE 
); 
Feedback Table 
sql 
CREATE TABLE Feedback ( 
feedback_id INT AUTO_INCREMENT PRIMARY KEY, 
survey_id INT NOT NULL, 
product_id INT NOT NULL, 
rating INT CHECK (rating BETWEEN 1 AND 5), 
comments TEXT, 
FOREIGN KEY (survey_id) REFERENCES 
Survey(survey_id) 
ON DELETE CASCADE, 
FOREIGN KEY (product_id) REFERENCES 
Product(product_id) 
); 
9.3 Data Insertion 
Insert Customers 
sql 
INSERT INTO Customer (name, age, gender, email) VALUES 
('Rahul Sharma', 25, 'Male', 'rahul@example.com'), 
('Sahil Verma', 22, 'Male', 'sahil@example.com'), 
('Aditi Mehta', 24, 'Female', 'aditi@example.com'), 
('Neha Singh', 23, 'Female', 'neha@example.com'), 
('Rohit Jain', 26, 'Male', 'rohit@example.com'); 
Insert Products 
sql 
INSERT INTO Product (product_name, category) VALUES 
('Smartphone X', 'Electronics'), 
('Organic Shampoo', 'Personal Care'), - 
22 
('Sports Shoes', 'Footwear'); 
Insert Survey Records 
sql 
INSERT INTO Survey (survey_date, customer_id) VALUES 
('2025-02-10', 1), 
('2025-02-12', 2), 
('2025-02-15', 3); 
Insert Feedback 
sql 
INSERT INTO Feedback (survey_id, product_id, rating, 
comments) VALUES 
(1, 1, 5, 'Excellent product'), 
(2, 2, 4, 'Good quality'), 
(3, 3, 3, 'Average experience'); 
9.4 SQL Queries and Advanced Concepts 
Join Query 
sql 
SELECT c.name, p.product_name, f.rating 
FROM Customer c 
JOIN Survey s ON c.customer_id = s.customer_id 
JOIN Feedback f ON s.survey_id = f.survey_id 
JOIN Product p ON f.product_id = p.product_id; 
Group By and Having Clause 
sql 
SELECT product_id, AVG(rating) AS average_rating 
FROM Feedback 
GROUP BY product_id 
HAVING average_rating > 3; - 
23 
9.5 View Creation 
sql 
CREATE VIEW Product_Summary AS 
SELECT  
p.product_name, 
AVG(f.rating) AS average_rating 
FROM Product p 
JOIN Feedback f ON p.product_id = f.product_id 
GROUP BY p.product_name; 
SELECT * FROM Product_Summary; 
9.6 Transaction Handling 
Successful Transaction (Survey + Feedback) 
sql 
START TRANSACTION; 
INSERT INTO Survey (survey_date, customer_id) 
VALUES ('2025-02-20', 4); 
INSERT INTO Feedback (survey_id, product_id, rating, 
comments) 
VALUES (LAST_INSERT_ID(), 1, 5, 'Very satisfied'); 
COMMIT; 
Rollback Transaction 
sql 
START TRANSACTION; 
INSERT INTO Feedback (survey_id, product_id, rating, 
comments) 
VALUES (1, 2, 10, 'Invalid rating test'); 
ROLLBACK;