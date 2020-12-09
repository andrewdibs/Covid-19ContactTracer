var express = require('express'); // Web Framework
var app = express();
var mysql = require('mysql');// MS Sql Server client
var nodemailer = require('nodemailer');
const parser = require('body-parser');
const request = require('request');
const { json } = require('body-parser');

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

//connects to email address we are using to send users and administrators emails
var transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'capping.contact.tracer@gmail.com',
      pass: 'Omannamo!1'
    }
});

var mailOptions1 = {
    from: 'contact.tracing.capping@gmail.com',
    to: 'yafmail@gmail.com',
    subject: 'DATABASE INCONSISTENCY',
    text: 'something went wrong'
};

//Create a user and add to database
app.post('/user', function (req, res) {
    console.log("Creating user");
    console.log(req.body.hash);
    
    //sql commands to create a table for the user
    //might need to add hash column 
    let sql = "CREATE TABLE " + req.body.hash + " (id int NOT NULL AUTO_INCREMENT, hash VARCHAR(225), x VARCHAR(255), y VARCHAR(255), datetime DATETIME DEFAULT CURRENT_TIMESTAMP, compromised VARCHAR(1), PRIMARY KEY (id))";
    
    //sql commands to add user to user table
    let sql1 = "INSERT INTO users (hash, email) VALUES ('" + req.body.hash + "', '" + req.body.email + "')";

    //creates event to delete 2 week old data
    let sql2 = "CREATE EVENT expire" + req.body.hash + " ON SCHEDULE EVERY 24 HOUR DO DELETE FROM " + req.body.hash + " WHERE TIMESTAMPDIFF(DAY, " + req.body.hash + ".datetime, now()) > 14";
    
    //sending the sql commands to the database
    con.query(sql, function (err, result) {
        if(err) {
            console.log('an error occured')
            mailOptions1.text = String(err);
            transporter.sendMail(mailOptions1, function(error, info){
                if (error) {
                  console.log('email did not work');
                } else {
                  console.log('Email sent: ' + info.response);
                }
            });
        }
        console.log("1 table created");
    });
    con.query(sql1, function (err, result) {
        if(err) {
            mailOptions1.text = String(err);
            transporter.sendMail(mailOptions1, function(error, info){
                if (error) {
                  console.log(error);
                } else {
                  console.log('Email sent: ' + info.response);
                }
            });
            return;
        }
        console.log("1 record inserted");
    });
    con.query(sql2, function (err, result) {
        if(err) {
            mailOptions1.text = String(err);
            transporter.sendMail(mailOptions1, function(error, info){
                if (error) {
                  console.log(error);
                } else {
                  console.log('Email sent: ' + info.response);
                }
            });
        }
        console.log("daily deletion event created");
    });
    res.status(201).send("user created")
});

//adds userss coordinates to database
app.put('/user', function (req, res) {
    console.log("Adding Info");
    console.log(req.body.hash);
    
    var compromisedValue = 0;
    //sql commands to add users data to specific user table
    var sql = "INSERT INTO " + req.body.hash + " (hash, x, y, compromised) VALUES ('" + req.body.hash + "', '" + req.body.x + "', '" + req.body.y + "', '" + compromisedValue + "')";
    
    if (req.body.datetime) {
        sql = "INSERT INTO " + req.body.hash + " (hash, x, y, datetime, compromised) VALUES ('" + req.body.hash + "', '" + req.body.x + "', '" + req.body.y + "', '" + req.body.datetime + "', '" + compromisedValue + "')";
    }
    
    //sends sql commands to database
    con.query(sql, function (err, result) {
        if(err) {
            mailOptions1.text = String(err);
            transporter.sendMail(mailOptions1, function(error, info){
                if (error) {
                  console.log(error);
                } else {
                  console.log('Email sent: ' + info.response);
                }
            });
        }
        console.log("data inserted");
    });
    res.status(201).send("data logged")
});

//get users last data entry
app.get('/user/:hash', function (req, res) {
    console.log("Getting Info");
    console.log(req.params.hash);

    //email options to send to user who has covid
    let mailOptions = {
        from: 'contact.tracing.capping@gmail.com',
        to: 'placehoder@gmail.com',
        subject: 'COVID WARNING',
        text: 'You have been in contact with a person who has had covid within the last two weeks. \n https://www.cdc.gov/coronavirus/2019-ncov/if-you-are-sick/quarantine.html'
    };
    
    //sql query to get the specific users last entry
    let sql = "SELECT * FROM " + req.params.hash + " WHERE compromised = 1";

    //sql for deleting the compromised field if one was found
    let sql1 = "DELETE FROM " + req.params.hash + " WHERE compromised = 1";
    
    //sql for getting email of user
    let sql2 = "SELECT email FROM users WHERE hash = '" + req.params.hash + "'";

    //queries the database for compromised values
    con.query(sql, function (err, result) {
        if(err) {
            mailOptions1.text = String(err);
            transporter.sendMail(mailOptions1, function(error, info){
                if (error) {
                  console.log(error);
                } else {
                  console.log('Email sent: ' + info.response);
                }
            });
            res.status(400).send('user not found')
            return;
        }
        console.log("data retrieved");
        //if compromised value is found send 202 status to user and then delete compromised value
        if(result.length > 0){
            res.status(202).send("you're not chilln");
            con.query(sql1, function (err1, result1) {
                if(err1) {
                    mailOptions1.text = String(err1);
                    transporter.sendMail(mailOptions1, function(error, info){
                        if (error) {
                          console.log(error);
                        } else {
                          console.log('Email sent: ' + info.response);
                        }
                    });
                }
                console.log("data deleted");
            });
            con.query(sql2, function (err2, result2) {
                if(err2) {
                    mailOptions1.text = String(err2);
                    transporter.sendMail(mailOptions1, function(error, info){
                        if (error) {
                          console.log(error);
                        } else {
                          console.log('Email sent: ' + info.response);
                        }
                    });
                }
                let obj1 = result2[0].email
                console.log(obj1);
                mailOptions.to = obj1;
                transporter.sendMail(mailOptions, function(error, info){
                    if (error) {
                      console.log(error);
                    } else {
                      console.log('Email sent: ' + info.response);
                    }
                });
            });
        //if no value is found send 200 status
        } else {
            res.status(200).send("you're chilln")
        }
    });
});

//fowards patch information onto the the java backend via http request
app.patch('/user', function (req, res) {
    console.log("response");
    request({ 
        url: "http://backend:8080/user",
        method: "POST",
        headers: { "Content-Type": "application/json" },
        json: true,
        body: { "hash": req.body.hash},
        time: true
    }, function (err, res1, body) {
        if (!err && res1.statusCode == 200) {
            console.log("patch sent to backend")
            return;
        }
        console.log("patch failed to move to backend")
    });
    res.status(200).send("pushed to backend");
});
