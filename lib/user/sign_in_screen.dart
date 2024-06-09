import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/admin/admin_dashboard.dart';
import 'package:survey/user/feedback_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  final _adminKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    if (value.length < 4) {
      return 'Username must be at least 4 characters';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        title: Text('Login', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600)),
        bottom: TabBar(
          // tabAlignment: TabAlignment.center,
          controller: _tabController,

          indicatorWeight: 4.0,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.blueGrey,
          tabs: [
            Tab(text: 'User'),
            Tab(text: 'Admin'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLoginTab('User'),
          _buildLoginTab('Admin'),
        ],
      ),
    );
  }

  Widget _buildLoginTab(String userType) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Image.asset(
                userType == "User" ? "asset/user.png" : "asset/admin.png",
                height: 200,
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: _validateUsername,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: _validatePassword,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              userType == "User" ? FeedbackScreen() : AdminHomeScreen(),
                        ));
                    // Form is valid, proceed with your logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  surfaceTintColor: Colors.blue, // Button background color
                  backgroundColor: Colors.white, // Button text color
                  shadowColor: Colors.blueAccent, // Shadow color
                  elevation: 5, // Elevation of the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15.0), // Vertical padding
                  minimumSize: Size(double.infinity, 50), // Button width and height
                ),
                child: Text('Log in', style: GoogleFonts.lato()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminTab(String userType) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _adminKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "asset/admin.png",
                height: 200,
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: _validateUsername,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: _validatePassword,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_adminKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => AdminHomeScreen(),
                        ));
                    // Form is valid, proceed with your logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  surfaceTintColor: Colors.blue, // Button background color
                  backgroundColor: Colors.white, // Button text color
                  shadowColor: Colors.blueAccent, // Shadow color
                  elevation: 5, // Elevation of the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15.0), // Vertical padding
                  minimumSize: Size(double.infinity, 50), // Button width and height
                ),
                child: Text('Log in', style: GoogleFonts.lato()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
