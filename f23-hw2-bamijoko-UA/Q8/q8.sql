WITH tweet_info AS (
    SELECT t1.writer, t1.tdate, t1.replyto_w, r1.writer,
        COUNT(t1.writer) AS tweet_count,
        strftime('%m', datetime(t1.tdate)) AS month,
        COUNT(r1.writer) AS retweet_count
    FROM tweets t1
    LEFT JOIN retweets r1 ON t1.writer = r1.writer AND strftime('%Y', datetime(t1.tdate)) = '2023'
    GROUP BY strftime('%m', datetime(t1.tdate))
),
null_count AS (
    SELECT
        COUNT(CASE WHEN t1.replyto_w IS NULL THEN 0 ELSE 1 END) AS null_count,
        strftime('%m', datetime(t1.tdate)) AS month
    FROM tweets t1
    WHERE t1.replyto_w IS NULL AND t1.replyto_d IS NULL AND strftime('%Y', datetime(t1.tdate)) = '2023'
    GROUP BY strftime('%m', datetime(t1.tdate))
),
tweet_count AS (
    SELECT
        COUNT(t1.replyto_w) AS tweet_count,
        strftime('%m', datetime(t1.tdate)) AS month
    FROM tweets t1
    WHERE t1.replyto_w IS NOT NULL AND strftime('%Y', datetime(t1.tdate)) = '2023'
    GROUP BY strftime('%m', datetime(t1.tdate))
),
retweet_count AS (
    SELECT
        COUNT(strftime('%m', datetime(r1.rdate))) AS retweet_count,
        strftime('%m', datetime(r1.rdate)) AS month
    FROM retweets r1
    WHERE strftime('%Y', datetime(r1.rdate)) = '2023'
    GROUP BY strftime('%m', datetime(r1.rdate))
)

SELECT 
    CAST(tweet_info.month AS TEXT) AS month_str,
    (CASE WHEN null_count.null_count IS NULL THEN 0 ELSE null_count.null_count END) AS tcnt,
    (CASE WHEN tweet_count.tweet_count IS NULL THEN 0 ELSE tweet_count.tweet_count END) AS rep_cnt,
    (CASE WHEN retweet_count.retweet_count IS NULL THEN 0 ELSE retweet_count.retweet_count END) AS ret_cnt,
    (CASE WHEN null_count.null_count IS NULL THEN 0 ELSE null_count.null_count END) +
    (CASE WHEN tweet_count.tweet_count IS NULL THEN 0 ELSE tweet_count.tweet_count END) +
    (CASE WHEN retweet_count.retweet_count IS NULL THEN 0 ELSE retweet_count.retweet_count END) AS total
FROM tweet_info
LEFT OUTER JOIN null_count ON tweet_info.month = null_count.month
LEFT OUTER JOIN tweet_count ON tweet_info.month = tweet_count.month
LEFT OUTER JOIN retweet_count ON tweet_info.month = retweet_count.month;
