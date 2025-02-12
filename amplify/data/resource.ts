import { type ClientSchema, a, defineData } from '@aws-amplify/backend';
import { getScores } from '../functions/get-scores/resource';
import { throwDice } from '../functions/throw-dice/resource';
import { endTurn } from '../functions/end-turn/resource';
import { postConfirmation } from '../auth/post-confirmation/resource';

const schema = a.schema({
  Game: a
    .model({
      name: a.string().required(),
      state: a.enum(['joinable', 'ongoing', 'finished']),
      users: a.hasMany('User', 'gameId'),
      scoreSheet: a.hasMany('ScoreSheet', 'gameId'),
      createdByUserId: a.id(),
      createdBy: a.belongsTo('User', 'createdByUserId'),
      whosTurnId: a.id(),
      whosTurn: a.belongsTo('User', 'whosTurnId'),
      turnNumber: a.enum(['first', 'second', 'third']),
    })
    .secondaryIndexes((index) => [index("state")])
    .authorization((allow) => [
      allow.authenticated().to(['create', 'read']),
      allow.owner().to(['delete', 'update']),
    ]),
  User: a
    .model({
      profileOwner: a.string(),
      name: a.string().required(),
      gameId: a.id(),
      game: a.belongsTo('Game', 'gameId'),
      hosting: a.hasOne('Game', 'createdByUserId'),
      gameTurn: a.hasOne('Game', 'whosTurnId'),
      scores: a.hasMany('Score', 'userId'),
    })
    .secondaryIndexes((index) => [index("profileOwner")])
    .authorization((allow) => [
      allow.ownerDefinedIn("profileOwner"),
    ]),
  ScoreType: a
    .customType({
      type: a.enum(['Ones', 'Twos', 'Threes', 'Fours', 'Fives', 'Sixes', 'Pair', 'TwoPairs', 'ThreePairs',
        'ThreeOfAKind', 'FourOfAKind', 'FiveOfAKind', 'SmallStraight', 'LargeStraight', 'FullStraight',
        'FullHouse', 'Villa', 'Tower', 'Chance', 'MaxiYatzy' ]),
    }),
  Score: a
    .model({
      typeId: a.id().required(),
      type: a.ref('ScoreType'),
      value: a.integer(),
      userId: a.id().required(),
      user: a.belongsTo('User', 'userId'),
      scoreSheetId: a.id().required(),
      scoreSheet: a.belongsTo('ScoreSheet', 'scoreSheetId'),
    })
    .authorization((allow) => [allow.authenticated()]),
  ScoreSheet: a
    .model({
      gameId: a.id(),
      game: a.belongsTo('Game', 'gameId'),
      score: a.hasMany('Score', 'scoreSheetId'),
    })
    .authorization((allow) => [allow.authenticated()]),
  getScores: a
    .query()
    .arguments({
      diceValues: a.integer().array().required(),
    })
    .returns(a.json())
    .handler(a.handler.function(getScores))
    .authorization((allow) => [allow.authenticated()]),
  Vector3: a
    .customType({
      x: a.float(),
      y: a.float(),
      z: a.float(),
    }),
  Die: a
    .customType({
      position: a.ref('Vector3'),
      quaternion: a.customType({
        w: a.float(),
        x: a.float(),
        y: a.float(),
        z: a.float(),
      }),
      velocity: a.ref('Vector3'),
      angularVelocity: a.ref('Vector3'),
    }),
  ThrowDiceResponse: a
    .customType({
      gravity: a.ref('Vector3'),
      groundPosition: a.ref('Vector3'),
      dice: a.ref('Die').array(),
    }),
  throwDice: a
    .query()
    .arguments({
      numberOfDice: a.integer().required(),
    })
    .returns(a.ref('ThrowDiceResponse'))
    .handler(a.handler.function(throwDice))
    .authorization((allow) => [allow.authenticated()]),
  endTurn: a
    .mutation()
    .arguments({
      scoreType: a.enum(['Ones', 'Twos', 'Threes', 'Fours', 'Fives', 'Sixes', 'Pair', 'TwoPairs', 'ThreePairs',
        'ThreeOfAKind', 'FourOfAKind', 'FiveOfAKind', 'SmallStraight', 'LargeStraight', 'FullStraight',
        'FullHouse', 'Villa', 'Tower', 'Chance', 'MaxiYatzy']),
    })
    .returns(a.integer())
    .handler(a.handler.function(endTurn))
    .authorization((allow) => [allow.authenticated()]),
}).authorization((allow) => [allow.resource(postConfirmation)]);;

export type Schema = ClientSchema<typeof schema>;

export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: 'userPool',
  },
  logging: true,
});

/*== STEP 2 ===============================================================
Go to your frontend source code. From your client-side code, generate a
Data client to make CRUDL requests to your table. (THIS SNIPPET WILL ONLY
WORK IN THE FRONTEND CODE FILE.)

Using JavaScript or Next.js React Server Components, Middleware, Server 
Actions or Pages Router? Review how to generate Data clients for those use
cases: https://docs.amplify.aws/gen2/build-a-backend/data/connect-to-API/
=========================================================================*/

/*
"use client"
import { generateClient } from "aws-amplify/data";
import type { Schema } from "@/amplify/data/resource";

const client = generateClient<Schema>() // use this Data client for CRUDL requests
*/

/*== STEP 3 ===============================================================
Fetch records from the database and use them in your frontend component.
(THIS SNIPPET WILL ONLY WORK IN THE FRONTEND CODE FILE.)
=========================================================================*/

/* For example, in a React component, you can use this snippet in your
  function's RETURN statement */
// const { data: todos } = await client.models.Todo.list()

// return <ul>{todos.map(todo => <li key={todo.id}>{todo.content}</li>)}</ul>
