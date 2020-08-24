import * as admin from 'firebase-admin';
const serviceAccount = require('./firebaseServiceKey.json')

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
})

async function createAdminUser (email: string, name: string) {
  let user: admin.auth.UserRecord
  try {
    user = await admin.auth().createUser({
      email: email,
      password: 'password',
      displayName: name
    })
  }
  catch (e) {
    user = await admin.auth().getUserByEmail(email)
  }
  
  await admin.auth().setCustomUserClaims(user.uid, {admin: true, member: true})
  console.log("job finished")
  process.exit()
}

createAdminUser('admin@team3749.org', 'Admin')