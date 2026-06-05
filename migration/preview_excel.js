const xlsx = require('xlsx');
const path = require('path');

const workbook = xlsx.readFile(path.join(__dirname, '../229 sample dashmesh mechanix.xlsx'));
const sheetName = workbook.SheetNames[0];
const worksheet = workbook.Sheets[sheetName];

const data = xlsx.utils.sheet_to_json(worksheet, { defval: "" });

const numberCounts = {};
let duplicateCount = 0;

data.forEach(row => {
  const num = row['Number'] ? row['Number'].toString() : 'Unknown';
  if (numberCounts[num]) {
    numberCounts[num]++;
    duplicateCount++;
  } else {
    numberCounts[num] = 1;
  }
});

console.log("Total rows:", data.length);
console.log("Unique numbers:", Object.keys(numberCounts).length);
console.log("Duplicate rows (multiple visits?):", duplicateCount);

// Helper to format excel date
function formatExcelDate(excelSerialDate) {
  if (!excelSerialDate || typeof excelSerialDate !== 'number') return excelSerialDate;
  // Excel dates start from Jan 1, 1900
  // JavaScript starts from Jan 1, 1970
  // Excel serial date 1 is Jan 1, 1900.
  // There is a known bug in Excel where it considers 1900 as a leap year, 
  // so dates after Feb 28, 1900 need to subtract 1 day.
  const date = new Date(Math.round((excelSerialDate - 25569) * 86400 * 1000));
  return date.toISOString().split('T')[0];
}

console.log("\nSample Row 1:");
if (data[0]) {
  const r = data[0];
  console.log(`Date: ${formatExcelDate(r[' '])}`);
  console.log(`Number: ${r['Number']}`);
  console.log(`LDOC: ${formatExcelDate(r['LDOC'])}`);
}
