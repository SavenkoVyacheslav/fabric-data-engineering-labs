```sql
-- ============================================================
-- Module      : SQL Intermediate
-- Course      : DataCamp - Intermediate SQL
-- Author      : Vyacheslav Savenko
-- Completed   : 2026-08-07
-- ============================================================


-- ------------------------------------------------------------
-- DISTINCT
-- ------------------------------------------------------------

SELECT DISTINCT author
FROM books;

SELECT DISTINCT author, genre
FROM books;


-- ------------------------------------------------------------
-- COUNT / COUNT DISTINCT
-- ------------------------------------------------------------

SELECT COUNT(*)
FROM books;

SELECT COUNT(DISTINCT author) AS unique_authors
FROM books;


-- ------------------------------------------------------------
-- WHERE
-- ------------------------------------------------------------

SELECT *
FROM books
WHERE release_year > 2020;


-- ------------------------------------------------------------
-- AND / OR
-- ------------------------------------------------------------

SELECT *
FROM books
WHERE release_year >= 2020
  AND rating >= 4;

SELECT *
FROM books
WHERE genre = 'Science'
   OR genre = 'Technology';


-- ------------------------------------------------------------
-- BETWEEN
-- ------------------------------------------------------------

SELECT *
FROM books
WHERE release_year BETWEEN 2015 AND 2020;


-- ------------------------------------------------------------
-- LIKE / NOT LIKE
-- ------------------------------------------------------------

SELECT *
FROM books
WHERE author LIKE '%r';

SELECT *
FROM books
WHERE title LIKE '__t%';

SELECT *
FROM books
WHERE author NOT LIKE 'A%';


-- ------------------------------------------------------------
-- IN
-- ------------------------------------------------------------

SELECT *
FROM books
WHERE release_year IN (2020, 2021, 2022);


-- ------------------------------------------------------------
-- NULL
-- ------------------------------------------------------------

SELECT *
FROM books
WHERE rating IS NULL;

SELECT *
FROM books
WHERE rating IS NOT NULL;


-- ------------------------------------------------------------
-- AGGREGATE FUNCTIONS
-- ------------------------------------------------------------

SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(price) AS avg_price,
    COUNT(*) AS total_books
FROM books;


-- ------------------------------------------------------------
-- ROUND
-- ------------------------------------------------------------

SELECT ROUND(AVG(price), 2) AS avg_price
FROM books;


-- ------------------------------------------------------------
-- ARITHMETIC
-- ------------------------------------------------------------

SELECT
    title,
    price,
    price * 1.25 AS price_with_markup
FROM books;


-- ------------------------------------------------------------
-- ORDER BY
-- ------------------------------------------------------------

SELECT *
FROM books
ORDER BY release_year DESC;

SELECT *
FROM books
ORDER BY release_year DESC, title ASC;


-- ------------------------------------------------------------
-- GROUP BY
-- ------------------------------------------------------------

SELECT
    genre,
    COUNT(*) AS book_count
FROM books
GROUP BY genre;


-- ------------------------------------------------------------
-- HAVING
-- ------------------------------------------------------------

SELECT
    genre,
    COUNT(*) AS book_count
FROM books
GROUP BY genre
HAVING COUNT(*) >= 5;


-- ------------------------------------------------------------
-- COMBINED EXAMPLE
-- WHERE -> GROUP BY -> HAVING -> ORDER BY
-- ------------------------------------------------------------

SELECT
    genre,
    COUNT(*) AS book_count,
    ROUND(AVG(price), 2) AS avg_price
FROM books
WHERE release_year >= 2020
GROUP BY genre
HAVING COUNT(*) >= 5
ORDER BY avg_price DESC;