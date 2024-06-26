WITH U AS (SELECT * FROM FIRST_HALF
UNION ALL
SELECT * FROM JULY)
SELECT A.FLAVOR
FROM
(SELECT FLAVOR, SUM(TOTAL_ORDER) AS TOT FROM U
       GROUP BY FLAVOR ORDER BY TOT DESC LIMIT 3) AS A