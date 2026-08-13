# Intermediate SQL Notes

## DISTINCT

Returns unique values.

```sql
SELECT DISTINCT country
FROM customers;

Multiple columns can also be used:

SELECT DISTINCT country, city
FROM customers;
COUNT

Count rows:

SELECT COUNT(*)
FROM customers;

Count unique values:

SELECT COUNT(DISTINCT country)
FROM customers;
WHERE

Filters rows based on a condition.

SELECT *
FROM books
WHERE release_year > 2020;
AND / OR
SELECT *
FROM books
WHERE release_year >= 2020
  AND rating >= 4;
SELECT *
FROM books
WHERE genre = 'Science'
   OR genre = 'Technology';
BETWEEN

Includes both boundary values.

SELECT *
FROM books
WHERE release_year BETWEEN 2015 AND 2020;
LIKE and NOT LIKE

Used for pattern matching.

% = zero or more characters
_ = exactly one character

SELECT *
FROM books
WHERE author LIKE '%r';
SELECT *
FROM books
WHERE title LIKE '__t%';
SELECT *
FROM books
WHERE author NOT LIKE 'A%';
IN

Used instead of multiple OR conditions.

SELECT *
FROM books
WHERE release_year IN (2020, 2021, 2022);
NULL
SELECT *
FROM books
WHERE rating IS NULL;
SELECT *
FROM books
WHERE rating IS NOT NULL;

Important:

column = NULL       ❌
column IS NULL      ✅
Aggregate Functions

Common aggregate functions:

MIN()
MAX()
AVG()
COUNT()
SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(price) AS avg_price,
    COUNT(*) AS book_count
FROM books;
ROUND
SELECT ROUND(AVG(price), 2) AS avg_price
FROM books;
Arithmetic
SELECT
    title,
    price,
    price * 1.25 AS price_with_markup
FROM books;
ORDER BY

Ascending:

SELECT *
FROM books
ORDER BY release_year ASC;

Descending:

SELECT *
FROM books
ORDER BY release_year DESC;

Multiple columns:

SELECT *
FROM books
ORDER BY release_year DESC, title ASC;
GROUP BY

Groups rows before applying aggregate functions.

SELECT
    genre,
    COUNT(*) AS book_count
FROM books
GROUP BY genre;
HAVING

Filters groups after GROUP BY.

SELECT
    genre,
    COUNT(*) AS book_count
FROM books
GROUP BY genre
HAVING COUNT(*) >= 5;
WHERE vs HAVING
WHERE filters rows before grouping.
HAVING filters groups after aggregation.

Typical query structure:

SELECT
    genre,
    COUNT(*) AS book_count
FROM books
WHERE release_year >= 2020
GROUP BY genre
HAVING COUNT(*) >= 5
ORDER BY book_count DESC;
```
