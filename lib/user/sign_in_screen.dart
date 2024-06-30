import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:survey/admin/admin_dashboard.dart';
import 'package:survey/master_admin/master_admin_create_screen.dart';
import 'package:survey/provider/home_controller.dart';
import 'package:survey/user/feedback_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _userFormKey = GlobalKey<FormState>();
  final _adminFormKey = GlobalKey<FormState>();
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
    if (value.length < 3) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  late HomeController homeController;
  @override
  void initState() {
    super.initState();
    homeController = Provider.of(context, listen: false);
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
    homeController = context.watch<HomeController>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        title: Text('Login',
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600)),
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 4.0,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.blueGrey,
          tabs: const [
            Tab(text: 'User'),
            Tab(text: 'Admin'),
          ],
        ),
      ),
      body:homeController.loading?Center(child: CircularProgressIndicator()): TabBarView(
        controller: _tabController,
        children: [
          _buildLoginTab('User', _userFormKey),
          _buildLoginTab('Admin', _adminFormKey),
        ],
      ),
    );
  }

  Widget _buildLoginTab(String userType, GlobalKey<FormState> formKey) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset(
                userType == "User" ? "asset/user.png" : "asset/admin.png",
                height: 200,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: _validateUsername,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: _validatePassword,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {

                    if(userType == "User"){
                       homeController
                        .signIn(_usernameController.text.toString() ?? "",
                            _passwordController.text.toString(), context)
                        .then((value) {
                      if (value == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login Success')),
                        );
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => userType == "User"
                                ? FeedbackScreen()
                                : AdminHomeScreen(),
                          ),
                        );
                      } else {
                        // Form is valid, proceed with your logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login Failed')),
                        );
                      }
                    });
                    }else{
                       homeController
                        .signInAdmin(_usernameController.text.toString() ?? "",
                            _passwordController.text.toString(), context)
                        .then((value) {
                      if (value == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login Success')),
                        );
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => userType == "User"
                                ? FeedbackScreen()
                                : AdminHomeScreen(),
                          ),
                        );
                      } else {
                        // Form is valid, proceed with your logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login Failed')),
                        );
                      }
                    });
                    }
                   
                  }
                },
                style: ElevatedButton.styleFrom(
                  surfaceTintColor: Colors.blue, // Button background color
                  backgroundColor: Colors.white, // Button text color
                  shadowColor: Colors.blueAccent, // Shadow color
                  elevation: 5, // Elevation of the button
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0), // Vertical padding
                  minimumSize: const Size(
                      double.infinity, 50), // Button width and height
                ),
                child: Text('Log in', style: GoogleFonts.lato()),
              ),

              const SizedBox(
                height: 20,
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
