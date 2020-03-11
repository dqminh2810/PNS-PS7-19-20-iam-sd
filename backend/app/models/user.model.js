const Joi = require('joi');
const BaseModel = require('../utils/base-model.js');

module.exports = new BaseModel('User', {
  name: Joi.string().required(),
  type: Joi.string().valid('visitor', 'organizer').required(),
  email: Joi.string().required(),
  password: Joi.string().required(),
  location: Joi.object(),
});
