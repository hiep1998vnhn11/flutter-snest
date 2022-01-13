import 'package:http/http.dart' as http;
import 'package:snest/utils/const.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

const Map<String, dynamic> defaultParams = {};
const Map<String, bool> defaultOptions = {'withAuth': true};

class HttpService {
  static Future<dynamic> get(
    String url, [
    Map<String, dynamic> queryParameters = defaultParams,
    Map<String, bool> options = defaultOptions,
  ]) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      http.Response res = await http.get(
        Uri.http(
            Constants.apiHost, "${Constants.apiPrefix}$url", queryParameters),
        headers: {
          'Accept': 'application/json',
          'Authorization': options['withAuth'] == true ? 'Bearer $token' : '',
        },
      );
      Map<String, dynamic> json = jsonDecode(res.body);
      int? code = json['status'];
      String message = json['message'];
      var data = json['data'];
      if (code != 0) {
        throw Exception(message);
      }
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> post(String url,
      [Map<String, dynamic>? params = defaultParams,
      Map<String, bool> options = defaultOptions]) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      http.Response res = await http.post(
          Uri.http(Constants.apiHost, "${Constants.apiPrefix}$url"),
          headers: {
            'Accept': 'application/json',
            'Authorization': options['withAuth'] == true ? 'Bearer $token' : '',
          },
          body: params);
      Map<String, dynamic> json = jsonDecode(res.body);
      int? code = json['status'];
      String? message = json['message'];
      var data = json['data'];
      if (code != 0) {
        throw Exception(message);
      }
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
