WITH base AS (
    SELECT 
        a.car_id,
        b.car_type,
        b.daily_fee,
        a.start_date,
        a.end_date,
        c.duration_type,
        c.discount_rate
    FROM car_rental_company_rental_history a
    JOIN car_rental_company_car b
    ON a.car_id = b.car_id
    left join car_rental_company_discount_plan c
    on b.car_type = c.car_type and c.duration_type = '30일 이상'
), 
fee_table AS (
    SELECT
        car_id,
        car_type,
        start_date,
        end_date,
        CASE 
            WHEN car_type = 'SUV' THEN daily_fee * 0.30 * (100-discount_rate)
            WHEN car_type = '세단' THEN daily_fee * 0.30 * (100-discount_rate)
        END AS fee
    FROM base
), final_table AS (
    SELECT 
        *
    FROM
        fee_table ft
    WHERE NOT EXISTS (
        SELECT 1
        FROM base b
        WHERE b.car_id = ft.car_id
        AND (
            -- 대여 기간이 2022-11-01 ~ 2022-11-30와 겹치는 경우
            b.start_date <= '2022-11-30' 
            AND b.end_date >= '2022-11-01'
        )
    )
)
SELECT
    distinct
    car_id, 
    car_type,
    ROUND(fee) AS fee
FROM
    final_table
WHERE
    fee >= 500000 
    AND fee < 2000000
    AND car_type IN ('SUV', '세단')
ORDER BY
    fee DESC, car_type ASC, car_id DESC;
