var express = require('express'); // Web Framework
var app = express();
var mysql = require('mysql');// MS Sql Server client


const parser = require("body-parser");

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
    console.log("Creating user");
    console.log(req.body.hash);
    
    //sql commands to create a table for the user
    //might need to add hash column 
    var sql = "CREATE TABLE " + req.body.hash + " (id int NOT NULL AUTO_INCREMENT, hash VARCHAR(225), x VARCHAR(255), y VARCHAR(255), datetime DATETIME DEFAULT CURRENT_TIMESTAMP, compromised VARCHAR(1), PRIMARY KEY (id))";
    
    //sql commands to add user to user table
    var sql1 = "INSERT INTO users (hash) VALUES ('" + req.body.hash + "')";
    
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
    console.log("Adding Info");
    console.log(req.body.hash);
    
    var compromisedValue = 0;
    //sql commands to add users data to specific user table
    // JOSH CHANGED req.body.healthy to req.body.datetime
    var sql = "INSERT INTO " + req.body.hash + " (hash, x, y, compromised) VALUES ('" + req.body.hash + "', '" + req.body.x + "', '" + req.body.y + "', '" + compromisedValue + "')";
    
    if (req.body.datetime) {
        sql = "INSERT INTO " + req.body.hash + " (hash, x, y, datetime, compromised) VALUES ('" + req.body.hash + "', '" + req.body.x + "', '" + req.body.y + "', '" + req.body.datetime + "', '" + compromisedValue + "')";
    }
    
    //sends sql commands to database
    con.query(sql, function (err, result) {
        if(err) throw err;
        console.log("data inserted");
    });
    res.status(201).send("data logged")
});

//get users last data entry
app.get('/user/:hash', function (req, res) {
    console.log("Getting Info");
    console.log(req.params.hash);
    
    //sql query to get the specific users last entry
    var sql = "SELECT compromised FROM " + req.params.hash + " WHERE id=(SELECT max(id) FROM " + req.params.hash + ")";
    
    //queries the database
    con.query(sql, function (err, result) {
        if(err) throw err;
        console.log("data retrieved");
        let myVar = JSON.stringify(result);
        if(myVar[17] == "1"){
            res.status(202).send("you're not chilln")
        } else {
            res.status(200).send("you're chilln")
        }
    });
});

app.patch('/user', function (req, res) {
    console.log("Finding Infected users");
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