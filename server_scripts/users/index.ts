import * as admin from 'firebase-admin';
import firebase from '@firebase/app';
import '@firebase/auth';
const serviceAccount = require('./firebaseServiceKey.json')

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
})

firebase.initializeApp({
  apiKey: "AIzaSyBywkBF8HlaLDTgvPM2bxCGXaBuhs8__7I",
  authDomain: "optixtoolkit.firebaseapp.com",
  databaseURL: "https://optixtoolkit.firebaseio.com",
  projectId: "optixtoolkit",
  storageBucket: "optixtoolkit.appspot.com",
  messagingSenderId: "227710522821",
  appId: "1:227710522821:web:8992302e340bb9c1b767ac",
  measurementId: "G-0M4XPGFFXM"
})

async function createAdmin (email: string, name: string) {
  let user: admin.auth.UserRecord
  try {
    user = await admin.auth().createUser({
      email: email,
      displayName: name
    })
  }
  catch (e) {
    user = await admin.auth().getUserByEmail(email)
    await admin.auth().updateUser(user.uid, {
      email: user.email,
      displayName: name
    })
  }
  
  await admin.auth().setCustomUserClaims(user.uid, {admin: true, member: true})

  return firebase.auth().sendPasswordResetEmail(email)
}

async function createMember (email: string, name: string) {
  let user: admin.auth.UserRecord
  try {
    user = await admin.auth().createUser({
      email: email,
      displayName: name
    })
  }
  catch (e) {
    user = await admin.auth().getUserByEmail(email)
    await admin.auth().updateUser(user.uid, {
      email: email,
      displayName: name
    })
  }
  
  await admin.auth().setCustomUserClaims(user.uid, {admin: true, member: true})

  return firebase.auth().sendPasswordResetEmail(email)
}

createAdmin('admin@team3749.org', 'Admin').then(() => {
  console.log("job finished")
  process.exit()
})