var express = require('express'); // Web Framework
var app = express();
var mysql = require('mysql');// MS Sql Server client

parser = require("body-parser");

const request = require("request");

app.use(parser.urlencoded({ extended: true }));

app.use(parser.json());

//database info and credentials
var con = mysql.createConnection({
    host: "db",
    user: "root",
    password: "FairView112",
    database: "db"
});

// Start server and listen on http://localhost:8080/
var server = app.listen(8000, function () {
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
    
    //sql commands to create a table for the user
    //might need to add hash column 
    var sql = "CREATE TABLE " + req.body.hash + " (id int NOT NULL AUTO_INCREMENT, x VARCHAR(255), y VARCHAR(255), datetime DATETIME DEFAULT CURRENT_TIMESTAMP, compromised VARCHAR(1), PRIMARY KEY (id))";
    
    //sql commands to add user to user table
    var sql1 = "INSERT INTO users (hash, email, username, password) VALUES ('" + req.body.hash + "' , '" + req.body.email + "' , '" + req.body.username + "' , '" + req.body.password + "')";
    //^^ this statement is goiong to be
    //var sql1 = "INSERT INTO users (hash, email, username, password) VALUES ('" + req.body.hash + "' , '" + 
    // req.body.email + "' , '" + req.body.username + "' , '" + req.body.password + "')";
    // Need to encrypt email, username, password (can be done on front-end or API)
    
    //sending the sql commands to the database
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

//adds userss coordinates to database
app.put('/user', function (req, res) {
    console.log("PoopyButthole");
    console.log(req.body.hash);
    
    //sql commands to add users data to specific user table
    // JOSH CHANGED req.body.healthy to req.body.datetime
    var sql = "INSERT INTO " + req.body.hash + " (x, y, compromised) VALUES ('" + req.body.x + "', '" + req.body.y + "', '" + req.body.compromised + "')";
    
    if (req.body.datetime) {
        sql = "INSERT INTO " + req.body.hash + " (x, y, datetime, compromised) VALUES ('" + req.body.x + "', '" + req.body.y + "', '" + req.body.datetime + "', '" + req.body.compromised + "')";
    }
    
    //sends sql commands to database
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
    
    //sql query to get the specific users last entry
    var sql = "SELECT * FROM " + req.body.hash + " WHERE id=(SELECT max(id) FROM " + req.body.hash + ")";
    
    //queries the database
    con.query(sql, function (err, result) {
        if(err) throw err;
        console.log("data retrieved");
        res.status(200).send(result);
    });
});

app.patch('/user', function (req, res) {
    console.log("PoopypantsMagee");
    console.log(req.body.hash);
    request({ 
        url: "http://backend:8080/user",
        method: "POST",
        headers: { "Content-Type": "application/json" },
        json: true,
        body: { "hash": req.body.hash},
        time: true
    }, function (err, res, body) {
        if (!err && res.statusCode == 200) {
        // success
        }
        // failed
    });
    res.status(200).send("success");
});