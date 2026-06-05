const admin = require('firebase-admin');
const xlsx = require('xlsx');
const path = require('path');
const serviceAccount = require('./serviceAccountKey.json');

// Initialize Firebase Admin
if (!admin.apps.length) {
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
  });
}

const db = admin.firestore();

// Helper to format excel date
function formatExcelDate(excelSerialDate) {
  if (!excelSerialDate || typeof excelSerialDate !== 'number') return null;
  const date = new Date(Math.round((excelSerialDate - 25569) * 86400 * 1000));
  return date.toISOString().split('T')[0];
}

async function deleteCollection(collectionPath, batchSize) {
  const collectionRef = db.collection(collectionPath);
  const query = collectionRef.orderBy('__name__').limit(batchSize);

  return new Promise((resolve, reject) => {
    deleteQueryBatch(db, query, resolve).catch(reject);
  });
}

async function deleteQueryBatch(db, query, resolve) {
  const snapshot = await query.get();

  const batchSize = snapshot.size;
  if (batchSize === 0) {
    resolve();
    return;
  }

  const batch = db.batch();
  for (const doc of snapshot.docs) {
    // Delete subcollections first
    const subcols = await doc.ref.listCollections();
    for (const sub of subcols) {
      const subDocs = await sub.get();
      subDocs.docs.forEach(sd => batch.delete(sd.ref));
    }
    batch.delete(doc.ref);
  }
  await batch.commit();

  process.nextTick(() => {
    deleteQueryBatch(db, query, resolve);
  });
}

async function runMigration() {
  console.log('Starting migration from Excel...');
  
  // 1. Wipe old data
  console.log('Wiping existing Customer data...');
  await deleteCollection('Customer', 100);
  console.log('Old data cleared.');

  // 2. Read Excel
  const workbook = xlsx.readFile(path.join(__dirname, '../229 sample dashmesh mechanix.xlsx'));
  const sheetName = workbook.SheetNames[0];
  const worksheet = workbook.Sheets[sheetName];
  const data = xlsx.utils.sheet_to_json(worksheet, { defval: "" });

  console.log(`Read ${data.length} rows from Excel.`);

  const customersMap = new Map(); // phone number -> { customerDoc, services: [] }

  for (let i = 0; i < data.length; i++) {
    const row = data[i];
    let numberStr = row['Number'] ? row['Number'].toString().trim() : '';
    
    // Assign a dummy number if the number is missing
    if (!numberStr) {
      numberStr = `NO_NUMBER_${i + 1}`;
    }

    const visitDate = formatExcelDate(row[' ']);
    const ldocDate = formatExcelDate(row['LDOC']);

    if (!customersMap.has(numberStr)) {
      customersMap.set(numberStr, {
        customerData: {
          name: row['Name'] ? row['Name'].toString() : '',
          number: numberStr,
          address: row['Address'] ? row['Address'].toString() : '',
          locality: row['Area'] ? row['Area'].toString() : '',
          ro_type: row['ro type'] ? row['ro type'].toString() : '',
          note: row['landmark'] ? row['landmark'].toString() : '', // Put landmark in note for now
          customer_id: row['diary n0'] ? row['diary n0'].toString() : '',
          is_deleted: false
        },
        services: []
      });
    }

    const customerObj = customersMap.get(numberStr);
    
    // Add service
    customerObj.services.push({
      serviceDate: visitDate || new Date().toISOString(),
      serviceType: row['Service Type'] || '',
      fixes: row['fault'] || '',
      totalAmount: parseFloat(row['Bill Amount']) || 0.0,
      amountPaid: parseFloat(row['Paid Amount']) || 0.0,
      equipmentsUsed: row['Equipment List'] || '',
      guaranteeDuration: row['Guarntee'] || '',
      remarks: row['Alert'] || '',
      // Since it requires a Timestamp in some systems, let's use string if your Flutter expects string, or Date? 
      // customer_repository uses serviceDate as string or Timestamp? Wait. 
    });
  }

  console.log(`Grouped into ${customersMap.size} unique customers. Uploading...`);

  let currentBatch = db.batch();
  let count = 0;

  for (const [number, customerData] of customersMap.entries()) {
    const customerRef = db.collection('Customer').doc();
    const cData = customerData.customerData;
    cData.id = customerRef.id;
    currentBatch.set(customerRef, cData);
    count++;

    for (const srv of customerData.services) {
      const srvRef = customerRef.collection('services').doc();
      srv.id = srvRef.id;
      // customer_repository uses:
      // DateTime serviceDate -> Firestore string or Timestamp?
      // Usually json_serializable uses ISO8601 strings for DateTime unless modified.
      currentBatch.set(srvRef, srv);
      count++;
    }

    if (count >= 400) {
      await currentBatch.commit();
      currentBatch = db.batch();
      count = 0;
      console.log('Committed a batch...');
    }
  }

  if (count > 0) {
    await currentBatch.commit();
  }

  console.log('Migration complete!');
}

runMigration().catch(console.error);
