const { spawn, spawnSync, execSync } = require('child_process');
const { Router } = require('express');

const router = new Router();

function callPython(req, res) {
  const pyFunc = spawnSync('python', ['./prediction_py/prediction2.py',
    req.query.indexRow,
    req.query.indexColumn,
  ]);
  const dataToSend = pyFunc.stdout.toString();
  console.log(dataToSend);
  /*
  // This is result render for spawn
  pyFunc.stdout.on('data', (data) => {
    //dataToSend = data.toString();
    console.log(data.toString());
  });
  pyFunc.stderr.on('data', (data) => {
    //dataToSend = data.toString();
    console.log(data.toString());
  });
  */
  return dataToSend;
}

router.get('/', (req, res) => {
  try {
    const data = callPython(req, res);
    if (data.length > 0) {
      console.log(data);
      res.status(200).send(data);
    } else {
      res.status(400).send('Error');
    }
  } catch (err) {
    if (err.name === 'ValidationError') {
      res.status(400).json(err.extra);
    } else {
      res.status(500).json(err);
    }
  }
});


module.exports = router;
