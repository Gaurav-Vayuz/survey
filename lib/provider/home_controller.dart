import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:survey/network/networking.dart';
import 'package:survey/utils/navigation_service.dart';

import '../network/api_url.dart';

class HomeController extends ChangeNotifier {
  final _myService = Networking();
  bool loading = false;

  setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  bool isSuccess = false;
  Future<dynamic> signIn(
      String userId, String password, BuildContext context) async {
    setLoading(true);

    await _myService.networkPost(
      url: Apiurl.signInUrl,
      data: {
        "userId": userId,
        "password": password,
      },
    ).then((value) {
      var res = jsonDecode(value.toString());
      debugPrint(res.toString());
      isSuccess = true;
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

  Future<dynamic> submitEmoji(String emojiType, BuildContext context) async {
    setLoading(true);
  bool isSuccess=false;
    await _myService.networkPost(
      url: Apiurl.selectEmoji,
      data: {"emojiType": emojiType},
    ).then((value) {
      var res = jsonDecode(value.toString());
      debugPrint(res.toString());
      isSuccess=true;
      notifyListeners();
    }).onError((error, stackTrace) {
      var err = jsonDecode(error.toString())["error"];
      setLoading(false);
      print("The error is ${err.toString()}");
      isSuccess=false;
      notifyListeners();
    });
    return isSuccess;
  }

  Future<dynamic> submitForm(String name, String contactNumber, String city,
      String remarks, BuildContext context) async {
        bool isSuccess =false;
    setLoading(true);
  
    await _myService.networkPost(
      url: Apiurl.submitForm,
      data: {
        "name": name,
        "contactNo": contactNumber,
        "city": city,
        "remarks": remarks
      },
    ).then((value) {
      var res = jsonDecode(value.toString());
      debugPrint(res.toString());
      isSuccess=true;
      notifyListeners();
    }).onError((error, stackTrace) {
      var err = jsonDecode(error.toString())["error"];
      setLoading(false);
      isSuccess=false;
      print("The error is ${err.toString()}");
      notifyListeners();
    });
  return isSuccess;
  }
}
