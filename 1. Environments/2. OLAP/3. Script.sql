--LOAD CUSTOMER DATA (1st LOAD)
WITH S AS (
     SELECT * FROM Relational.customers
),
UPD AS (
     UPDATE Dimensional.dim_customer T
     SET    validity_end_date = current_date
     FROM   S
     WHERE  (T.id_customer = S.id_customer AND T.validity_end_date IS NULL)
            AND (T.customer_name <> S.customer_name OR T.customer_state <> S.customer_state OR T.customer_gender <> S.customer_gender OR T.customer_status <> S.customer_status)
     RETURNING T.id_customer
)
INSERT INTO Dimensional.dim_customer(id_customer, customer_name, customer_state, customer_gender, customer_status, validity_start_date, validity_end_date)
SELECT id_customer, customer_name, customer_state, customer_gender, customer_status, current_date, null FROM S
WHERE S.id_customer IN (SELECT id_customer FROM UPD) OR
      S.id_customer NOT IN (SELECT id_customer FROM Dimensional.dim_customer);

--LOAD PRODUCT DATA (1st LOAD)
WITH S AS (
     SELECT * FROM Relational.products
),
UPD AS (
     UPDATE Dimensional.dim_product T
     SET    validity_end_date = current_date
     FROM   S
     WHERE  (T.id_product = S.id_product AND T.validity_end_date IS NULL)
            AND (T.product_name <> S.product_name)
     RETURNING T.id_product
)
INSERT INTO Dimensional.dim_product(id_product, product_name, validity_start_date, validity_end_date)
SELECT id_product, product_name, current_date, null FROM S
WHERE S.id_product IN (SELECT id_product FROM UPD) OR
      S.id_product NOT IN (SELECT id_product FROM Dimensional.dim_product);

--LOAD SELLER DATA (1st LOAD)
WITH S AS (
     SELECT * FROM Relational.sellers
),
UPD AS (
     UPDATE Dimensional.dim_seller T
     SET    validity_end_date = current_date
     FROM   S
     WHERE  (T.id_seller = S.id_seller AND T.validity_end_date IS NULL)
            AND (T.seller_name <> S.seller_name)
     RETURNING T.id_seller
)
INSERT INTO Dimensional.dim_seller(id_seller, seller_name, validity_start_date, validity_end_date)
SELECT id_seller, seller_name, current_date, null FROM S
WHERE S.id_seller IN (SELECT id_seller FROM UPD) OR
      S.id_seller NOT IN (SELECT id_seller FROM Dimensional.dim_seller);

--ONLY THE MONTH OF JANUARY IS LOADED INTO FACT_SALES
INSERT INTO Dimensional.fact_sales(seller_key, customer_key, product_key, time_key, quantity, unit_price, total_price, discount)
SELECT
    vdd.seller_key,
    c.customer_key,
    p.product_key,
    t.time_key,
    iv.quantity,
    iv.unit_price,
    iv.total_price,
    iv.discount
FROM Relational.sales v
INNER JOIN Dimensional.dim_seller vdd
    ON v.id_seller = vdd.id_seller AND vdd.validity_end_date IS NULL
INNER JOIN Relational.sale_items iv
    ON v.id_sale = iv.id_sale
INNER JOIN Dimensional.dim_customer c
    ON v.id_customer = c.id_customer AND c.validity_end_date IS NULL
INNER JOIN Dimensional.dim_product p
    ON iv.id_product = p.id_product AND p.validity_end_date IS NULL
INNER JOIN Dimensional.dim_time t
    ON v.sale_date = t.time_date
WHERE date_part('MONTH', v.sale_date) = 01;

--A PLAN CHANGE IS BEING MADE FOR CUSTOMERS WITH IDs 1 TO 5.
UPDATE Relational.customers SET customer_status = 'Gold' WHERE id_customer BETWEEN 1 AND 5;

--LOAD CUSTOMER DATA. WILL ONLY PROCESS HISTORY FOR MODIFIED RECORDS (CUSTOMERS WITH IDs 1 TO 5)
WITH S AS (
     SELECT * FROM Relational.customers
),
UPD AS (
     UPDATE Dimensional.dim_customer T
     SET    validity_end_date = current_date
     FROM   S
     WHERE  (T.id_customer = S.id_customer AND T.validity_end_date IS NULL)
            AND (T.customer_name <> S.customer_name OR T.customer_state <> S.customer_state OR T.customer_gender <> S.customer_gender OR T.customer_status <> S.customer_status)
     RETURNING T.id_customer
)
INSERT INTO Dimensional.dim_customer(id_customer, customer_name, customer_state, customer_gender, customer_status, validity_start_date, validity_end_date)
SELECT id_customer, customer_name, customer_state, customer_gender, customer_status, current_date, null FROM S
WHERE S.id_customer IN (SELECT id_customer FROM UPD) OR
      S.id_customer NOT IN (SELECT id_customer FROM Dimensional.dim_customer);

--CHECK THE MODIFIED CUSTOMERS TO VERIFY EACH CUSTOMER'S HISTORY. DATE FIELDS HAVE BEEN UPDATED.
SELECT * FROM Dimensional.dim_customer WHERE id_customer BETWEEN 1 AND 5;

--VERIFIED THAT THE CUSTOMERS IN THE FACT LOAD FOR JANUARY ARE POINTING TO THE OLD SKs OF CUSTOMERS 1, 2, 3, AND 5
SELECT * FROM Dimensional.fact_sales f
    INNER JOIN Dimensional.dim_customer c
        ON f.customer_key = c.customer_key
WHERE c.id_customer BETWEEN 1 AND 5;

--ONLY THE MONTH OF FEBRUARY IS LOADED INTO FACT_SALES
INSERT INTO Dimensional.fact_sales(seller_key, customer_key, product_key, time_key, quantity, unit_price, total_price, discount)
SELECT
    vdd.seller_key,
    c.customer_key,
    p.product_key,
    t.time_key,
    iv.quantity,
    iv.unit_price,
    iv.total_price,
    iv.discount
FROM Relational.sales v
INNER JOIN Dimensional.dim_seller vdd
    ON v.id_seller = vdd.id_seller AND vdd.validity_end_date IS NULL
INNER JOIN Relational.sale_items iv
    ON v.id_sale = iv.id_sale
INNER JOIN Dimensional.dim_customer c
    ON v.id_customer = c.id_customer AND c.validity_end_date IS NULL
INNER JOIN Dimensional.dim_product p
    ON iv.id_product = p.id_product AND p.validity_end_date IS NULL
INNER JOIN Dimensional.dim_time t
    ON v.sale_date = t.time_date
WHERE date_part('MONTH', v.sale_date) = 02;

--NOTE THAT THE FACT LOAD CUSTOMERS FOR JANUARY ARE POINTING TO THE OLD SKs OF CUSTOMERS 1 TO 5. IN FEBRUARY, ONLY CUSTOMER 5 MADE PURCHASES.
--THE FACT RECORDS ALREADY POINT TO THE CUSTOMER'S LATEST SK.
SELECT * FROM Dimensional.fact_sales f
    INNER JOIN Dimensional.dim_customer c
        ON f.customer_key = c.customer_key
WHERE c.id_customer BETWEEN 1 AND 5;

--ONLY THE MONTH OF MARCH IS LOADED INTO FACT_SALES
INSERT INTO Dimensional.fact_sales(seller_key, customer_key, product_key, time_key, quantity, unit_price, total_price, discount)
SELECT
    vdd.seller_key,
    c.customer_key,
    p.product_key,
    t.time_key,
    iv.quantity,
    iv.unit_price,
    iv.total_price,
    iv.discount
FROM Relational.sales v
INNER JOIN Dimensional.dim_seller vdd
    ON v.id_seller = vdd.id_seller AND vdd.validity_end_date IS NULL
INNER JOIN Relational.sale_items iv
    ON v.id_sale = iv.id_sale
INNER JOIN Dimensional.dim_customer c
    ON v.id_customer = c.id_customer AND c.validity_end_date IS NULL
INNER JOIN Dimensional.dim_product p
    ON iv.id_product = p.id_product AND p.validity_end_date IS NULL
INNER JOIN Dimensional.dim_time t
    ON v.sale_date = t.time_date
WHERE date_part('MONTH', v.sale_date) = 03;

--IN MARCH, NONE OF THE CUSTOMERS WE ARE TRACKING (1 TO 5) MADE PURCHASES.
SELECT * FROM Dimensional.fact_sales f
    INNER JOIN Dimensional.dim_customer c
        ON f.customer_key = c.customer_key
    INNER JOIN Dimensional.dim_time t
        ON f.time_key = t.time_key
WHERE c.id_customer BETWEEN 1 AND 5 AND t.time_month = 3;

--MAKE A PLAN CHANGE FOR CUSTOMER 3
UPDATE Relational.customers SET customer_status = 'Platinum' WHERE id_customer = 3;

--LOAD CUSTOMER DATA. WILL ONLY PROCESS HISTORY FOR MODIFIED RECORDS (CUSTOMER 3)
WITH S AS (
     SELECT * FROM Relational.customers
),
UPD AS (
     UPDATE Dimensional.dim_customer T
     SET    validity_end_date = current_date
     FROM   S
     WHERE  (T.id_customer = S.id_customer AND T.validity_end_date IS NULL)
            AND (T.customer_name <> S.customer_name OR T.customer_state <> S.customer_state OR T.customer_gender <> S.customer_gender OR T.customer_status <> S.customer_status)
     RETURNING T.id_customer
)
INSERT INTO Dimensional.dim_customer(id_customer, customer_name, customer_state, customer_gender, customer_status, validity_start_date, validity_end_date)
SELECT id_customer, customer_name, customer_state, customer_gender, customer_status, current_date, null FROM S
WHERE S.id_customer IN (SELECT id_customer FROM UPD) OR
      S.id_customer NOT IN (SELECT id_customer FROM Dimensional.dim_customer);

--CHECK THE MODIFIED CUSTOMERS TO VERIFY EACH CUSTOMER'S HISTORY. DATE FIELDS HAVE BEEN UPDATED.
SELECT * FROM Dimensional.dim_customer WHERE id_customer BETWEEN 1 AND 5;

--LOAD ALL REMAINING MONTHS
INSERT INTO Dimensional.fact_sales(seller_key, customer_key, product_key, time_key, quantity, unit_price, total_price, discount)
SELECT
    vdd.seller_key,
    c.customer_key,
    p.product_key,
    t.time_key,
    iv.quantity,
    iv.unit_price,
    iv.total_price,
    iv.discount
FROM Relational.sales v
INNER JOIN Dimensional.dim_seller vdd
    ON v.id_seller = vdd.id_seller AND vdd.validity_end_date IS NULL
INNER JOIN Relational.sale_items iv
    ON v.id_sale = iv.id_sale
INNER JOIN Dimensional.dim_customer c
    ON v.id_customer = c.id_customer AND c.validity_end_date IS NULL
INNER JOIN Dimensional.dim_product p
    ON iv.id_product = p.id_product AND p.validity_end_date IS NULL
INNER JOIN Dimensional.dim_time t
    ON v.sale_date = t.time_date
WHERE date_part('MONTH', v.sale_date) > 03;

--CHECK ALL PURCHASES FROM THE CUSTOMERS WE ARE TRACKING (1 TO 5). VERIFIED THAT THERE ARE PURCHASES LINKED TO THE OLD SK STATUS AND PURCHASES LINKED TO THE LATEST SK STATUS.
SELECT * FROM Dimensional.fact_sales f
    INNER JOIN Dimensional.dim_customer c
        ON f.customer_key = c.customer_key
    INNER JOIN Dimensional.dim_time t
        ON f.time_key = t.time_key
WHERE c.id_customer BETWEEN 1 AND 5;
