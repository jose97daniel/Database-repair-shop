Use miamirepair;



-- TO check monthly sales
SELECT (SUM(Payable_Amount)-SUM(Payable_Amount)*0.12) as 'Total Sales Without Tax',
    SUM(Payable_Amount) as 'Total Sales With Tax'
FROM Sales
WHERE 	sale_Date BETWEEN '2019-10-01' AND '2019-10-31';



-- Inventory Check
SELECT Product_Name as Product,
    Listed_price as Price,
    Quantity,
    Product_Description as 'Description',
    Supplier_Name as Supplier
FROM Product P, Supplier S
WHERE 	quantity < 10 and P.supplier_Id = S.supplier_Id;

SELECT * FROM employee;

-- Checking Due Date of repair:
SELECT concat(First_Name, ' ', Last_Name) 'Name',
    concat(St_Address, ', ', City, ', ', Postal_Code) Address,
    Phone_No as 'Phone Number',
    Date_Received as 'Received Date',
    Date_due as 'Due Date'
FROM Service_Sales, Customer
WHERE 	Customer.First_Name = 'Angie' and
    Service_Sales_Id =  (SELECT Service_Sales_Id
    FROM service_sales
    WHERE sales_ID = 
					(SELECT Sales_ID
    FROM sales
    WHERE Customer_Id = 
					(Select Customer_Id
    FROM Customer
    WHERE First_Name = 'Angie'
        AND Phone_No = 2367897654)));



-- Product Lookup
SELECT Product_Name as Product,
    Listed_price as Price,
    Quantity,
    Product_Description as 'Description'
FROM Product
WHERE 	listed_price BETWEEN 500 AND 1000
;

SELECT * FROM product_sales;


-- To Select Employee of the month
SELECT concat(First_Name, ' ', Last_Name) 'Name',
    concat(St_Address, ', ', City, ', ', Postal_Code) Address,
    Phone_No as 'Phone Number'
FROM Employee E, Sales S
WHERE 	E.Employee_Id = S.Employee_Id AND
    E.Employee_Id = (SELECT Employee_Id
    FROM
        (SELECT EMPLOYEE_Id, count(Employee_ID) as Occurance
        FROM Sales
        GROUP BY Employee_Id
        ORDER BY Occurance DESC LIMIT 1) as t1)
    AND Sale_Date BETWEEN '2019-10-01' AND '2019-10-31'
LIMIT 1;

SELECT * FROM customer;
