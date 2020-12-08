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

//connects to database
con.connect(function(err){
    if (err) throw err;
    console.log("connected");
});

//Create a user and add to database
app.post('/user', function (req, res) {
    console.log("PoopyFacehole");
    console.log(req.body.hash);
    var sql = "CREATE TABLE " + req.body.hash + " (id int NOT NULL AUTO_INCREMENT, x VARCHAR(255), y VARCHAR(255), healthy VARCHAR(1), compromised VARCHAR(1), PRIMARY KEY (id))";
    var sql1 = "INSERT INTO users VALUES ('" + req.body.hash + "')";
    con.query(sql, function (err, result) {
        if(err) throw err;
        console.log("1 table created");
    });
    con.query(sql1, function (err, result) {
        if(err) throw err;
        console.log("1 record inserted");
    });
    res.status(201).send("user created")
});

//adds clients coordinates to database
app.put('/user', function (req, res) {
    console.log("PoopyButthole");
    console.log(req.body.hash);
    var sql = "INSERT INTO " + req.body.hash + " (x, y, healthy, compromised) VALUES ('" + req.body.x + "', '" + req.body.y + "', '" + req.body.healthy + "', '" + req.body.compromised + "')";
    con.query(sql, function (err, result) {
        if(err) throw err;
        console.log("data inserted");
    });
    res.status(201).send("data logged")
});

//get users last data entry
app.get('/user', function (req, res) {
    console.log("PoopyBungehole");
    console.log(req.body.hash);
    var sql = "SELECT * FROM " + req.body.hash + " WHERE id=(SELECT max(id) FROM " + req.body.hash + ")";
    con.query(sql, function (err, result) {
        if(err) throw err;
        console.log("data retrieved");
        if 
        res.status(200).send(result);
    });
});