const Joi = require('joi');
const BaseModel = require('../utils/base-model.js');

module.exports = new BaseModel('Event', {
  name: Joi.string().required(),
  description: Joi.string().required(),
  category: Joi.string().valid('basketball', 'football', 'hoockey', 'swimming', 'golf', 'another').required(),
  location: Joi.object(),
});
