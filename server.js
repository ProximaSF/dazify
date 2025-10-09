
const express = require('express')
const app = express()

app.set('view engine', 'ejs')
app.use(express.urlencoded({extended: false})) // allow the access of value in app.post() by user
app.use(express.static('public'))


const mysql = require('mysql2/promise')
require('dotenv').config()

let pool;

(async () => {
  try {
    pool = await mysql.createPool({
      host: process.env.MYSQL_HOST,
      user: process.env.MYSQL_USER,
      password: process.env.MYSQL_PASSWORD,
      database: process.env.MYSQL_DATABASE,
      connectionLimit: 10,
      queueLimit: 0
    });

    console.log('✅ MySQL connection pool created successfully');

    const PORT = 3000;
    app.listen(PORT, '0.0.0.0', () => {
      console.log(`🚀 Server running on port ${PORT}`);
    });
  } catch (error) {
    console.error('❌ Error creating database pool:', error);
  }
})();



app.get("/api/random", async (req, res) => { 
    const [row] = await pool.query('SELECT * FROM urls ORDER BY RAND() LIMIT 1')
    //console.log(row)
    if (row.length > 0) {
        res.json({url: row[0].url});
    } else {
        res.status(404).json({error: 'No sites found'});
    }
const PORT = 3000;

app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Server running on port ${PORT}`);
});

    
});

app.get('/api/random/:category', async (req, res) => {
    const category = req.params.category;
    try {
        const [rows] = await pool.query(
            `SELECT urls.url, categories.category_name
            FROM urls
            JOIN url_categories ON urls.url_id = url_categories.url_id
            JOIN categories ON categories.category_id = url_categories.category_id
            WHERE LOWER(categories.category_name) = LOWER(?)
            ORDER BY RAND()
            LIMIT 1`, [category]
        );
        if (rows.length > 0) {
            res.json({ url: rows[0].url });
        } else {
            res.status(404).json({ error: 'No game sites found' });
        }
    } catch (error) {
        console.error('Database query error:', error);
    }
});


app.get('/', (req, res) => { //default page (homepage)
    res.render('index.ejs')
})

app.get('/random', (req, res) => {
    res.render('random.ejs')
})

app.get('/suggest', (req, res) => {
    res.render('suggest.ejs')
})

app.get('/about', (req, res) => {
    res.render('about.ejs')
})


