import 'package:currency_converter/Models/model.dart';
import 'package:dio/dio.dart';

class  Apiclass {
  static Future<Map<String, double>> getUser() async {
    String url =
        "https://www.currency.wiki/api/currency/quotes/784565d2-9c14-4b25-8235-06f6c5029b15";

    Dio _dio = Dio();
    try {
      Response response = await _dio.get(url);

      if (response.statusCode == 200) {
        DataClass userResponse = DataClass.fromJson(response.toString());
        Map<String, double> userList = userResponse.quotes!;
        return userList;
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }
}
