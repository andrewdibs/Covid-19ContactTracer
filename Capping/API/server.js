var express = require('express'); // Web Framework
var app = express();
var mysql = require('mysql');// MS Sql Server client

parser = require("body-parser");

app.use(parser.urlencoded({ extended: true }));

app.use(parser.json());

var con = mysql.createConnection({
    host: "db",
    user: "root",
    password: "FairView112",
    database: "db"
});
// Start server and listen on http://localhost:8080/
var server = app.listen(8080, function () {
    var host = server.address().address
    var port = server.address().port
    
    console.log("app listening at http://%s:%s", host, port)
});
//Get some database values
app.post('/user', function (req, res) {
    console.log("PoopyFacehole");
    console.log(req.body.time);
    con.connect(function(err){
        if (err) throw err;
        console.log("connected");
        var sql = "CREATE TABLE customer (name VARCHAR(255), address VARCHAR(255))";
        con.query(sql, function (err, result) {
            if(err) throw err;
            console.log("1 record inserted");
        });
    });
    res.status(201).send("user inserted")
});