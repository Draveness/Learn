var express = require('express');
var router = express.Router();
var crypto = require('crypto'),
	User = require('../models/user.js')

module.exports = function(app) {
	app.get('/', function(req, res) {
		res.render('index', { title: 'Home' });
	});
	app.get('/reg', function(req, res) {
		res.render('reg', { title: 'Register' });
	});
	app.post('/reg', function(req, res) {
		var name = req.body.name,
			password = req.body.password,
			password_re = req.body['password-repeat'];

		if (password_re != password) {
			req.flash('error', 'Different between inputs');
			return res.redirect('/reg');
		};

		var md5 = crypto.createHash('md5'),
			password = md5.update(req.body.password).digest('hex');
		var newUser = new User({
			name: name,
			password: password,
			email: req.body.email
		});

		User.get(newUser.name, function(err, user) {
			if (err) {
				req.flash('error', err);
				return res.redirect('/reg');
			}
			if (user) {
				req.flash('error', 'User already exists!');
				return res.redirect('/reg');
			};

			newUser.save(function(err, user) {
				if (err) {
					req.flash('error', err);
					return res.redirect('/reg');
				};
				res.session.user = user;
				req.flash('success', 'Register successful!');
				res.redirect('/');
			});
		});
	});
	app.get('/login', function(req, res) {
		res.render('login', { title: 'Login' });
	});
	app.post('/login', function(req, res) {
	});
	app.get('/post', function(req, res) {
		res.render('post', { title: 'Post' });
	});
	app.post('/post', function(req, res) {
	});
	app.post('/logout', function(req, res) {
	});
};
