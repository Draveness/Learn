exports.notFound = function(req, res) {
	res.status(404);
	res.json({
		error: 'not found',
		url: req.originalUrl
	});
}

exports.checkVersionAndContentType = function(req, res, next) {
	var version = "";
	if (req.headers["accpet"]) {
		version = req.headers["accpet"].split("-")[1].split("+")[0];
	}
	req.version = version;
	next();
}
