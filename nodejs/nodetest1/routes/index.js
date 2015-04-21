var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('helloworld', { title: 'Hello, World!' });
});

router.get('/userlist', function(req, res, next) {
	var db = req.db;
	var collection = db.get('usercollection');
	collection.find({}, {}, function(err, data) {
		res.render('userlist', {
			"userlist": data
		});
	});
});

router.get('newuser', function(req, res) {
	res.render('newuser' { title: "Add new User!"});
});

module.exports = router;
