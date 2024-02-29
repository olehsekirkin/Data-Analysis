USE amazon_sales;

CREATE TABLE amazon_categories (
    id INT PRIMARY KEY,
    category_name VARCHAR(255)
);

CREATE TABLE amazon_products (
    asin VARCHAR(255) PRIMARY KEY,
    title TEXT,
    imgURL TEXT,
    productURL TEXT,
    stars FLOAT,
    reviews INT,
    price FLOAT,
    listPrice FLOAT,
    category_id INT,
    isBestSeller BOOLEAN,
    boughtInLastMonth INT,
    FOREIGN KEY (category_id) REFERENCES amazon_categories(id)
);

LOAD DATA LOCAL INFILE 'C:\\Users\\olehs\\Desktop\\data2\\amazon_categories.csv'
INTO TABLE amazon_categories
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:\\Users\\olehs\\Desktop\\data2\\amazon_products.csv'
INTO TABLE amazon_products
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- ####################################################################################################################### --

-- 1. Top 5 Categories with the Highest Number of Products

SELECT c.category_name, COUNT(p.asin) AS product_count
FROM amazon_categories c
JOIN amazon_products p ON c.id = p.category_id
GROUP BY c.category_name
ORDER BY product_count DESC
LIMIT 5;

-- 2. Categories with the Highest Average Product Ratings

SELECT c.category_name, ROUND(AVG(p.stars), 2) AS average_rating
FROM amazon_categories c
JOIN amazon_products p ON c.id = p.category_id
GROUP BY c.category_name
ORDER BY average_rating DESC;

-- 3. Average Price of Products Across Categories

SELECT c.category_name, ROUND(AVG(p.price), 2) AS average_price
FROM amazon_categories c
JOIN amazon_products p ON c.id = p.category_id
GROUP BY c.category_name
ORDER BY average_price;

-- 4. Percentage of Bestseller Products in Each Category

SELECT c.category_name, 
       AVG(CASE WHEN p.isBestSeller THEN 1 ELSE 0 END) * 100 AS percentage_bestsellers
FROM amazon_categories c
JOIN amazon_products p ON c.id = p.category_id
GROUP BY c.category_name;

-- 5. Categories with Most Growth in Sales Last Month

SELECT c.category_name, SUM(p.boughtInLastMonth) AS total_sales_last_month
FROM amazon_categories c
JOIN amazon_products p ON c.id = p.category_id
GROUP BY c.category_name
ORDER BY total_sales_last_month DESC;

-- 6. Top 10 Most Reviewed Products and Their Categories

SELECT p.title, c.category_name, p.reviews
FROM amazon_products p
JOIN amazon_categories c ON p.category_id = c.id
ORDER BY p.reviews DESC
LIMIT 10;

-- 7. Average Number of Reviews for Products with Ratings of 4 Stars and Above

SELECT ROUND(AVG(p.reviews), 2) AS average_reviews
FROM amazon_products p
WHERE p.stars >= 4;

-- 8. Number of Products with a Price Discount and Highest Average Discount by Category

SELECT c.category_name, 
       COUNT(p.asin) AS discount_product_count, 
       AVG(p.listPrice - p.price) AS average_discount
FROM amazon_categories c
JOIN amazon_products p ON c.id = p.category_id
WHERE p.listPrice > p.price
GROUP BY c.category_name
ORDER BY average_discount DESC;

-- 9. Correlation Between Product Ratings and Number of Products Bought Last Month

-- A simplified version to calculate the Pearson correlation coefficient

WITH stats AS (
  SELECT
    AVG(p.stars) AS avg_stars,
    AVG(p.boughtInLastMonth) AS avg_sales,
    STDDEV_POP(p.stars) AS stddev_stars,
    STDDEV_POP(p.boughtInLastMonth) AS stddev_sales
  FROM amazon_products p
),
covariance AS (
  SELECT
    (AVG((p.stars - stats.avg_stars) * (p.boughtInLastMonth - stats.avg_sales))) AS cov_stars_sales
  FROM amazon_products p, stats
)
SELECT
  (cov_stars_sales / (stddev_stars * stddev_sales)) AS correlation_coefficient
FROM covariance, stats;


-- 10. Which category has the highest variance in product ratings, and what is
--  the range of ratings within it?

SELECT c.category_name,
       VAR_POP(p.stars) AS rating_variance,
       MAX(p.stars) - MIN(p.stars) AS rating_range
FROM amazon_categories c
JOIN amazon_products p ON c.id = p.category_id
GROUP BY c.category_name
ORDER BY rating_variance DESC
LIMIT 1;

-- 11. Identify the category with the highest ratio of reviewed products to total 
-- products and calculate the average number of reviews for those products.

SELECT c.category_name,
       -- Calculate the ratio of products with reviews to total products
       CAST(SUM(CASE WHEN p.reviews > 0 THEN 1 ELSE 0 END) AS DECIMAL) / NULLIF(CAST(COUNT(p.asin) AS DECIMAL), 0) * 100 AS percentage_reviewed_products,
       -- Calculate average number of reviews for products that have been reviewed
       AVG(CASE WHEN p.reviews > 0 THEN p.reviews ELSE NULL END) AS avg_reviews
FROM amazon_categories c
JOIN amazon_products p ON c.id = p.category_id
GROUP BY c.category_name
ORDER BY percentage_reviewed_products DESC
LIMIT 1;

-- 12. Calculate the Weighted Average Rating of Products in Each Category
--  Based on Number of Reviews

SELECT c.category_name,
       ROUND(SUM(p.stars * p.reviews) / SUM(p.reviews), 3) AS weighted_avg_rating
FROM amazon_products p
JOIN amazon_categories c ON p.category_id = c.id
GROUP BY c.category_name
HAVING SUM(p.reviews) > 0
ORDER BY weighted_avg_rating DESC;

-- 13 Analysis of Price Variability and Sales Performance

SELECT c.category_name,
       AVG(p.listPrice - p.price) AS average_discount,
       SUM(p.boughtInLastMonth) AS total_sales,
       AVG(p.boughtInLastMonth) AS average_sales_per_product
FROM amazon_products p
JOIN amazon_categories c ON p.category_id = c.id
GROUP BY c.category_name
ORDER BY average_discount DESC, total_sales DESC;
