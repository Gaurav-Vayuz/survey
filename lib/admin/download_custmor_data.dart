import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:survey/admin/generateAndSaveExcel.dart';
import 'package:survey/provider/home_controller.dart';
import 'package:survey/user/custom_elevated_button.dart';

class DownloadExcelScreen extends StatefulWidget {
  @override
  _DownloadExcelScreenState createState() => _DownloadExcelScreenState();
}

class _DownloadExcelScreenState extends State<DownloadExcelScreen> {
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  String? _selectedFormat;

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }

  void _setDateRange(String type) {
    DateTime now = DateTime.now();
    DateTime startDate;
    DateTime endDate = now;

    if (type == 'Yesterday') {
      startDate = endDate.subtract(const Duration(days: 1));
    } else if (type == 'Today') {
      startDate = endDate;
    } else if (type == 'Month Till Date') {
      startDate = DateTime(now.year, now.month, 1);
    } else {
      startDate = now;
    }

    setState(() {
      _startDateController.text = DateFormat('MM/dd/yyyy').format(startDate);
      _endDateController.text = DateFormat('MM/dd/yyyy').format(endDate);
    });
  }

  HomeController? homeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    homeController = context.watch<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Download Excel File', style: GoogleFonts.lato()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Download Excel File:',
              style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () => _setDateRange('Yesterday'),
            //       child: Text('Yesterday', style: GoogleFonts.lato()),
            //     ),
            //     ElevatedButton(
            //       onPressed: () => _setDateRange('Today'),
            //       child: Text('Today', style: GoogleFonts.lato()),
            //     ),
            //     ElevatedButton(
            //       onPressed: () => _setDateRange('Month Till Date'),
            //       child: Text('Month Till Date', style: GoogleFonts.lato()),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 16),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //       child: TextField(
            //         controller: _startDateController,
            //         decoration: InputDecoration(
            //           hintText: 'Start Date',
            //           suffixIcon: IconButton(
            //             icon: Icon(Icons.calendar_today),
            //             onPressed: () => _selectDate(context, _startDateController),
            //           ),
            //           border: OutlineInputBorder(),
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: 16),
            //     Expanded(
            //       child: TextField(
            //         controller: _endDateController,
            //         decoration: InputDecoration(
            //           hintText: 'End Date',
            //           suffixIcon: IconButton(
            //             icon: Icon(Icons.calendar_today),
            //             onPressed: () => _selectDate(context, _endDateController),
            //           ),
            //           border: OutlineInputBorder(),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'Download as',
                border: OutlineInputBorder(),
              ),
              items: ['Excel'].map((String format) {
                return DropdownMenuItem<String>(
                  value: format,
                  child: Text(format, style: GoogleFonts.lato()),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  // _selectedFormat = newValue;
                });
              },
              value: _selectedFormat,
            ),
            const SizedBox(height: 16),
            CustomElevatedButton(
              onTap: () {
                try {
                  generateExcel(homeController!.userFormList, context);
                } catch (e) {}
              },
              text: 'Download',
            )
          ],
        ),
      ),
    );
  }
}
