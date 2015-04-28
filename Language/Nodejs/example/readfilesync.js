var fs = require('fs');
var data = fs.readfileSync('file.txt', 'utf-8');
console.log(data);
console.log('end.');
