use daze_random_sites_db;

insert ignore into urls (url) values
	("https://voicechanger.io/"), 
    ("https://maze.toys/mazes/medium/daily/"),
    ("https://2020game.io/"),
    ("https://paveldogreat.github.io/WebGL-Fluid-Simulation/");
    

insert ignore into categories (category_name) values
	("Game"),
    ("Simulation"),
    ("Art"),
    ("Puzzle");
    
    
-- Step 1: Get the ID for 'maze.toys' and store it in a variable.
SET @maze_id = (SELECT url_id FROM urls WHERE url = 'https://maze.toys/mazes/medium/daily/');
-- Step 2: Link 'maze.toys' to its categories using the variable.
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@maze_id, (SELECT category_id FROM categories WHERE category_name = 'Puzzle')),
    (@maze_id, (SELECT category_id FROM categories WHERE category_name = 'Game'));


-- 'voicechanger.io'
SET @voicechanger_id = (SELECT url_id FROM urls WHERE url = 'https://voicechanger.io/');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@voicechanger_id, (SELECT category_id FROM categories WHERE category_name = 'Simulation'));

-- '2020game.io'
SET @2020game_id = (SELECT url_id FROM urls WHERE url = 'https://2020game.io/');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@2020game_id, (SELECT category_id FROM categories WHERE category_name = 'Game'));


-- 'WebGL-Fluid-Simulation'
SET @webgl_fluid_id = (SELECT url_id FROM urls WHERE url = 'https://paveldogreat.github.io/WebGL-Fluid-Simulation/');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@webgl_fluid_id, (SELECT category_id FROM categories WHERE category_name = 'Simulation')),
    (@webgl_fluid_id, (SELECT category_id FROM categories WHERE category_name = 'Art'));
