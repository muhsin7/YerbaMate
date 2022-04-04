const express = require('express')
const app = express()
const path = require('path')
const bcrypt = require('bcrypt')
const bodyParser = require('body-parser')
const session = require('express-session')
const mailer = require('nodemailer')
const cors = require('cors')

var nodemailer = require('nodemailer');

// var transporter = nodemailer.createTransport({
//   service: 'gmail',
//   auth: {
//     user: 'yerbamateapp@gmail.com',
//     pass: 'testingpassword123'
//   }
// });

// var mailOptions = {
//   from: 'youremail@gmail.com',
//   to: 'hhwiu1079@gmail.com',
//   subject: 'Sending Email using Node.js',
//   text: 'That was easy!'
// };

// transporter.sendMail(mailOptions, function(error, info){
//   if (error) {
//     console.log(error);
//   } else {
//     console.log('Email sent: ' + info.response);
//   }
// });

app.use(express.json())
app.use(bodyParser.json({extended: true}))
app.use(session(
    {
        resave: false,
        secret: "secret?",
        name: 'uniqueSessionID',
        saveUninitialized: false
    }
))
app.use(express.static(path.join(__dirname, 'flutter_build')))
// app.use(express.static(path.join(__dirname, 'ublic')))

app.use(cors(
    {
        origin: false
    }
))

module.exports = app
// app.use(cors(
//     {
//         credentials: true,
//         origin: true
//     }
// ))
// app.use((req, res, next) => {
//     res.append('Access-Control-Allow-Origin', '*');
//     res.append('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
//     res.append('Access-Control-Allow-Headers', 'Content-Type');
//     next();
// });


const users = [
    {
        "id": 1648999519692.8813,
        "email": "hhwiu1079@gmail.com",
        "name": "Linus",
        "password": "$2b$10$6scq4K9W5BGzoLJvzAHA7OcjJyIV3L83WpM.CRugbwUz.fEnfu9ry",
        "profileData": {},
        "mock": true
    },
]

const interactions = [
    {
        "p1": "123",
        "p2": "456",
        "interCategory": "like"
    },
]


app.get('/api', (req, res) => {
    // res.append('Access-Control-Allow-Origin', '*');
    // res.append('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
    // res.append('Access-Control-Allow-Headers', 'Content-Type');
    res.json(users)
})

app.post('/api/register', async (req, res) => {
    try {
        // const salt = await bcrypt.genSalt()
        const hashedPass = await bcrypt.hash(req.body.password, 10)
        const generatedID = Date.now()+(Math.random()*100)
        setMock = !req.body.mock ? false : req.body.mock
        // if(!req.body.mock) {
        //     setMock = false
        // } else { setMock = req.body.mock }
        const user = { id:  generatedID, email: req.body.email, name: req.body.name, password: hashedPass, profileData: {interests: []}, mock: setMock }
        users.push(user)
        res.status(201).send()
    } catch {
        res.status(500).send()
    }
})


app.post('/api/login',
    bodyParser.urlencoded( {extended: false} ),
    async (req, res, next) => {
        // res.append('Access-Control-Allow-Origin', '*');
        // res.append('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
        // res.append('Access-Control-Allow-Headers', 'Content-Type');
        const user = users.find(user => user.name == req.body.name)
        // console.log(users)
        // console.log(req.body)
        if(user == null) {
            return res.status(400).send('No user found')
        }
        else {
            res.locals.name = user.name
            next()
        }
        try {
            if(await bcrypt.compare(req.body.password, user.password)){
                res.send('Success')
            } else {
                res.status(401).send("Not allowed")
            }
        } catch {
            res.status(200).send()
        }
    },
    (req, res) => {
        req.session.loggedIn = true
        req.session.name = res.locals.name
        console.log(req.session)
        res.redirect('/profile')
    }
)

app.get('/api/profile', (req, res) => {
    if(req.session.loggedIn){
        const user = users.find(user => user.name == req.session.name)
        // var json = JSON.parse(user)
        res.status(200).send(user.profileData)
        // console.log(res)
    } else {
        res.redirect('/login')
    }
})


app.patch('/api/profile/update', (req, res) => {
    const user = users.find(user => user.name == req.session.name)
    console.log(req.body.newList)
    user.profileData.interests = req.body.newList
    res.status(200)
    res.redirect('/profile')
})

app.get('/api/match/:id', (req, res) => {
    const curUser = users.find(user => user.name == req.session.name)
    const checkMatchUser = users.find(user => user.id = req.params.id)

    interactedByUser = interactions.find(interaction => (curUser.id == interaction.p2 && checkMatchUser.id == interaction.p1))

    if(!interactedByUser) {
        if(interactedByUser.interCategory == "liked") {
            interactions.push({
                "p1": curUser.id,
                "p2": checkMatchUser.id,
                "interCategory": "matched"
            })
        }
        else if (interactedByUser.interCategory == "disliked") {
            // action to perform if unliked
        }
        else if (interactedByUser.interCategory == "matched") {
            res.send("already matched")
        }
        else {
            res.status(400).send("invalid interaction")
        }
    }
        
    
})



const hostname = '127.0.0.1';
const port = 3000;

app.listen(port, hostname, () => {
    console.log(`Server running at http://${hostname}:${port}/`);
})
