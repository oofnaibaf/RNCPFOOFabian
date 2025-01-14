USE globalsuperstore;



 -- Retrieve All Orders with Customer Details
SELECT 
    o.OrderID,
    o.OrderDate,
    o.ShippingDate,
    c.CustomerName,
    c.Segment,
    cl.City,
    cl.State,
    cl.Country
FROM 
    orders o
JOIN 
    customers c ON o.CustomerID = c.CustomerID
JOIN 
    customerlocations cl ON c.CustomerID = cl.CustomerID
ORDER BY 
    o.OrderDate DESC;

-- Total Sales and Profit by Product
SELECT 
    p.ProductName,
    p.Category,
    SUM(od.Quantity) AS TotalQuantitySold,
    SUM(o.Sales) AS TotalSales,
    SUM(o.Profit) AS TotalProfit
FROM 
    orderdetails od
JOIN 
    products p ON od.ProductID = p.ProductID
JOIN 
    orders o ON od.OrderID = o.OrderID
GROUP BY 
    p.ProductName, p.Category
ORDER BY 
    TotalSales DESC;

-- Total Sales & Profit by product
SELECT 
    c.CustomerName,
    SUM(o.Profit) AS TotalProfit
FROM 
    orders o
JOIN 
    customers c ON o.CustomerID = c.CustomerID
GROUP BY 
    c.CustomerName
ORDER BY 
    TotalProfit DESC
LIMIT 5;
    
    --  Identify the Top 5 Most Profitable Customers
    SELECT 
    c.CustomerName,
    SUM(o.Profit) AS TotalProfit
FROM 
    orders o
JOIN 
    customers c ON o.CustomerID = c.CustomerID
GROUP BY 
    c.CustomerName
ORDER BY 
    TotalProfit DESC
LIMIT 5;

-- Orders and shipping costs by country
SELECT 
    cl.Country,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(od.ShippingCost) AS TotalShippingCost
FROM 
    orders o
JOIN 
    orderdetails od ON o.OrderID = od.OrderID
JOIN 
    customerlocations cl ON o.CustomerID = cl.CustomerID
GROUP BY 
    cl.Country
ORDER BY 
    TotalOrders DESC;
    
    -- Monthly sales trends
    SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS Month,
    SUM(Sales) AS TotalSales
FROM 
    orders
GROUP BY 
    Month
ORDER BY 
    Month ASC;
    
    -- Orders with High discounts
    
    SELECT 
    o.OrderID,
    c.CustomerName,
    o.Sales,
    o.Profit,
    o.Discount
FROM 
    orders o
JOIN 
    customers c ON o.CustomerID = c.CustomerID
WHERE 
    o.Discount > 0.3
ORDER BY 
    o.Discount DESC;

-- Category-wise sales distribution
SELECT 
    p.Category,
    SUM(o.Sales) AS TotalSales
FROM 
    orders o
JOIN 
    orderdetails od ON o.OrderID = od.OrderID
JOIN 
    products p ON od.ProductID = p.ProductID
GROUP BY 
    p.Category
ORDER BY 
    TotalSales DESC;

-- Shipping mode analysis
SELECT 
    o.ShippingMode,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.Sales) AS TotalSales,
    AVG(od.ShippingCost) AS AvgShippingCost
FROM 
    orders o
JOIN 
    orderdetails od ON o.OrderID = od.OrderID
GROUP BY 
    o.ShippingMode
ORDER BY 
    TotalOrders DESC;
    
    -- Low-Profit Products
    
SELECT 
    p.ProductName,
    p.Category,
    SUM(o.Profit) AS TotalProfit
FROM 
    products p
JOIN 
    orderdetails od ON p.ProductID = od.ProductID
JOIN 
    orders o ON od.OrderID = o.OrderID
GROUP BY 
    p.ProductName, p.Category
HAVING 
    TotalProfit < 100
ORDER BY 
    TotalProfit ASC;
    
    -- Customers with multiple locations
    SELECT 
    c.CustomerName,
    COUNT(DISTINCT cl.City) AS UniqueCities
FROM 
    customers c
JOIN 
    customerlocations cl ON c.CustomerID = cl.CustomerID
GROUP BY 
    c.CustomerName
HAVING 
    UniqueCities > 1
ORDER BY 
    UniqueCities DESC;
    
