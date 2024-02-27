WITH follower_number AS (
    SELECT u1.usr, COUNT(u2.usr) as flw_nmber
    FROM users u1
    JOIN follows f1 ON u1.usr = f1.flwee
    JOIN users u2 ON u2.usr = f1.flwer
    GROUP BY u1.usr
),
retweet_number AS (
    SELECT t1.writer, COUNT(r1.writer) as rtwt_number
    FROM tweets t1
    JOIN retweets r1 ON r1.writer = t1.writer and r1.tdate = t1.tdate
    GROUP BY t1.writer
),
max_retweets AS (
    SELECT writer, (MAX(ret_cnt)/COUNT(WRITER)) AS max_ret_cnt
    FROM tStat
    GROUP BY writer
),
usr_stat AS (
    SELECT
        u1.usr,
        fn.flw_nmber,
        (CASE WHEN m1.max_ret_cnt IS NULL THEN 0 ELSE m1.max_ret_cnt END) AS max_ret_cnt
    FROM users u1
    JOIN follower_number fn ON u1.usr = fn.usr
    LEFT JOIN max_retweets m1 ON m1.writer = u1.usr
),
hghst_flwers AS (
    SELECT usr, flw_nmber, max_ret_cnt, ("top in followers") AS "'top in retweets'"
    FROM (
        SELECT
            usr,
            flw_nmber,
            max_ret_cnt,
            RANK() OVER (ORDER BY flw_nmber DESC) AS rnk
        FROM usr_stat
    ) ranked_users
    WHERE rnk = 1
),
hghst_rtwt AS (
    SELECT writer AS usr, max_ret_cnt, "top in retweets" AS "'top in retweets'"
    FROM (
        SELECT
            writer,
            max_ret_cnt,
            RANK() OVER (ORDER BY max_ret_cnt DESC) AS rnk
        FROM max_retweets
    ) ranked_users
    WHERE writer NOT IN (SELECT usr FROM hghst_flwers) and rnk = 1
)

SELECT usr, 'top in followers'
FROM hghst_flwers
UNION
SELECT usr, 'top in retweets'
FROM hghst_rtwt;

