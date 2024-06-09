// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:survey/customer.dart';

// Future<void> generateAndSaveExcel(List<Customer> customers) async {
//   var excel = Excel.createExcel();
//   Sheet sheetObject = excel['Sheet1'];

//   // Add header row
//   sheetObject.appendRow(['ID', 'Name', 'Contact Number', 'City']);

//   // Add customer data
//   for (Customer customer in customers) {
//     sheetObject.appendRow([
//       customer.id,
//       customer.name,
//       customer.contactNumber,
//       customer.city
//     ]);
//   }

//   // Save the Excel file
//   var status = await Permission.storage.request();
//   if (status.isGranted) {
//     final directory = await getExternalStorageDirectory();
//     final path = '${directory!.path}/CustomerData.xlsx';
//     File(path)
//       ..createSync(recursive: true)
//       ..writeAsBytesSync(excel.encode()!);
//     print('Excel file saved to $path');
//   } else {
//     print('Permission denied');
//   }
// }
