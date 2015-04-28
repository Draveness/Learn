var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/userlist', function(req, res) {
	var db = req.db;
	db.collection('userlist').find().toArray(function (err, items) {
		res.json(items);
	});
});

router.post('/adduser', function(req, res) {
	var db = req.db;
	db.collection('userlist').insert(req.body, function (err, result) {
		res.send(
			(err == null) ? { msg: '' } : { msg: err }
		);
	});
});

router.get('/deleteuser', function(req, res) {
	var db = req.db;
	var userToDelete = req.query.id;
	db.collection('userlist').removeById(userToDelete, function (err, result) {
		res.send((result === 1) ? { msg: '' } : { msg:'error: ' + err })
	})
})

module.exports = router;
