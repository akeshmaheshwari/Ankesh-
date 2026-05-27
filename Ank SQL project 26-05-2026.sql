-- Create Tables
DROP TABLE IF EXISTS Books;	
CREATE TABLE Books (
  Book_ID SERIAL PRIMARY KEY,
  Title VARCHAR(100),
  Author VARCHAR(100),
  Genre  VARCHAR(100),
  Published_Year INT ,
Price NUMERIC(10,2),
  Stock INT
  );
 DROP TABLE IF EXISTS customers;
CREATE TABLE Books (
Book_ID SERIAL  PRIMARY KEY,
   Title VARCHAR(100),
  Author VARCHAR(100),
  Genre VARCHAR (100),
  Genre VARCHAR (50),
Published_Year INT,
Price NUMERIC (10,2),
  Stock INT
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- Import Data into Books Table
COPY Books(Books_ID, Title,Author,Genre, Published_Year,Price,Stock)
CSV HEADER;

-- Import Data into Customers Table
COPY Customers (Customer_ID,Name,Email,Phone,City, Country)
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\Customers.csv'
CSV HEADER;

-- Import Data into Orders Table
COPY Orders (Order_ID, Customer_ID,Book_ID, Order_Date, Quantity, Total_Amount)
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\Customers.csv'
CSV HEADER;

-- Import Data into Customers Table
COPY Customers (Customer_ID,Name, Email, Phone, City, Country)
FROM 'D:\Course Updates\30 Day Series \SQL\CSV\Customers.csv'
CSV HEADER;

-- Import Data into Orders Table
COPY Orders (Order_ID, Customers_ID, Book_ID, Order_Date, Quantity, Total_Amount)
FROM "E:\Orders_CSV.csv"
CSV.HEADER;
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
Book_ID SERIAL  PRIMARY KEY,
   Title VARCHAR (100),
	Author VARCHAR(100),
    Genre  VARCHAR(50),
    Published_Year INT,
    Price NUMERIC (10,2) ,
     Stock INT
     );
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers(
Customer_ID SERIAL  PRIMARY KEY,
     Name VARCHAR(100),
     Email VARCHAR(100),
     Phone VARCHAR(15),
     City  VARCHAR(50),
     Country VARCHAR(150)
     );
 DROP TABLE IF EXISTS orders;
 CREATE TABLE Orders (
   Order_ID SERIAL  PRIMARY KEY,
   Customer_ID INT REFERENCES Customers (Customer_ID),
  Book_ID INT REFERENCES Books (Book_ID),
  Order_Date DATE,
  Quantity INT,
   Total_Amount NUMERIC (10,2)
   );
   
-- 8) Find the customer who spent most on orders;
SELECT c.customer_id,c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.Customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc  LIMIT 1;

-- 9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book-id,b.title ,b.stock,COALESCE(SUM(o.quantity),0) AS Order_quantity,
  b.stock - COALESCE (SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id;