import 'package:dio/dio.dart';

class Networking {
  final _dio = Dio();
  late Response response;

  //Api fun for post API
  Future<dynamic> networkPost(
      {dynamic data, String? token, required String url}) async {
    final headers = {'Authorization': "$token"};

    try {
      response = await _dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      if (e is DioError) {
        throw e.response ?? "Error occured";
      } else {
        throw Exception("Error");
      }
    }
  }

  //function for network get
  Future<dynamic> networkGet(
      {dynamic data,
      String? token,
      required String url,
      dynamic params}) async {
    final headers = {'Authorization': "$token"};
    try {
      response = await _dio.get(
        url,
        queryParameters: params,
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      if (e is DioError) {
        throw e.response ?? "Error occured";
      } else {
        throw Exception("Error");
      }
    }
  }
 
}