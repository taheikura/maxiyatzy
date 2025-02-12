import { defineBackend } from '@aws-amplify/backend';
import { auth } from './auth/resource';
import { data } from './data/resource';
import { getScores } from './functions/get-scores/resource';
import { throwDice } from './functions/throw-dice/resource';
import { endTurn } from './functions/end-turn/resource';

/**
 * @see https://docs.amplify.aws/react/build-a-backend/ to add storage, functions, and more
 */
defineBackend({
  auth,
  data,
  getScores,
  endTurn,
  throwDice,
});
