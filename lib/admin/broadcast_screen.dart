import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:survey/provider/home_controller.dart';
import 'package:survey/user/custom_elevated_button.dart';

class BroadcastScreen extends StatefulWidget {
  const BroadcastScreen({super.key});

  @override
  _BroadcastScreenState createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends State<BroadcastScreen> {
  TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  HomeController? homeController;
  
  File? excelSheet;
 final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    homeController = Provider.of<HomeController>(context, listen: false);
      controller.text =
        '''Thank You for Submitting Your Feedback! Your feedback is valuable for us. We are constantly working to make
your experience smooth. If you want to add new products into our stock or for any enquiry.
Please submit your responses on google link send below. Thank You!!!
Save this as default in textfield''';
    super.initState();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx',],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      if (file.lengthSync() <= 5 * 1024 * 1024) {
        setState(() {
          excelSheet = file;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('File size exceeds 5 MB. Please select a smaller file.'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    homeController = context.watch<HomeController>();
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.teal,
        title: Text('Broadcast Message', style: GoogleFonts.lato()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Upload List of Contacts: ',
                    style: GoogleFonts.lato(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: _pickFile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Upload an Excel',
                      style: GoogleFonts.lato(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 16),
              TextField(
                controller: controller,
                maxLines: 8,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Enter your SMS template here',
                ),
              ),
             
           const SizedBox(height: 16),
            CustomElevatedButton(
              onTap: () {
                if (excelSheet?.path != null) {
                  homeController
                      ?.sendBroadCastMessage(controller.text, excelSheet, context)
                      .then((value) {
                    if (value == true) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Success'),
                        backgroundColor: Colors.green,
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Failed'),
                        backgroundColor: Colors.red,
                      ));
                    }
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Kindly add the xlsx sheet'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              text: 'Send Broadcast',
            )
          ],
        ),
      ),
    );
  }
}
