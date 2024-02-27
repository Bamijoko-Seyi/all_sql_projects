SELECT DISTINCT users.usr 
FROM users,follows,tweets,includes
WHERE users.usr = follows.flwee
AND users.usr = tweets.writer
AND users.usr = includes.member;