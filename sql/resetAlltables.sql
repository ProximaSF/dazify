-- Reset tables
USE daze_random_sites_db;

-- Drop the junction table first (it references the other two tables)
DROP TABLE IF EXISTS url_categories;

-- Now drop the parent tables
DROP TABLE IF EXISTS urls;
DROP TABLE IF EXISTS categories;


-- Recreate the tables
CREATE TABLE IF NOT EXISTS urls (
    url_id INT PRIMARY KEY AUTO_INCREMENT,
    url VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS url_categories (
    url_id INT,
    category_id INT,
    PRIMARY KEY (url_id, category_id),
    FOREIGN KEY (url_id) REFERENCES urls(url_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
);