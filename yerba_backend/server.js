const express = require('express')
const app = express()
const path = require('path')
const bcrypt = require('bcrypt')
const bodyParser = require('body-parser')
const session = require('express-session')
const mailer = require('nodemailer')
const cors = require('cors')

var nodemailer = require('nodemailer');

var transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'yerbamateapp@gmail.com',
    pass: 'testingpassword123'
  }
});


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
app.use(express.static(path.join(__dirname, '../yerba_mate/build/web')))

app.use(cors(
    {
        origin: false
    }
))

module.exports = app


const users = [
    {
        "id": 1648999519692,
        "email": "hhwiu1079@gmail.com",
        "name": "Linus",
        "password": "$2b$10$6scq4K9W5BGzoLJvzAHA7OcjJyIV3L83WpM.CRugbwUz.fEnfu9ry",
        "profileData": {},
        "mock": true
    },
    {
        id: 1,
        name: "Jasmine Good",
        bio: "magna. Phasellus dolor elit, pellentesque",
        location: "Western Australia",
        age: 32,
        designation: "Proin",
        interests: ["tennis", "programming", "something"],
      },
      {
        id: 2,
        name: "Nita Stokes",
        bio: "ut, nulla. Cras eu tellus",
        location: "Chhattisgarh",
        age: 18,
        designation: "per",
        interests: ["tennis", "programming", "something"],
      },
      {
        id: 3,
        name: "Keefe Lyons",
        bio: "eu dolor egestas rhoncus. Proin",
        location: "São Paulo",
        age: 35,
        designation: "vulputate",
        interests: ["tennis", "programming", "something"],
      },
      {
        id: 4,
        name: "Ivory Sawyer",
        bio: "Ut sagittis lobortis mauris. Suspendisse",
        location: "Piemonte",
        age: 35,
        designation: "dolor",
        interests: ["tennis", "programming", "something"],
      },
      {
        id: 5,
        name: "Vance England",
        bio: "amet massa. Quisque porttitor eros",
        location: "Azad Kashmir",
        age: 28,
        designation: "pede,",
        interests: ["tennis", "programming", "something"],
      }
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
        const generatedID = parseInt(intDate.now()+(Math.random()*100)) 
        setMock = !req.body.mock ? false : req.body.mock
        // if(!req.body.mock) {
        //     setMock = false
        // } else { setMock = req.body.mock }
        const user = { id:  generatedID, email: req.body.email, name: req.body.name, password: hashedPass, profileData: {interests: req.body.profileData.interests}, mock: setMock }
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
        const user = users.find(user => user.email == req.body.email)
        // console.log(users)
        // console.log(req.body)
        if(user == null) {
            return res.status(400).send('No user found')
        }
        else {
            res.locals.email = user.email
            next()
        }
        try {
            if(await bcrypt.compare(req.body.password, user.password)){
                res.status(200).send({
                    "id": user.id,
                    "email": user.email,
                    "name": user.name,
                    "profileData": user.profileData,
                    "mock": user.mock
                })
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

app.get('/api/match/:fromID/:toID', (req, res) => {
    const curUser = users.find(user => user.id == req.params.fromID)
    const checkMatchUser = users.find(user => user.id = req.params.toID)

    interactedByUser = interactions.find(interaction => (curUser.id == interaction.p2 && checkMatchUser.id == interaction.p1))


    if(checkMatchUser.mock) {
        successfulMatch();
    }

    if(interactedByUser != null) {
        if(interactedByUser.interCategory == "liked") {
            interactions.push({
                "p1": curUser.id,
                "p2": checkMatchUser.id,
                "interCategory": "matched"
            })
            successfulMatch();
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
    };

    function successfulMatch()  {
            mailContent =  `You've matched with ${ checkMatchUser.name } on YerbaMate. Contact them via ${ checkMatchUser.email }. In case you don't know what to talk about, their interests are ${ checkMatchUser.profileData.interests }`

            var mailOptions = {
              from: 'yerbamateapp@gmail.com',
              to: curUser.email,
              subject: "You've matched with someone in YerbaMate!",
              text: mailContent
            };

            transporter.sendMail(mailOptions, function(error, info){
              if (error) {
                console.log(error);
              } else {
                console.log('Email sent: ' + info.response);
              }
            });
            res.status(200).send("Matched");
    }
        
    
})



const hostname = '127.0.0.1';
const port = 3000;

app.listen(port, hostname, () => {
    console.log(`Server running at http://${hostname}:${port}/`);
})
