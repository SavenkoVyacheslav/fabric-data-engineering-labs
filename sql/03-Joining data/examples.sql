-- ============================================================
-- Module      : Joining Data in SQL
-- Course      : DataCamp - Joining Data in SQL
-- Author      : Vyacheslav Savenko
-- Completed   : 2026-08-12
-- ============================================================


-- ------------------------------------------------------------
-- UNION ALL
-- Stack datasets vertically and keep duplicates
-- ------------------------------------------------------------

SELECT *
FROM podcasts_originals
WHERE duration_min >= 60

UNION ALL

SELECT *
FROM podcasts_premium
WHERE duration_min >= 60;


-- ------------------------------------------------------------
-- UNION
-- Stack datasets vertically and remove duplicates
-- ------------------------------------------------------------

SELECT *
FROM podcasts_originals
WHERE duration_min >= 60

UNION

SELECT *
FROM podcasts_premium
WHERE duration_min >= 60
ORDER BY duration_min DESC;


-- ------------------------------------------------------------
-- LEFT JOIN
-- Keep all rows from podcast_plays
-- ------------------------------------------------------------

SELECT
    l.podcast_id,
    l.user_id,
    l.time_played,
    r.genre
FROM podcast_plays AS l
LEFT JOIN podcasts AS r
    ON l.podcast_id = r.podcast_id;


-- ------------------------------------------------------------
-- LEFT JOIN + GROUP BY
-- ------------------------------------------------------------

SELECT
    u.country,
    COUNT(*) AS play_count,
    COUNT(DISTINCT p.user_id) AS unique_user_count,
    COUNT(DISTINCT p.podcast_id) AS unique_podcast_count
FROM plays AS p
LEFT JOIN users AS u
    ON p.user_id = u.user_id
GROUP BY u.country;


-- ------------------------------------------------------------
-- INNER JOIN
-- Keep only matching rows
-- ------------------------------------------------------------

SELECT
    p.podcast_id,
    p.podcast_name,
    pu.tenure
FROM plays AS p
INNER JOIN paid_users AS pu
USING (user_id);


-- ------------------------------------------------------------
-- MULTI-COLUMN JOIN
-- Match using host_id + genre
-- ------------------------------------------------------------

SELECT
    pd.podcast_id,
    pd.podcast_name,
    pgr.rank,
    pd.host_id AS host_id,
    pd.genre AS genre_name
FROM podcasts AS pd
LEFT JOIN host_genre_ranks AS pgr
    ON pd.host_id = pgr.host_id
    AND pd.genre = pgr.genre
WHERE pgr.rank = 1;


-- ------------------------------------------------------------
-- MULTIPLE JOINS
-- Combine three tables
-- ------------------------------------------------------------

SELECT
    pc.podcast_id,
    pc.podcast_name,
    pc.host_id,
    pc.genre,
    hgr.rank,
    h.host_name
FROM podcasts AS pc
LEFT JOIN host_genre_ranks AS hgr
    ON pc.host_id = hgr.host_id
    AND pc.genre = hgr.genre
LEFT JOIN hosts AS h
    ON pc.host_id = h.host_id
WHERE hgr.rank = 1;