SELECT B.APNT_NO, C.PT_NAME, B.PT_NO, B.MCDP_CD, A.DR_NAME, B.APNT_YMD
FROM APPOINTMENT AS B
LEFT JOIN
DOCTOR AS A
ON A.DR_ID = B.MDDR_ID
INNER JOIN
PATIENT AS C
ON C.PT_NO = B.PT_NO
WHERE B.MCDP_CD = 'CS' AND DATE_FORMAT(B.APNT_YMD,'%Y-%m-%d') = '2022-04-13'
AND B.APNT_CNCL_YN != 'Y'
ORDER BY B.APNT_YMD ASC