import { defineAuth } from '@aws-amplify/backend';
import { postConfirmation } from './post-confirmation/resource';

/**
 * Define and configure your auth resource
 * @see https://docs.amplify.aws/gen2/build-a-backend/auth
 */
export const auth = defineAuth({
  loginWith: {
    email: {
      verificationEmailStyle: "CODE",
      verificationEmailSubject: "Tervetuloa pelaamaan Maksi Jatsia!",
      verificationEmailBody: (createCode) => `Vahvistuskoodi tilin aktivoimiseksi: ${createCode()}`,
    },
  },
  triggers: {
    postConfirmation
  },
  userAttributes: {
    nickname: {
      mutable: true,
      required: true,
    }
  },  
});
