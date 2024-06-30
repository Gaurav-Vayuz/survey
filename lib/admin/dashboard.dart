import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:survey/customer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../master_admin/master_admin_create_screen.dart';
import '../provider/home_controller.dart';
import 'customer_data_source.dart'; // Import your data source class

class CustomerDataScreen extends StatefulWidget {
  @override
  State<CustomerDataScreen> createState() => _CustomerDataScreenState();
}

class _CustomerDataScreenState extends State<CustomerDataScreen> {
  final List<Customer> customers = [];

  HomeController? homeController;
  @override
  void initState() {
    // TODO: implement initState
    homeController = Provider.of(context, listen: false);
    getUserForm();
    super.initState();
  }

  addDataToCustomerList() {
    if (homeController!.userFormList.isNotEmpty) {
      for (int i = 0; i < homeController!.userFormList.length; i++) {
        customers.add(Customer(
            i,
            homeController!.userFormList[i].name,
            homeController!.userFormList[i].contactNo,
            homeController!.userFormList[i].city,
            homeController!.userFormList[i].remarks));
      }
    } else {}
  }

  getUserForm() {
    homeController?.getUserForm(context).then((value) {
      addDataToCustomerList();
    });
  }

  @override
  Widget build(BuildContext context) {
    homeController = context.watch<HomeController>();
    final CustomerDataSource customerDataSource =
        CustomerDataSource(customers: customers);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateUserByMaterAdminScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: homeController!.loading
          ? const Center(child: CircularProgressIndicator())
          : homeController!.userFormList.isNotEmpty? SfDataGrid(
              source: customerDataSource,
              columns: [
                GridColumn(
                  columnName: 'id',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('ID', style: GoogleFonts.lato()),
                  ),
                ),
                GridColumn(
                  columnName: 'name',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('Name', style: GoogleFonts.lato()),
                  ),
                ),
                GridColumn(
                  columnName: 'contactNumber',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('Contact Number', style: GoogleFonts.lato()),
                  ),
                ),
                GridColumn(
                  columnName: 'city',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('City', style: GoogleFonts.lato()),
                  ),
                ),
                GridColumn(
                  columnName: 'Remarks',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('Remarks', style: GoogleFonts.lato()),
                  ),
                ),
              ],
            ):const Center(child: Text("No Data Found", style: TextStyle( fontSize: 24),)),

    );
  }
}
