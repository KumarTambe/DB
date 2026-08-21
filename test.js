import db from './db.js'

const result = await pool.query('SELECT NOW()')
console.log('Connected! Time from DB:', result.rows[0])