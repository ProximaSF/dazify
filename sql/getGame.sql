SELECT urls.url, categories.category_name
	from urls
join url_categories 
	on urls.url_id=url_categories.url_id
join categories
	on categories.category_id=url_categories.category_id
where categories.category_name = "Game";