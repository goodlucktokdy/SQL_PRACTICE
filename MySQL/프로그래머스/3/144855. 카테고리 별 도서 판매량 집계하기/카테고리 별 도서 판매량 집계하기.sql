-- 코드를 입력하세요
SELECT A.CATEGORY, SUM(B.SALES) AS TOTAL_SALES
FROM BOOK AS A
INNER JOIN BOOK_SALES AS B
ON A.BOOK_ID = B.BOOK_ID
WHERE B.SALES_DATE >= 20220101 AND B.SALES_DATE <20220201
GROUP BY A.CATEGORY 
ORDER BY CATEGORY