WITH CTE AS
(SELECT PRODUCT_ID, SUM(AMOUNT) AS AMNT FROM FOOD_ORDER
WHERE DATE_FORMAT(PRODUCE_DATE,'%Y-%m') = '2022-05'
GROUP BY PRODUCT_ID)
SELECT B.PRODUCT_ID, A.PRODUCT_NAME, A.PRICE * B.AMNT AS TOTAL_SALES
FROM CTE AS B
INNER JOIN
FOOD_PRODUCT AS A
ON A.PRODUCT_ID = B.PRODUCT_ID
ORDER BY TOTAL_SALES DESC, B.PRODUCT_ID ASC