# Checkers Server App

REST API server for checkers developed in Ada. It's designed to be able to handle many games at once (games are processed concurrently) and it automatically removes abandoned games. If there was no request from any of players assigned to a game in the past 5 seconds, server marks such game as abandoned and deletes it making space for another players.

The server was developed without AWS library. HTTP headers are parsed directly from socket stream. Unfortunately, in the method, for some of web browsers (mostly mobile ones) server is not able to access POST data (it is possible that `Receive_Socket` from `GNAT.sockets` library returns bad offset). Works fine with all requests sent from cURL and desktop version of Chrome, Opera and Firefox.

### Brief API description

##### `GET /game`
Creates new game and returns following data:
```
{
  gameID: Integer,
  board: [[Integer]],
  player1: Integer,
  player2: Integer,
  thisPlayer: Integer,
  turn: Integer,
}
```

##### `GET /game/:gameID`
Joins player to a game of given `gameID` and returns following data:
```
{
  gameID: Integer,
  board: [[Integer]],
  player1: Integer,
  player2: Integer,
  thisPlayer: Integer,
  turn: Integer,
}
```

##### `GET /game/:gameID/state`
Returns state of a game of given `gameID`:
```
{
  gameID: Integer,
  board: [[Integer]],
  player1: Integer,
  player2: Integer,
  winner: Integer,
  turn: Integer,
}
```

##### `POST /game/:gameID/move`

Moves user of given `playerID` from position `from` to position `to`:
```
{
  gameID: Integer,
  playerID: Integer,
  from: [Integer,Integer],
  to [Integer,Integer],
}
```
And returns following data:
```
{
  message: String,
  gameID: Integer,
  board: [[Integer]],
  turn: Integer,
}
```

#### External libriaries
- GNATcoll

#### Running the server
1. Compilation: `gprbuild -P checkers_server.gpr`
2. Running app: `/bin/main --port=PORT_NUMBER`
