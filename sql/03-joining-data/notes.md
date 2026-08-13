# Joining Data in SQL Notes

## Two Ways to Combine Data

SQL can combine datasets in two main directions:

### Vertically

Add rows from one result set below another.

Typical operation:

```sql
UNION ALL
```

### Horizontally

Add columns from another table by matching related rows.

Typical operations:

```sql
INNER JOIN
LEFT JOIN
RIGHT JOIN
```

---

## UNION ALL

`UNION ALL` stacks or appends result sets vertically.

It keeps duplicate rows.

```sql
SELECT *
FROM podcasts_originals
WHERE duration_min >= 60

UNION ALL

SELECT *
FROM podcasts_premium
WHERE duration_min >= 60;
```

Conceptually:

```text
Table A
-------
row 1
row 2

UNION ALL

Table B
-------
row 3
row 4

Result
-------
row 1
row 2
row 3
row 4
```

The SELECT statements should return compatible columns.

---

## UNION / UNION DISTINCT

`UNION` combines result sets vertically but removes duplicate rows.

```sql
SELECT *
FROM podcasts_originals
WHERE duration_min >= 60

UNION

SELECT *
FROM podcasts_premium
WHERE duration_min >= 60
ORDER BY duration_min DESC;
```

In systems that support the explicit syntax, this may also be written as:

```sql
UNION DISTINCT
```

### UNION vs UNION ALL

- `UNION ALL` → keeps duplicates
- `UNION` → removes duplicates

---

## INNER JOIN

`INNER JOIN` keeps only rows that match in both tables.

```sql
SELECT
    p.podcast_id,
    p.podcast_name,
    pu.tenure
FROM plays AS p
INNER JOIN paid_users AS pu
USING (user_id);
```

Conceptually:

```text
LEFT TABLE  ∩  RIGHT TABLE
```

Only matching records survive.

---

## LEFT JOIN

`LEFT JOIN` keeps:

- all rows from the left table
- matching rows from the right table
- NULL values when there is no match on the right

Example:

```sql
SELECT
    l.podcast_id,
    l.user_id,
    l.time_played,
    r.genre
FROM podcast_plays AS l
LEFT JOIN podcasts AS r
    ON l.podcast_id = r.podcast_id;
```

The table before `LEFT JOIN` is the left table.

---

## LEFT JOIN with Aggregation

A join can be followed by aggregation.

```sql
SELECT
    u.country,
    COUNT(*) AS play_count,
    COUNT(DISTINCT p.user_id) AS unique_user_count,
    COUNT(DISTINCT p.podcast_id) AS unique_podcast_count
FROM plays AS p
LEFT JOIN users AS u
    ON p.user_id = u.user_id
GROUP BY u.country;
```

This allows us to combine information from multiple tables and then calculate metrics.

---

## RIGHT JOIN

`RIGHT JOIN` keeps:

- all rows from the right table
- matching rows from the left table
- NULL values when there is no match on the left

Conceptually it is the opposite direction of a `LEFT JOIN`.

---

## ON

`ON` specifies how rows from two tables are matched.

```sql
SELECT *
FROM podcast_plays AS p
LEFT JOIN podcasts AS pd
    ON p.podcast_id = pd.podcast_id;
```

---

## USING

When the join column has the same name in both tables, `USING` can simplify the syntax.

```sql
SELECT
    p.podcast_id,
    p.podcast_name,
    pu.tenure
FROM plays AS p
INNER JOIN paid_users AS pu
USING (user_id);
```

Instead of:

```sql
ON p.user_id = pu.user_id
```

---

## Multi-Column Joins

Sometimes one column is not enough to uniquely define the relationship.

Multiple columns can be used:

```sql
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
```

Here the match depends on:

```text
host_id + genre
```

This can represent a composite key relationship.

---

## Joining Multiple Tables

More than two tables can be combined in one query.

```sql
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
```

The result combines information from:

1. `podcasts`
2. `host_genre_ranks`
3. `hosts`

---

## JOIN Summary

| Operation    | Result                              |
| ------------ | ----------------------------------- |
| `INNER JOIN` | Only matching rows                  |
| `LEFT JOIN`  | All left rows + matching right rows |
| `RIGHT JOIN` | All right rows + matching left rows |
| `UNION ALL`  | Stack rows and keep duplicates      |
| `UNION`      | Stack rows and remove duplicates    |

---

## Important Interview Concept

Before writing a JOIN, ask:

1. What is the left table?
2. What is the right table?
3. Which column or columns connect them?
4. Do I need only matching records or all records from one side?
5. Can the join create duplicate rows?
