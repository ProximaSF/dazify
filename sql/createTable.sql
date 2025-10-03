/* many-to-many relationship between urls and categories */

use daze_random_sites_db;

create TABLE if not exists urls (
    url_id INT primary key auto_increment,
    url VARCHAR(255) NOT NULL unique
);

create TABLE if not exists categories (
    category_id INT primary key auto_increment,
    category_name  VARCHAR(20) NOT NULL unique
);

CREATE TABLE if not exists url_categories (
    url_id INT, /* hold the unique url_id */
    category_id INT, /* hold the unique category_id */
    PRIMARY KEY (url_id, category_id),
    FOREIGN KEY (url_id) REFERENCES urls(url_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);