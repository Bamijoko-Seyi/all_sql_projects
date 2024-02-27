WITH subquery AS (
    SELECT t1.writer, t1.tdate, t1.text, COUNT(r1.usr) AS retweet_count
    FROM tweets t1
    LEFT JOIN retweets r1 ON t1.writer = r1.writer AND t1.tdate = r1.tdate
    GROUP BY t1.writer, t1.tdate, t1.text
)
SELECT writer, tdate, text
FROM Subquery
WHERE retweet_count IN (
    SELECT retweet_count
    FROM (
        SELECT t2.writer, t2.tdate, t2.text, COUNT(r2.usr) AS retweet_count
        FROM tweets t2
        LEFT JOIN retweets r2 ON t2.writer = r2.writer AND t2.tdate = r2.tdate
        GROUP BY t2.writer, t2.tdate, t2.text
        ORDER BY retweet_count DESC
        LIMIT 3
    )
)
ORDER BY retweet_count DESC;
