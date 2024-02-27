SELECT DISTINCT u1.usr 
FROM users u1, users u2, users u3, follows f1, follows f2
WHERE f2.flwee = f1.flwee
AND u2.usr = f2.flwee
AND UPPER(u3.name) = 'JOHN DOE'
AND f2.flwer = u1.usr
AND f1.flwer = u3.usr
AND julianday('now') - julianday(f2.start_date) >= 90
AND julianday('now') - julianday(f1.start_date) < 90;

