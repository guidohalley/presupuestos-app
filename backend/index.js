require('dotenv').config();
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const routes = require('./routes');
const { sequelize } = require('./config/database');

const app = express();

app.use(cors());
app.use(bodyParser.json());
app.use('/api', routes);

sequelize.sync().then(() => {
  app.listen(3000, () => {
    console.log('Server is running on port 3000');
  });
}).catch(err => {
  console.error('Unable to connect to the database:', err);
});
