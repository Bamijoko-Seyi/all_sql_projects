SELECT DISTINCT u1.usr
FROM users u1
JOIN tweets t1 ON u1.usr = t1.writer
JOIN tweets t2 ON u1.usr = t2.writer AND t1.tdate <> t2.tdate
JOIN tweets t3 ON u1.usr = t3.writer AND t1.tdate <> t3.tdate AND t2.tdate <> t3.tdate
LEFT JOIN follows f1 ON u1.usr = f1.flwee
WHERE UPPER(t1.text) LIKE '%EDMONTON%'
AND UPPER(t2.text) LIKE '%EDMONTON%'
AND UPPER(t3.text) LIKE '%EDMONTON%'
AND f1.flwer IS NULL;