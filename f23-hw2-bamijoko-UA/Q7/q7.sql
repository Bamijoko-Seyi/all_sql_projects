WITH big_lists AS (
    SELECT i1.member, i1.lname, COUNT(i1.member) AS member_count
    FROM includes i1
    JOIN lists l1 ON l1.lname = i1.lname
    GROUP BY i1.lname
    HAVING COUNT(i1.lname) >= 6
)

SELECT lname
FROM big_lists, follows f1
JOIN users u1 ON UPPER(u1.name) = 'JOHN DOE' AND f1.flwee = u1.usr
JOIN users u2 ON f1.flwer = u2.usr AND u2.usr IN (SELECT member FROM big_lists)
GROUP BY lname
HAVING COUNT(u2.usr) / COUNT(DISTINCT big_lists.member) > 0.50;
