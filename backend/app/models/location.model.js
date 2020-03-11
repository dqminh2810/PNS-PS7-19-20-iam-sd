const Joi = require('joi');
const BaseModel = require('../utils/base-model.js');

module.exports = new BaseModel('Location', {
  latitude: Joi.number().required(),
  longitude: Joi.number().required(),
});
