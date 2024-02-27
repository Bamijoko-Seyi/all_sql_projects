SELECT DISTINCT u1.usr, u1.name
FROM users u1
JOIN tweets t1 ON u1.usr = t1.writer
JOIN tweets t2 ON u1.usr = t2.writer AND t1.tdate <> t2.tdate
WHERE u1.usr IN (
    SELECT DISTINCT f1.flwer AS usr
FROM follows f1
JOIN users u1 ON f1.flwee = u1.usr
JOIN users u2 ON u1.name LIKE 'John Doe'
WHERE NOT EXISTS (
    SELECT 1
    FROM follows f2
    JOIN users u3 ON f2.flwer = u3.usr
    WHERE u3.name LIKE 'John Doe'
      AND NOT EXISTS (
          SELECT 1
          FROM follows f3
          WHERE f3.flwer = f1.flwer AND f3.flwee = f2.flwee
      )
)
);