/**
 * Migration script - Transforms "Dashmesh Mechanics" production data to Dev format.
 * 
 * Usage: node migrate.js
 * Requires: serviceAccountKey.json in same directory
 */

const admin = require('firebase-admin');

// Initialize Firebase Admin
const serviceAccount = require('./serviceAccountKey.json');
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
const db = admin.firestore();

async function migrateCustomersAndVisits() {
  console.log('🔄 Starting Migration...');

  // 1. Fetch all Production Customers
  console.log('   Fetching Customers...');
  const customersSnap = await db.collection('Customer').get();
  const customerMap = new Map(); // Maps numeric Customer_id to Firestore document ID

  console.log(`   Found ${customersSnap.size} Customers.`);

  let batch = db.batch();
  let operationCount = 0;

  async function commitBatchIfNeeded() {
    if (operationCount >= 450) {
      console.log('   Committing batch...');
      await batch.commit();
      batch = db.batch();
      operationCount = 0;
    }
  }

  for (const doc of customersSnap.docs) {
    const data = doc.data();
    const docId = doc.id;
    
    // Store mapping for Visits
    const numericCustomerId = data.Customer_id;
    if (numericCustomerId !== undefined) {
      customerMap.set(String(numericCustomerId), docId);
    }

    // Transform fields
    const transformedData = {
      id: docId,
      address: data.Address || '',
      customer_id: String(data.Customer_id || ''),
      locality: data.Locality || '',
      name: data.Name || '',
      note: data.Note || '',
      number: data.Number || '',
      ro_type: data.Ro_Type || '',
      // Add missing default fields
      email: '',
      role: '',
      status: 'active',
      customer_type: 'Active AMC',
      avatar_url: '',
      device_name: '',
      device_installed_on: '',
      device_last_service: '',
      device_filter_health: 1.0,
      total_visits: 0,
      active_amc: false,
      customer_value: '0',
      open_tickets: 0,
      isRentCustomer: false,
      rentAmount: 0.0,
      rentDueDay: 1,
      isDeleted: false,
    };

    // We don't delete old fields in this script to be safe, we just merge new ones
    // Or, actually, to make it perfectly clean, we can replace the document.
    // The user said "usme data alag tarike se store kara gaya hai jabki Dashmesh Mechanics Dev mein thoda alag tarike se. Toh mujhe chahiye ki jaisa Dashmesh Mechanics Dev mein jaise store ho rakha hai na? waise apne Dashmesh Mechanics mein jitne saare data hai waise store ho jaye."
    // Let's use set() to completely replace it, but maybe we should keep old fields just in case?
    // Let's set with merge: false to completely replace the document with the dev format.
    // BUT Wait! The backup script handles backups. Let's just do a clean replace to match Dev exactly.
    // Wait, let's keep original fields just by doing a set with merge: true, but we update the new names.
    // It's safer. Or we can delete old fields. Let's delete the old capitalized fields.

    // Delete old fields
    transformedData.Address = admin.firestore.FieldValue.delete();
    transformedData.Customer_id = admin.firestore.FieldValue.delete();
    transformedData.Locality = admin.firestore.FieldValue.delete();
    transformedData.Name = admin.firestore.FieldValue.delete();
    transformedData.Note = admin.firestore.FieldValue.delete();
    transformedData.Number = admin.firestore.FieldValue.delete();
    transformedData.Ro_Type = admin.firestore.FieldValue.delete();

    const ref = db.collection('Customer').doc(docId);
    batch.set(ref, transformedData, { merge: true });
    operationCount++;
    await commitBatchIfNeeded();
  }

  // 2. Fetch all Production Visits
  console.log('   Fetching Visits...');
  const visitsSnap = await db.collection('Visits').get();
  console.log(`   Found ${visitsSnap.size} Visits.`);

  for (const doc of visitsSnap.docs) {
    const data = doc.data();
    
    const numericCustomerId = String(data.Customer_id);
    const parentCustomerDocId = customerMap.get(numericCustomerId);

    if (!parentCustomerDocId) {
      console.warn(`   ⚠️ Warning: Visit ${doc.id} has Customer_id ${data.Customer_id} but no matching Customer was found. Skipping.`);
      continue;
    }

    // Transform fields for Dev format
    // In Dev, it's a subcollection: Customer/{customerId}/services/{serviceId}
    const newServiceRef = db.collection('Customer').doc(parentCustomerDocId).collection('services').doc();
    
    // amountPending was "-" in production when zero.
    let amountPending = 0.0;
    if (data.Pending_Amount && data.Pending_Amount !== '-') {
      amountPending = parseFloat(data.Pending_Amount) || 0.0;
    }

    const transformedVisit = {
      id: newServiceRef.id,
      customerId: parentCustomerDocId,
      totalAmount: parseFloat(data.Bill_Amount) || 0.0,
      serviceDate: data.Date || new Date().toISOString(),
      equipmentsUsed: data.Equipment_List || '',
      fixes: data.Fault || '',
      guaranteeDuration: data.Guarantee || '',
      remarks: data.Note || '',
      notificationDate: data.Notification_Date || new Date().toISOString(),
      amountPaid: parseFloat(data.Paid_Amount) || 0.0,
      amountPending: amountPending,
      serviceDuration: data.Service_Duration || '',
      serviceType: data.Service_Type || '',
      isUrgent: false,
      isDismissed: false,
      isDeleted: false,
      // We can also fetch the roType from the customer if we want, but keeping it empty is fine, or reading from the map.
    };

    batch.set(newServiceRef, transformedVisit);
    operationCount++;
    await commitBatchIfNeeded();
    
    // We can delete the old visit document to clean up.
    // batch.delete(doc.ref);
    // operationCount++;
    // await commitBatchIfNeeded();
  }

  // 3. Transform Ro_Type
  console.log('   Transforming Ro_Type...');
  const roTypeSnap = await db.collection('Ro_Type').get();
  const uniqueRoTypes = new Set();
  
  for (const doc of roTypeSnap.docs) {
    const data = doc.data();
    if (data.Ro_Type) {
      uniqueRoTypes.add(data.Ro_Type);
    }
  }

  if (uniqueRoTypes.size > 0) {
    const roTypeRef = db.collection('RoType').doc('config');
    batch.set(roTypeRef, {
      types: Array.from(uniqueRoTypes)
    });
    operationCount++;
    await commitBatchIfNeeded();
  }

  if (operationCount > 0) {
    console.log('   Committing final batch...');
    await batch.commit();
  }

  console.log('✅ Migration completed successfully!');
}

async function main() {
  console.log('=== DASHMESH MECHANICS - FIRESTORE MIGRATION ===\n');
  try {
    await migrateCustomersAndVisits();
    process.exit(0);
  } catch (e) {
    console.error('❌ Migration failed:', e);
    process.exit(1);
  }
}

main();
