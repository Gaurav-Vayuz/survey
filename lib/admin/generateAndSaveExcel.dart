import 'dart:developer';

import 'package:cr_file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import '../model/get_user_form_model.dart';

Future<void> generateExcel(List<GetUserFormData> userDetails, BuildContext contxt) async {
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
  // if (Platform.isAndroid) {
  //   if (!await _requestPermission(Permission.storage)) {
  //     print('Permission denied');
  //     return;
  //   }
  // }

  // Get the directory to save the file.
  Directory? directory;
  if (Platform.isAndroid) {
    directory = await getExternalStorageDirectory();
  } else {
    directory = await getApplicationDocumentsDirectory();
  }

  String outputFile = "${directory!.path}/user_details.xlsx";
  _onSaveWithDialogPressed(excel, contxt);
  print('Excel file saved at $outputFile');
}

const _tempFileName = 'TempFile.pdf';
const _testFileName = 'TestFile.pdf';
const _testWithDialogFileName = 'TestFileWithDialog.pdf';

void _createTempPressed(Excel excel) async {
  final folder = await getTemporaryDirectory();
  final filePath = '${folder.path}/user';
  final file = File(filePath);
  final raf = await file.open(mode: FileMode.writeOnlyAppend);
  await raf.writeByteSync(convertExcelToInt(excel));
  await raf.close();

  log('Created temp file: ${file.path}');
}

void _onSaveWithDialogPressed(Excel excel, BuildContext contxt) async {
  final folder = await getTemporaryDirectory();
  final filePath = '${folder.path}/userData.xlsx';

  try {
    // Save Excel data to a temporary file
    final fileBytes = excel.encode();

    if (fileBytes != null) {
      final file = File(filePath);
      await file.writeAsBytes(fileBytes);

      // Save the file with a dialog
      String? savedFile = await CRFileSaver.saveFileWithDialog(
        SaveFileDialogParams(
          sourceFilePath: filePath,
          destinationFileName: '_testWithDialogFileName.xlsx',
        ),
      );
      ScaffoldMessenger.of(contxt).showSnackBar(
        SnackBar(content: Text('File Saved Successfully')),
      );
      log('Saved to $savedFile');
    }
  } catch (error) {
    ScaffoldMessenger.of(contxt).showSnackBar(
      SnackBar(content: Text('Error :error ')),
    );
    log('Error: $error');
  }
}

int convertExcelToInt(Excel excel) {
  for (var table in excel.tables.keys) {
    for (var row in excel.tables[table]!.rows) {
      for (var cell in row) {
        if (cell != null) {
          try {
            int intValue = int.parse(cell.value.toString());
            return intValue;
            print('Converted value: $intValue');
          } catch (e) {
            return 0;
            print('Error converting cell value: $e');
          }
        }
      }
    }
  }
  return 0;
}

Future<bool> _requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    return result == PermissionStatus.granted;
  }
}
