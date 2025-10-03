
SELECT urls.url, categories.category_name, categories.category_id
FROM
    url_categories uc
JOIN
    urls ON uc.url_id = urls.url_id
JOIN
    categories ON uc.category_id = categories.category_id;

    
SELECT DISTINCT urls.url, categories.category_name, categories.category_id
FROM
    url_categories uc
JOIN
    urls ON uc.url_id = urls.url_id
JOIN
    categories ON uc.category_id = categories.category_id;