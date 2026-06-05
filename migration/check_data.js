const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');
if (!admin.apps.length) {
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
  });
}
const db = admin.firestore();

async function check() {
  const snap = await db.collection('Customer').limit(2).get();
  snap.forEach(doc => {
    console.log("Customer:", doc.id, doc.data());
  });
  
  const servs = await snap.docs[0].ref.collection('services').get();
  servs.forEach(doc => {
     console.log("Service:", doc.data());
  });
}
check();
