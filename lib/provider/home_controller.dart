import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey/model/get_user_form_model.dart';
import 'package:survey/network/networking.dart';
import 'package:survey/utils/navigation_service.dart';

import '../network/api_url.dart';

class HomeController extends ChangeNotifier {
  final _myService = Networking();
  bool loading = false;
  var userToken = "";
  var adminToken = "";

  setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  bool isSuccess = false;

  Future<dynamic> signIn(
      String userId, String password, BuildContext context) async {
    // setLoading(true);

    await _myService.networkPost(
      url: "https://signin-jlq2.onrender.com/api/user/sign-in",
      data: {
        "username": userId,
        "password": password,
      },
    ).then((value) {
      var res = jsonDecode(value.toString());
      userToken = res["token"];
      isSuccess = true;
      setLoading(false);
      notifyListeners();

      return isSuccess;
    }).onError((error, stackTrace) {
   
      setLoading(false);
      
      isSuccess = false;
      notifyListeners();

      return isSuccess;
    });
    return isSuccess;
  }

  Future<dynamic> submitEmoji(String emojiType, BuildContext context) async {
    setLoading(true);
    bool isSuccess = false;
    await _myService.networkPost(
      url: "https://signin-jlq2.onrender.com/api/user/select-emoji",
      token: userToken,
      data: {"selectedEmoji": emojiType},
    ).then((value) {
      var res = jsonDecode(value.toString());
      debugPrint(res.toString());
      isSuccess = true;
      notifyListeners();
    }).onError((error, stackTrace) {
      //var err = jsonDecode(error.toString())["error"];
      setLoading(false);
     // print("The error is ${err.toString()}");
      isSuccess = false;
      
      notifyListeners();
     
    });
    return isSuccess;
  }

  Future<dynamic> submitForm(String name, String contactNumber, String city,
      String remarks, BuildContext context) async {
    bool isSuccess = false;
    setLoading(true);

    await _myService.networkPost(
      url: "https://signin-jlq2.onrender.com/api/user/submit-form",
      token: userToken,
      data: {
        "name": name,
        "contactNo": contactNumber,
        "city": city,
        "remarks": remarks
      },
    ).then((value) {
      var res = jsonDecode(value.toString());
      debugPrint(res.toString());
      isSuccess = true;
      notifyListeners();
    }).onError((error, stackTrace) {
      var err = jsonDecode(error.toString())["error"];
      setLoading(false);
      isSuccess = false;
      print("The error is ${err.toString()}");
      notifyListeners();
    });
    return isSuccess;
  }

  Future<dynamic> creteUserByAdmin(
      String userName, String password, BuildContext context) async {
    bool isSuccess = false;
    setLoading(true);

    await _myService.networkPost(
      url: "https://signin-jlq2.onrender.com/api/admin/create-user",
      token: adminToken,
      data: {
        "username": userName,
        "password": password,
      },
    ).then((value) {
      var res = jsonDecode(value.toString());
      debugPrint(res.toString());
      isSuccess = true;
      notifyListeners();
    }).onError((error, stackTrace) {
      var err = jsonDecode(error.toString())["error"];
      setLoading(false);
      isSuccess = false;
      print("The error is ${err.toString()}");
      notifyListeners();
    });
    return isSuccess;
  }

  Future<dynamic> signInAdmin(
      String userId, String password, BuildContext context) async {
   // setLoading(true);

    await _myService.networkPost(
      url: "https://signin-jlq2.onrender.com/api/admin/sign-in",
      data: {
        "username": userId,
        "password": password,
      },
    ).then((value) {
      var res = jsonDecode(value.toString());
      adminToken = res["token"];
      isSuccess = true;
       setLoading(false);
      notifyListeners();

      return isSuccess;
    }).onError((error, stackTrace) {
      setLoading(false);
      isSuccess = false;
      notifyListeners();

      return isSuccess;
    });
    return isSuccess;
  }
GetUserFormData? getUserFormData;
List<GetUserFormData> userFormList=[];
  Future<dynamic> getUserForm(BuildContext context) async {
    userFormList.clear();
    // setLoading(true);

    await _myService
        .networkGet(
            url: "https://signin-jlq2.onrender.com/api/admin/forms",
            token: adminToken)
        .then((value) {
      var res = (value.toString());
      for(int i=0;i<value.data.length;i++){
        userFormList.add(GetUserFormData(city:value.data[i]["city"],
        contactNo: value.data[i]["contactNo"], 
        iV: value.data[i][""], 
         name: value.data[i]["name"], 
         remarks: value.data[i]["remarks"], sId: value.data[i]["_id"], selectedEmoji: value.data[i]["selectedEmoji"],));
      }
   
      isSuccess = true;
      setLoading(false);
      notifyListeners();

      return isSuccess;
    }).onError((error, stackTrace) {
      var err = jsonDecode(error.toString())["error"];
      setLoading(false);
      print("The error is ${err.toString()}");
      isSuccess = false;
      notifyListeners();

      return isSuccess;
    });
    return isSuccess;
  }
 List<String> userList=[];
  Future<dynamic> getAllUsers(BuildContext context) async {
    userList.clear();
   // setLoading(true);

    await _myService
        .networkGet(
            url: "https://signin-jlq2.onrender.com/api/admin/users",
            token: adminToken)
        .then((value) {
      var res = (value.toString());
        for(int i=0;i<value.data.length;i++){
        userList.add(value.data[i]["username"]);
      }
      isSuccess = true;
       setLoading(false);
      notifyListeners();

      return isSuccess;
    }).onError((error, stackTrace) {
      var err = jsonDecode(error.toString())["error"];
      setLoading(false);
      print("The error is ${err.toString()}");
      isSuccess = false;
      notifyListeners();

      return isSuccess;
    });
    return isSuccess;
  }

   Future<dynamic> sendBroadCastMessage(
      String message, File? excelSheet, BuildContext context) async {
    bool isSuccess = false;

    setLoading(true);
var data = FormData.fromMap({
  'files': [
    await MultipartFile.fromFile(excelSheet?.path??"", filename: "excel")
  ],
  'message': message,
});
    await _myService.networkPost(
      url: "https://signin-jlq2.onrender.com/api/admin/broadcast",
      token: adminToken,
      data: data,
    ).then((value) {
      var res = jsonDecode(value.toString());
      debugPrint(res.toString());
      isSuccess = true;
      notifyListeners();
    }).onError((error, stackTrace) {
      var err = jsonDecode(error.toString())["error"];
      setLoading(false);
      isSuccess = false;
      print("The error is ${err.toString()}");
      notifyListeners();
    });
    return isSuccess;
  }
}


