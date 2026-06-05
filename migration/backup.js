/**
 * Backup script - exports all production Firestore data to JSON before migration.
 * Run this FIRST before running migrate.js
 * 
 * Usage: node backup.js
 * Requires: serviceAccountKey.json in same directory
 */

const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

// Initialize Firebase Admin
const serviceAccount = require('./serviceAccountKey.json');
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
const db = admin.firestore();

async function backupCollection(collectionName) {
  console.log(`📦 Backing up collection: ${collectionName}...`);
  const snapshot = await db.collection(collectionName).get();
  const docs = [];

  for (const doc of snapshot.docs) {
    const data = { _docId: doc.id, ...doc.data() };

    // Also backup sub-collections if they exist
    const subCollections = await doc.ref.listCollections();
    for (const subCol of subCollections) {
      const subSnap = await subCol.get();
      data[`_sub_${subCol.id}`] = subSnap.docs.map(sd => ({
        _docId: sd.id,
        ...sd.data(),
      }));
    }

    docs.push(data);
  }

  console.log(`   Found ${docs.length} documents`);
  return docs;
}

async function main() {
  console.log('=== DASHMESH MECHANICS - FIRESTORE BACKUP ===\n');

  const backup = {};

  // Backup all known collections
  const collections = ['Customer', 'Ro_Type', 'Visits'];

  for (const col of collections) {
    try {
      backup[col] = await backupCollection(col);
    } catch (e) {
      console.log(`   ⚠️  Error backing up ${col}: ${e.message}`);
      backup[col] = [];
    }
  }

  // Also check for any other top-level collections
  const allCollections = await db.listCollections();
  for (const col of allCollections) {
    if (!collections.includes(col.id)) {
      console.log(`   📌 Found extra collection: ${col.id}`);
      try {
        backup[col.id] = await backupCollection(col.id);
      } catch (e) {
        console.log(`   ⚠️  Error: ${e.message}`);
      }
    }
  }

  // Write backup file
  const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
  const backupFile = path.join(__dirname, `backup_${timestamp}.json`);
  fs.writeFileSync(backupFile, JSON.stringify(backup, null, 2), 'utf8');

  console.log(`\n✅ Backup saved to: ${backupFile}`);
  console.log(`   Total collections: ${Object.keys(backup).length}`);

  let totalDocs = 0;
  for (const [name, docs] of Object.entries(backup)) {
    console.log(`   ${name}: ${docs.length} documents`);
    totalDocs += docs.length;
  }
  console.log(`   Total documents: ${totalDocs}`);

  process.exit(0);
}

main().catch(e => {
  console.error('❌ Backup failed:', e);
  process.exit(1);
});
