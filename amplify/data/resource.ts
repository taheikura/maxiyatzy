import { type ClientSchema, a, defineData } from '@aws-amplify/backend';

const schema = a.schema({
  Game: a
    .model({
      name: a.string().required(),
      state: a.enum(['joinable', 'ongoing', 'finished']),
      results: a.hasMany('Result', 'gameId'),
      users: a.hasMany('User', 'gameId'),
    })
    .authorization((allow) => [allow.authenticated()]),
  Result: a
    .model({
      name: a.string().required(),
      content: a.json().required(),
      gameId: a.id().required(),
      game: a.belongsTo('Game', 'gameId'),
      users: a.hasMany('ResultUser', 'resultId'),
    })
    .authorization((allow) => [allow.authenticated()]),
  User: a
    .model({
      gameId: a.id(),
      game: a.belongsTo('Game', 'gameId'),
      results: a.hasMany('ResultUser', 'userId'),
    })
    .authorization((allow) => [allow.authenticated()]),
  ResultUser: a
    .model({
      resultId: a.id().required(),
      userId: a.id().required(),
      result: a.belongsTo('Result', 'resultId'),
      user: a.belongsTo('User', 'userId'),
    })
    .authorization((allow) => [allow.authenticated()]),
});

export type Schema = ClientSchema<typeof schema>;

export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: 'userPool',
  },
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
