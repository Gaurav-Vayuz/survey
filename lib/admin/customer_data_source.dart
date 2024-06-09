import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/customer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CustomerDataSource extends DataGridSource {
  CustomerDataSource({required List<Customer> customers}) {
    _customers = customers
        .map<DataGridRow>((customer) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: customer.id),
              DataGridCell<String>(columnName: 'name', value: customer.name),
              DataGridCell<String>(columnName: 'contactNumber', value: customer.contactNumber),
              DataGridCell<String>(columnName: 'city', value: customer.city),
              DataGridCell<String>(columnName: 'remarks', value: customer.remarks),
            ]))
        .toList();
  }

  List<DataGridRow> _customers = [];

  @override
  List<DataGridRow> get rows => _customers;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(dataGridCell.value.toString(), style: GoogleFonts.lato()),
      );
    }).toList());
  }
}
