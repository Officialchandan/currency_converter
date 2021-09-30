import 'dart:developer';

import 'package:dio/dio.dart';

import '../Models.dart/model.dart';

class Apiclass {
  Map<String, double>? userList;

  Future getUser() async {
    String url =
        "https://www.currency.wiki/api/currency/quotes/784565d2-9c14-4b25-8235-06f6c5029b15";

    Dio _dio = Dio();
    try {
      Response response = await _dio.get(url);

      // Map<String, dynamic> quotes = response.data;
      // users = quotes["quotes"];
      if (response.statusCode == 200) {
        DataClass userResponse = DataClass.fromJson(response.toString());
        userList = userResponse.quotes;
        log("89089493894${userList}");
        // users = userList as List<Map<String, dynamic>>;
        print('------->>>>$userList');
      } else {
        print("Invelid API");
      }
    } on DioError catch (e) {
      print(e);
    }
  }
}
