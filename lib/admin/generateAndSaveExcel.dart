import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import '../model/get_user_form_model.dart';

Future<void> generateExcel(List<GetUserFormData> userDetails) async {
  // Create an Excel document.
  var excel = Excel.createExcel();
  // Remove any default sheet created (like sheet1)
  

  // Create a new sheet named 'UserDetails'.
  var sheetObject = excel['Sheet1'];

  // Add headers to the sheet.
  sheetObject.appendRow(["contactNo"]);

  // Add user details to the sheet.
  for (var user in userDetails) {
    sheetObject.appendRow([user.contactNo]);
  }
  // if (excel.tables.keys.length == 2) {
  //   excel.delete("Sheet1");
  // }

  // Request storage permissions.
  if (Platform.isAndroid) {
    if (!await _requestPermission(Permission.storage)) {
      print('Permission denied');
      return;
    }
  }

  // Get the directory to save the file.
  Directory? directory;
  if (Platform.isAndroid) {
    directory = await getExternalStorageDirectory();
  } else {
    directory = await getApplicationDocumentsDirectory();
  }


  String outputFile = "${directory!.path}/user_details.xlsx";


  File(outputFile)
    ..createSync(recursive: true)
    ..writeAsBytesSync(excel.encode()!);

  print('Excel file saved at $outputFile');
}

Future<bool> _requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    return result == PermissionStatus.granted;
  }
}
