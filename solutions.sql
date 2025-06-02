-- 1
SELECT
	authors.au_id AS "Author ID", authors.au_lname AS "Last name", authors.au_fname AS "First name",
	titles.title AS "Title",
	publishers.pub_name AS "Publisher"
	
FROM
	authors, titles, publishers, titleauthor
	
WHERE
	authors.au_id == titleauthor.au_id AND
	titleauthor.title_id == titles.title_id AND
	titles.pub_id == publishers.pub_id
    
-- 2	
SELECT 
    a.au_id AS AUTHOR_ID,
    a.au_lname AS LAST_NAME,
    a.au_fname AS FIRST_NAME,
    p.pub_name AS PUBLISHER,
    COUNT(ta.title_id) AS TITLE_COUNT
FROM titleauthor ta
JOIN authors a ON ta.au_id = a.au_id
JOIN titles t ON ta.title_id = t.title_id
JOIN publishers p ON t.pub_id = p.pub_id
GROUP BY a.au_id, a.au_lname, a.au_fname, p.pub_name
ORDER BY a.au_lname, a.au_fname, p.pub_name;

-- Who are the top 3 authors who have sold the highest number of titles? Write a query to find out.

SELECT 
    a.au_id AS AUTHOR_ID,
    a.au_lname AS LAST_NAME,
    a.au_fname AS FIRST_NAME,
    COUNT(ta.title_id) AS TITLES_SOLD
FROM titleauthor ta
JOIN authors a ON ta.au_id = a.au_id
GROUP BY a.au_id, a.au_lname, a.au_fname
ORDER BY TITLES_SOLD DESC
LIMIT 3;

-- Now modify your solution in Challenge 3 so that the output will display all 23 authors instead of the top 3. Note that the authors who have sold 0 titles should also appear in your output (ideally display `0` instead of `NULL` as the `TOTAL`). Also order your results based on `TOTAL` from high to low.

SELECT 
    a.au_id AS AUTHOR_ID,
    a.au_lname AS LAST_NAME,
    a.au_fname AS FIRST_NAME,
    COUNT(ta.title_id) AS TOTAL
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
GROUP BY a.au_id, a.au_lname, a.au_fname
ORDER BY TOTAL DESC;
