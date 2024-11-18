const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(express.json());

app.use(cors());

// Database connection
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'conpaso'
});

// API endpoint to insert review
app.post('/submit-review', (req, res) => {
    const { paperId, reviewerId, score } = req.body;

    const query = `
        INSERT INTO Review (Paper_ID, Reviewer_ID, Score) 
        VALUES (?, ?, ?)
    `;
    db.query(query, [paperId, reviewerId, score], (err, result) => {
        if (err) {
            console.error('Error inserting review:', err);
            return res.status(500).json({ error: 'Failed to submit review' });
        }

        res.status(200).json({ message: 'Review submitted successfully' });
    });
});

app.get('/paper/:paperId',(req,res)=>{
    const paperId = req.params.paperId;

    const query = `
        SELECT * FROM Paper WHERE Paper_ID = ?
    `;

    db.query(query, [paperId], (err, result) => {
        if (err) {
            console.error('Error fetching paper:', err);
            return res.status(500).json({ error: 'Failed to fetch paper details' });
        }

        res.status(200).json(result[0]);
    });
})

// Start the server
app.listen(3001, () => {
    console.log('Server running on port 3001');
});
