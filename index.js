// dotenv

// Path: index.js
// Add dotenv
require('dotenv').config({path:__dirname+'/.env.development'});

console.log('SECRET_TOKEN:', process.env.SECRET_TOKEN);
console.log('DATABASE_URI:', process.env.DATABASE_URI);
