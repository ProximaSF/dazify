use daze_random_sites_db;

insert ignore into urls (url) values
  ('https://voicechanger.io/'),
  ('https://maze.toys/mazes/medium/daily/'),
  ('https://2020game.io/'),
  ('https://paveldogreat.github.io/WebGL-Fluid-Simulation/'),
  ('https://findtheinvisiblecow.com/'),
  ('https://longdogechallenge.com/'),
  ('https://alwaysjudgeabookbyitscover.com/'),
  ('https://hackertyper.com/'),
  ('https://pointerpointer.com/'),
  ('https://www.nytimes.com/games/wordle/index.html'),
  ('http://radio.garden/'),
  ('https://flappy-2048.com/'),
  ('https://www.worldsdumbestgame.com/'),
  ('https://www.anothersadtrombone.com/'),
  ('https://www.polkadotgame.com/'),
  ('https://www.faceguesser.com/');
    

insert ignore into categories (category_name) values
	("Game"),
    ("Simulation"),
    ("Art"),
    ("Puzzle"),
    ("Dumb Fun"),
    ('Reading'),
    ('Educational'),
    ('Sound');
    
    
-- Step 1: Get the ID for 'maze.toys' and store it in a variable.
SET @maze_id = (SELECT url_id FROM urls WHERE url = 'https://maze.toys/mazes/medium/daily/');
-- Step 2: Link 'maze.toys' to its categories using the variable.
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@maze_id, (SELECT category_id FROM categories WHERE category_name = 'Puzzle')),
    (@maze_id, (SELECT category_id FROM categories WHERE category_name = 'Game'));


-- 'voicechanger.io'
SET @voicechanger_id = (SELECT url_id FROM urls WHERE url = 'https://voicechanger.io/');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@voicechanger_id, (SELECT category_id FROM categories WHERE category_name = 'Simulation')),
    (@voicechanger_id, (SELECT category_id FROM categories WHERE category_name = 'Sound'));

-- '2020game.io'
SET @2020game_id = (SELECT url_id FROM urls WHERE url = 'https://2020game.io/');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@2020game_id, (SELECT category_id FROM categories WHERE category_name = 'Game'));


-- 'WebGL-Fluid-Simulation'
SET @webgl_fluid_id = (SELECT url_id FROM urls WHERE url = 'https://paveldogreat.github.io/WebGL-Fluid-Simulation/');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@webgl_fluid_id, (SELECT category_id FROM categories WHERE category_name = 'Simulation')),
    (@webgl_fluid_id, (SELECT category_id FROM categories WHERE category_name = 'Art'));

-- 'findtheinvisiblecow.com'
SET @invisible_cow_id = (SELECT url_id FROM urls WHERE url = 'https://findtheinvisiblecow.com/');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@invisible_cow_id, (SELECT category_id FROM categories WHERE category_name = 'Game')),
    (@invisible_cow_id, (SELECT category_id FROM categories WHERE category_name = 'Puzzle')),
    (@invisible_cow_id, (SELECT category_id FROM categories WHERE category_name = 'Dumb Fun')),
    (@invisible_cow_id, (SELECT category_id FROM categories WHERE category_name = 'Sound'));

-- 'https://longdogechallenge.com/'
SET @longdoge_id = (SELECT url_id FROM urls WHERE url = 'https://longdogechallenge.com/');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@longdoge_id, (SELECT category_id FROM categories WHERE category_name = 'Game')),
    (@longdoge_id, (SELECT category_id FROM categories WHERE category_name = 'Dumb Fun'));


-- 'https://alwaysjudgeabookbyitscover.com/'
SET @judgebook_id = (SELECT url_id FROM urls WHERE url = 'https://alwaysjudgeabookbyitscover.com/');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@judgebook_id, (SELECT category_id FROM categories WHERE category_name = 'Dumb Fun')),
    (@judgebook_id, (SELECT category_id FROM categories WHERE category_name = 'Art')),
    (@judgebook_id, (SELECT category_id FROM categories WHERE category_name = 'Reading'));

-- 'https://hackertyper.com/'
SET @hackertyper_id = (SELECT url_id FROM urls WHERE url = 'https://hackertyper.com/');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES      
    (@hackertyper_id, (SELECT category_id FROM categories WHERE category_name = 'Educational')),
    (@hackertyper_id, (SELECT category_id FROM categories WHERE category_name = 'Simulation'));

-- 'https://pointerpointer.com/'
SET @pointerpointer_id = (SELECT url_id FROM urls WHERE url = 'https://pointerpointer.com/');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@pointerpointer_id, (SELECT category_id FROM categories WHERE category_name = 'Dumb Fun')),
    (@pointerpointer_id, (SELECT category_id FROM categories WHERE category_name = 'Art'));

-- 'https://www.nytimes.com/games/wordle/index.html'
SET @wordle_id = (SELECT url_id FROM urls WHERE url = 'https://www.nytimes.com/games/wordle/index.html');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@wordle_id, (SELECT category_id FROM categories WHERE category_name = 'Game')),
    (@wordle_id, (SELECT category_id FROM categories WHERE category_name = 'Puzzle')),
    (@wordle_id, (SELECT category_id FROM categories WHERE category_name = 'Educational'));

-- 'https://www.nytimes.com/games/wordle/index.html'
SET @radio_garden_id = (SELECT url_id FROM urls WHERE url = 'http://radio.garden/');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@radio_garden_id, (SELECT category_id FROM categories WHERE category_name = 'Dumb Fun')),
    (@radio_garden_id, (SELECT category_id FROM categories WHERE category_name = 'Educational')),
    (@radio_garden_id, (SELECT category_id FROM categories WHERE category_name = 'Puzzle'));

-- 'https://flappy-2048.com/'
SET @flappy2048_id = (SELECT url_id FROM urls WHERE url = 'https://flappy-2048.com/');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@flappy2048_id, (SELECT category_id FROM categories WHERE category_name = 'Game')),
    (@flappy2048_id, (SELECT category_id FROM categories WHERE category_name = 'Dumb Fun'));

-- 'https://www.worldsdumbestgame.com/'
SET @worldsdumbestgame_id = (SELECT url_id FROM urls WHERE url = 'https://www.worldsdumbestgame.com/');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@worldsdumbestgame_id, (SELECT category_id FROM categories WHERE category_name = 'Dumb Fun'));

-- 'https://www.polkadotgame.com/'
SET @polkadotgame_id = (SELECT url_id FROM urls WHERE url = 'https://www.polkadotgame.com/');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@polkadotgame_id, (SELECT category_id FROM categories WHERE category_name = 'Game'));

-- 'https://www.anothersadtrombone.com/'
SET @anothersadtrombone_id = (SELECT url_id FROM urls WHERE url = 'https://www.anothersadtrombone.com/');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES
    (@anothersadtrombone_id, (SELECT category_id FROM categories WHERE category_name = 'Dumb Fun'));

-- 'https://www.faceguesser.com/'
SET @faceguesser_id = (SELECT url_id FROM urls WHERE url = 'https://www.faceguesser.com/');
INSERT IGNORE INTO url_categories (url_id, category_id) VALUES  
    (@faceguesser_id, (SELECT category_id FROM categories WHERE category_name = 'Game')),
    (@faceguesser_id, (SELECT category_id FROM categories WHERE category_name = 'Puzzle')),
    (@faceguesser_id, (SELECT category_id FROM categories WHERE category_name = 'Educational'));

    