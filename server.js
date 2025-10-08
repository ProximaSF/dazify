
const express = require('express')
const app = express()

app.set('view engin', 'ejs')
app.use(express.urlencoded({extended: false})) // allow the access of value in app.post() by user
app.use(express.static('public'))


const mysql = require('mysql2/promise')
require('dotenv').config()


try {
    pool = mysql.createPool({
        host: process.env.MYSQL_HOST,
        user: process.env.MYSQL_USER,
        password: process.env.MYSQL_PASSWORD,
        database: process.env.MYSQL_DATABASE,
        connectionLimit: 10,
        queueLimit: 0
    })
} catch (error) {
    console.log('Error creating database', error)
}

app.get("/api/random", async (req, res) => { 
    const [row] = await pool.query('SELECT * FROM urls ORDER BY RAND() LIMIT 1')
    //console.log(row)
    if (row.length > 0) {
        res.json({url: row[0].url});
    } else {
        res.status(404).json({error: 'No sites found'});
    }
    
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

const PORT = 3000
app.listen(PORT, '127.0.0.1', () => { // Ensure only the hhttp domain work not the public IP one also
})

