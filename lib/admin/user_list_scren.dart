import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey/provider/home_controller.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  HomeController? homeController;
  @override
  void initState() {
    // TODO: implement initState
    homeController = Provider.of(context, listen: false);
    getUserList();
    super.initState();
  }

  getUserList() {
    homeController?.getAllUsers(context);
  }

  @override
  Widget build(BuildContext context) {
    homeController = context.watch<HomeController>();
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.teal,
        title: const Text("User List Screen"),
      ),
      body: homeController!.userList.isEmpty
          ? const Text("No Data")
          : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount:homeController?.userList.length,
                itemBuilder: (context, index) =>
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                           color: Colors.grey,
                          child: Text(homeController!.userList[index].toString().toUpperCase())),
                          const SizedBox( height: 10,)
                      ],
                    )),
          ),
    );
  }
}
