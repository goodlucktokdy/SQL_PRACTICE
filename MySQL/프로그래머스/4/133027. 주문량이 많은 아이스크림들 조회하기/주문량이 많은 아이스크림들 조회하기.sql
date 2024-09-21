WITH base AS (
    SELECT
        flavor,
        total_order
    FROM
        first_half
    UNION ALL
    SELECT
        flavor,
        total_order
    FROM
        july
)
SELECT
    flavor
FROM
(
    SELECT
        flavor,
        SUM(total_order) AS tot_order
    FROM
        base
    GROUP BY
        flavor
) as result
ORDER BY
    tot_order DESC
LIMIT 3;
