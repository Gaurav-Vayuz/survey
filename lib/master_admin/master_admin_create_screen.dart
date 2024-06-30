import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey/admin/admin_dashboard.dart';
import 'package:survey/admin/dashboard.dart';
import 'package:survey/provider/home_controller.dart';
class CreateUserByMaterAdminScreen extends StatefulWidget {
  @override
  State<CreateUserByMaterAdminScreen> createState() => _CreateUserByMaterAdminScreenState();
}

class _CreateUserByMaterAdminScreenState extends State<CreateUserByMaterAdminScreen> {
  HomeController? homeController;
    final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    homeController = Provider.of(context, listen: false);
 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     homeController = context.watch<HomeController>();
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.teal,
        title: const Text('Create User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Create User',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if(_passwordController.text.isEmpty&&_usernameController.text.isEmpty){
                   ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Kindly Filled All Field')
                          , backgroundColor: Colors.red,));
                }else{
                  homeController?.creteUserByAdmin(_usernameController.text, _passwordController.text, context).then((value) {
                if(value==true){
                   ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User Created Success')
                          , backgroundColor: Colors.green,));
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHomeScreen(),));
                }else{
ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('SomeThings went Wrong')
                          , backgroundColor: Colors.red,));
                }
                  });
                }
              },
              child: const Text('Create'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}