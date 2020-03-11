const { Router } = require('express');
const EventRouter = require('./events');
const UserRouter = require('./users');
const PredictionRouter = require('./prediction');

const router = new Router();
router.get('/status', (req, res) => res.status(200).json('ok'));
router.use('/events', EventRouter);
router.use('/users', UserRouter);
router.use('/prediction', PredictionRouter);

module.exports = router;
