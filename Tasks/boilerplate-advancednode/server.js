'use strict';
require('dotenv').config();
const express = require('express');
const session = require('express-session');
const passport = require('passport');
const myDB = require('./connection');
const fccTesting = require('./freeCodeCamp/fcctesting.js');
const { ObjectId } = require('mongodb');

const app = express();

// Middleware setup
fccTesting(app); // For FCC testing purposes
app.use('/public', express.static(process.cwd() + '/public'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Session setup
app.use(session({
  secret: process.env.SESSION_SECRET, // Ensure this exists in .env
  resave: true,
  saveUninitialized: true,
  cookie: { secure: false }
}));

// Passport setup
app.use(passport.initialize());
app.use(passport.session());

// View engine setup
app.set('view engine', 'pug');
app.set('views', './views/pug');

// Database connection
myDB(async client => {
  const myDataBase = await client.db('database').collection('users');

  // Routes
  app.route('/').get((req, res) => {
    res.render('index', {
      title: 'Connected to Database',
      message: 'Please log in'
    });
  });

  // Passport config
  passport.serializeUser((user, done) => {
    done(null, user._id);
  });

  passport.deserializeUser((id, done) => {
    myDataBase.findOne({ _id: new ObjectId(id) }, (err, doc) => {
      done(null, doc);
    });
  });

}).catch(e => {
  console.error(e);
  app.route('/').get((req, res) => {
    res.render('index', {
      title: 'Unable to connect to database',
      message: e.message
    });
  });
});

// Server listen
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Listening on port ${PORT}`);
});
