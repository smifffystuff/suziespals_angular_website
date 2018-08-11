const mysql = require('promise-mysql');
const db = require('./sqlConfig');

exports.handler = (event, context, callback) => {
  console.log(event);
  let connection;

  mysql
    .createConnection(db)
    .then(conn => {
      console.log('connection established');
      connection = conn;
      return connection.query(
        `INSERT INTO profile (userId, name, gender, location, numberOfpets)
        VALUES ('${event.userId}', '${event.name}', '${event.gender}', '${
          event.location
        }', '${event.numberOfPets}')`
      );
    })
    .then(result => {
      console.log(result);
      connection.end();
      callback(null, event);
    })
    .catch(err => {
      console.log(err);
      connection.end();
      callback(err);
    });
};
