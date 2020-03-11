const { Router } = require('express');
const { Event } = require('../../models');

const router = new Router();

function getEventByLocation(latitude, longitude){
  const events = Event.get();
  const toReturn = [];
  for (let i = 0; i < events.length; i += 1) {
    console.log(events[i].location.latitude + ' - ' + events[i].location.longitude);
    if (events[i].location.latitude.toString() === latitude && events[i].location.longitude.toString() === longitude) {
      toReturn.push(events[i]);
      return toReturn;
    }
  }
}

router.get('/', (req, res) => res.status(200).json(Event.get()));
router.get('/:latitude/:longitude', (req, res) => {
  const event = getEventByLocation(req.params.latitude, req.params.longitude);
  try {
    if (event.length > 0) {
      res.status(200).json(event);
    } else {
      res.status(400).send('Error email');
    }
  } catch (err) {
    if (err.name === 'ValidationError') {
      res.status(400).json(err.extra);
    } else {
      res.status(500).json(err);
    }
  }
});
router.post('/', (req, res) => {
  const createEventData = req.body;
  const events = Event.get();
  try {
    for (let i = 0; i < events.length; i += 1) {
      if (createEventData.email !== undefined && events[i].location.latitude === createEventData.latitude && events[i].location.longitude === createEventData.longitude) {
        res.status(400).send('This event have already existed');
        return;
      }
    }
    const event = Event.create(createEventData);
    res.status(200).json(event);
  } catch (err) {
    if (err.name === 'ValidationError') {
      res.status(400).send(err.extra);
    } else {
      res.status(500).json(err);
    }
  }
});
router.put('/:id', (req, res) => {
  try {
    const event = Event.update(req.params.id, req.body);
    res.status(201).json(event);
  } catch (err) {
    if (err.name === 'ValidationError') {
      res.status(400).json(err.extra);
    } else {
      res.status(500).json(err);
    }
  }
});

module.exports = router;
