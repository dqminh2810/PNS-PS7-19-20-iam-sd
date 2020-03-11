const { spawn } = require('child_process');
const { Router } = require('express');
const { User } = require('../../models');

const router = new Router();

function getByUserEmail(userEmail) {
  const users = User.get();
  const toReturn = [];
  for (let i = 0; i < users.length; i += 1) {
    if (users[i].email === userEmail && users[i]) {
      toReturn.push(users[i]);
      return toReturn;
    }
  }
}

function getByUserEmailAndPassword(userEmail, userPassword) {
  const users = User.get();
  const toReturn = [];
  for (let i = 0; i < users.length; i += 1) {
    if (users[i].email === userEmail && users[i].password === userPassword) {
      toReturn.push(users[i]);
      return toReturn;
    }
  }
}


router.get('/', (req, res) => res.status(200).json(User.get()));
router.get('/:email', (req, res) => {
  const user = getByUserEmail(req.params.email);
  try {
    if (user.length > 0) {
      res.status(200).json(user);
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
router.get('/:email/:password', (req, res) => {
  const user = getByUserEmailAndPassword(req.params.email, req.params.password);
  try {
    if (user.length > 0) {
      res.status(200).json(user);
    } else {
      res.status(400).send('Email and passsword not matched');
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
  const createUserData = req.body;
  const users = User.get();
  try {
    for (let i = 0; i < users.length; i += 1) {
      if (createUserData.email !== undefined && users[i].email === createUserData.email) {
        res.status(400).send('You have already an account with this email');
        return;
      }
    }
    const user = User.create(createUserData);
    res.status(200).json(user);
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
    const user = User.update(req.params.id, req.body);
    res.status(201).json(user);
  } catch (err) {
    if (err.name === 'ValidationError') {
      res.status(400).json(err.extra);
    } else {
      res.status(500).json(err);
    }
  }
});


module.exports = router;
