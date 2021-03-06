express = require('express')
app = express()
bodyParser = require('body-parser')
routes = require('./routes')

if(process.env.NODE_ENV is 'production')
  app.use( require('express-force-domain')('http://www.unsakini.com') )

app.set('view engine', 'ejs')
app.set('views', "#{__dirname}/app/views")
app.use(express.static('./public'))
if(process.env.NODE_ENV isnt 'production')
  app.disable('view cache')

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(require('./app/middlewares/jwt'))
models = require('./app/models')

routes(app)

port = process.env.PORT || 3000
app.listen port, ->
  console.log "Express running on port #{port}"