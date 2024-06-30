import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/admin/broadcast_screen.dart';
import 'package:survey/admin/dashboard.dart';
import 'package:survey/admin/download_custmor_data.dart';
import 'package:survey/admin/edit_sms_tempalate.dart';
import 'package:survey/admin/user_list_scren.dart';
import 'package:survey/user/sign_in_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.teal,

          title: Text('Admin Home', style: GoogleFonts.lato()),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Text(
                  'Admin Menu',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.message_outlined),
                title: Text('Send SMS', style: GoogleFonts.lato()),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditSmsTemplateScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person_add),
                title: Text("Download Customer’s Data", style: GoogleFonts.lato()),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DownloadExcelScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Broadcast SMS'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BroadcastScreen()),
                  );
                },
              ),
               ListTile(
                leading: Icon(Icons.person),
                title: Text("User List", style: GoogleFonts.lato()),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserListScreen()),
                  );
                },
              ),
               ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout", style: GoogleFonts.lato()),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
        body: CustomerDataScreen());
  }
}

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.teal,
        title: Text('Register', style: GoogleFonts.lato()),
      ),
      body: Center(
        child: Text(
          'Register Screen',
          style: GoogleFonts.lato(fontSize: 24),
        ),
      ),
    );
  }
}

class BroadcastSmsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.teal,
        title: Text('Broadcast SMS', style: GoogleFonts.lato()),
      ),
      body: Center(
        child: Text('Broadcast SMS Screen', style: GoogleFonts.lato(fontSize: 24)),
      ),
    );
  }
}
