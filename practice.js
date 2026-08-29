import db from './db.js'

await db.query(`
    CREATE TABLE users(
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        email VARCHAR(150) UNIQUE NOT NULL
    )    
`)

await db.query(`
    INSERT INTO users(name,email) VALUES('Kumar','kumar@vjti.com')
`)

const result = await db.query(`SELECT * FROM users`)
console.log(result.rows)

await db.query(`DROP TABLE users`)