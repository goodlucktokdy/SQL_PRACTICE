WITH base AS (
    SELECT
        user_id,
        product_id,
        sales_amount,
        sales_date
    FROM
        online_sale
    UNION
    SELECT
        NULL AS user_id,
        product_id,
        sales_amount,
        sales_date
    FROM
        offline_sale
)
SELECT
    date_format(sales_date,'%Y-%m-%d') as sales_date,  
    product_id,
    user_id,
    sales_amount
FROM
    base
WHERE
    sales_date BETWEEN '2022-03-01' AND '2022-03-31'
ORDER BY
    sales_date, product_id, user_id;
