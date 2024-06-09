import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/customer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'customer_data_source.dart'; // Import your data source class

class CustomerDataScreen extends StatelessWidget {
  final List<Customer> customers = [
    Customer(1, 'John Doe', '1234567890', 'New York'),
    Customer(2, 'Jane Smith', '0987654321', 'Los Angeles'),
    // Add more customer data here
  ];

  @override
  Widget build(BuildContext context) {
    final CustomerDataSource customerDataSource = CustomerDataSource(customers: customers);

    return Scaffold(
      body: SfDataGrid(
        source: customerDataSource,
        columns: [
          GridColumn(
            columnName: 'id',
            label: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text('ID', style: GoogleFonts.lato()),
            ),
          ),
          GridColumn(
            columnName: 'name',
            label: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text('Name', style: GoogleFonts.lato()),
            ),
          ),
          GridColumn(
            columnName: 'contactNumber',
            label: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text('Contact Number', style: GoogleFonts.lato()),
            ),
          ),
          GridColumn(
            columnName: 'city',
            label: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text('City', style: GoogleFonts.lato()),
            ),
          ),
          GridColumn(
            columnName: 'Remarks',
            label: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text('Remarks', style: GoogleFonts.lato()),
            ),
          ),
        ],
      ),
    );
  }
}
