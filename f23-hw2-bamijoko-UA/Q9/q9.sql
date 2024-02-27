DROP VIEW IF EXISTS tStat;
CREATE VIEW tstat(writer, tdate, text, ret_cnt, rep_cnt, sim_cnt)
AS  SELECT t1.writer, CAST(t1.tdate AS TEXT), CAST(t1.text AS TEXT),
        (CASE WHEN rep_cnt IS NULL THEN 0 ELSE rep_cnt END),
        COUNT(DISTINCT r1.usr) AS ret_cnt,
        (CASE WHEN mention.sim_cnt IS NULL THEN 0 ELSE mention.sim_cnt END) AS sim_cnt
    FROM tweets t1
    LEFT JOIN retweets r1 ON t1.writer = r1.writer AND t1.tdate = r1.tdate
    LEFT JOIN mentions m1 ON t1.writer = m1.writer
    LEFT JOIN (
        SELECT
            t.replyto_w,
            t.replyto_d,
            COUNT(CASE WHEN t.replyto_w IS NOT NULL THEN 1 ELSE NULL END) AS rep_cnt
        FROM tweets t
        GROUP BY t.replyto_w, t.replyto_d
    ) AS reply ON t1.writer = reply.replyto_w AND t1.tdate = reply.replyto_d
    LEFT JOIN (
        SELECT
            m1.tdate,
            m1.writer,
            MAX(tc.sim_cnt) AS sim_cnt
        FROM mentions m1
        JOIN (
            SELECT
                term,
                COUNT(*) AS sim_cnt
            FROM mentions
            WHERE writer IS NOT NULL
            GROUP BY term
        ) tc ON tc.term = m1.term
        GROUP BY m1.tdate, m1.writer
    ) AS mention ON mention.writer = t1.writer AND mention.tdate = t1.tdate
    GROUP BY t1.writer, t1.tdate, t1.text;

SELECT * FROM tStat;
