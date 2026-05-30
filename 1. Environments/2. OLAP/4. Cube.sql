SELECT
    dc.customer_name,
    dc.customer_state,
    dc.customer_gender,
    dc.customer_status,
    fv.quantity,
    fv.unit_price,
    fv.total_price,
    fv.discount,
    dp.product_name,
    dt.time_date,
    dt.time_day,
    dt.time_month,
    dt.time_year,
    dt.time_quarter,
    dv.seller_name
INTO Dimensional.sales_cube
FROM Dimensional.fact_sales fv
INNER JOIN Dimensional.dim_customer dc  ON fv.customer_key = dc.customer_key
INNER JOIN Dimensional.dim_product dp   ON fv.product_key = dp.product_key
INNER JOIN Dimensional.dim_time dt      ON fv.time_key = dt.time_key
INNER JOIN Dimensional.dim_seller dv    ON fv.seller_key = dv.seller_key;
