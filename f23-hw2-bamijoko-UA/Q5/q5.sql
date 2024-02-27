SELECT DISTINCT u1.usr, t1.text, t1.tdate 
FROM users u1, users u2, users u3, users u4
JOIN tweets t1 ON u1.usr  = t1.writer
JOIN retweets r1 ON r1.writer = t1.writer AND r1.usr = u2.usr AND r1.tdate = t1.tdate 
JOIN retweets r2 ON r2.writer = t1.writer AND r2.usr = u3.usr AND r2.tdate = t1.tdate AND r2.rdate <> r1.rdate
JOIN retweets r3 ON r3.writer = t1.writer AND r3.usr = u4.usr AND r3.tdate = t1.tdate AND r2.rdate <> r1.rdate AND r3.rdate <> r1.rdate AND r2.rdate <> r3.rdate
JOIN follows f1 ON f1.flwee = u1.usr AND f1.flwer = u2.usr
JOIN follows f2 ON f2.flwee = u1.usr AND f2.flwer = u3.usr
JOIN follows f3 ON f3.flwee = u1.usr AND f3.flwer = u4.usr
