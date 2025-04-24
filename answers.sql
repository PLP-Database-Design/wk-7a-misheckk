-- question 1

-- create a helper table
CREATE TABLE numbers (
  n INT
);


INSERT INTO numbers (n) VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- query to split products
SELECT
    p.OrderID,
    p.CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(p.Products, ',', n.n), ',', -1)) AS Product
FROM
    ProductDetail p
JOIN
    numbers n ON CHAR_LENGTH(p.Products)
             -CHAR_LENGTH(REPLACE(p.Products, ',', '')) >= n.n - 1
ORDER BY
    p.OrderID, n.n;


    -- question 2

    -- create Orders and OrderItems table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),  -- Composite primary key
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- insert data into the tables
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
