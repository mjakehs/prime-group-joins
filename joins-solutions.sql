--1
SELECT * 
FROM "customers"
LEFT JOIN "addresses" ON "customers".id="addresses".customer_id;

--2
SELECT "orders".id, "orders".order_date, "line_items".quantity, "products".description
FROM "orders"
JOIN "line_items" ON "orders".id="line_items".order_id
JOIN "products" ON "products".id="line_items".product_id;

--3
SELECT "warehouse".warehouse
FROM "warehouse"
JOIN "warehouse_product" ON "warehouse".id="warehouse_product".warehouse_id
JOIN "products" ON "products".id="warehouse_product".product_id
WHERE "products".description='cheetos';

--4
SELECT "warehouse".warehouse
FROM "warehouse"
JOIN "warehouse_product" ON "warehouse".id="warehouse_product".warehouse_id
JOIN "products" ON "products".id="warehouse_product".product_id
WHERE "products".description='diet pepsi';

--5
SELECT "customers".first_name, "customers".last_name, COUNT("orders".id)
FROM "customers"
JOIN "addresses" ON "customers".id="addresses".customer_id
JOIN "orders" ON "addresses".id="orders".address_id
GROUP BY "customers".first_name, "customers".last_name;

--6
SELECT COUNT(*)
FROM "customers";

--7
SELECT COUNT(*)
FROM "products";

--8
SELECT "products".description, SUM("warehouse_product".on_hand)
FROM "products"
JOIN "warehouse_product" ON "products".id="warehouse_product".product_id
WHERE "products".description='diet pepsi'
GROUP BY "products".description;

--9
SELECT "orders".id, "orders".order_date, sum("products".unit_price*"line_items".quantity) AS "total_cost"
FROM "orders"
FULL OUTER JOIN
FULL OUTER JOIN "products" ON "products".id="line_items".product_id
GROUP BY "orders".id, "orders".order_date;

--10
SELECT "customers".first_name, "customers".last_name, SUM("products".unit_price*"line_items".quantity) AS "total_spent"
FROM "customers"
JOIN "addresses" ON "customers".id="addresses".customer_id
JOIN "orders" ON "addresses".id="orders".address_id
JOIN "line_items" ON "orders".id="line_items".order_id
JOIN "products" ON "products".id="line_items".product_id
GROUP BY "customers".first_name, "customers".last_name;

--11
SELECT "customers".first_name, "customers".last_name,  COALESCE(SUM("products".unit_price*"line_items".quantity), 0) AS "total_spent"
FROM "customers"
LEFT JOIN "addresses" ON "customers".id="addresses".customer_id
LEFT JOIN "orders" ON "addresses".id="orders".address_id
LEFT JOIN "line_items" ON "orders".id="line_items".order_id
LEFT JOIN "products" ON "products".id="line_items".product_id
GROUP BY "customers".first_name, "customers".last_name;