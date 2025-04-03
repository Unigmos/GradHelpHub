import 'package:grad_help_hub/models/request/api_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIManager {
  static final APIManager _instance = APIManager._internal();
  final String baseUrl = 'https://gradhelphubweb.onrender.com/api';

  factory APIManager() {
    return _instance;
  }

  APIManager._internal();

  Future<Map<String, dynamic>> sendRequest(ApiRequest request) async {
    try {
      final uri = Uri.parse('$baseUrl${request.endpoint}').replace(
        queryParameters: request.queryParameters,
      );

      final headers = {
        ...request.headers,
      };

      http.Response response;

      switch (request.method) {
        case 'GET':
          response = await http.get(uri, headers: headers);
          break;
        case 'POST':
          response = await http.post(
            uri,
            headers: headers,
            body: jsonEncode(request.body),
          );
          break;
        case 'PUT':
          response = await http.put(
            uri,
            headers: headers,
            body: jsonEncode(request.body),
          );
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: headers);
          break;
        default:
          throw Exception('Unsupported method: ${request.method}');
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map<String, dynamic> json =
            jsonDecode(response.body) as Map<String, dynamic>;
        json['success'] = true;
        return json;
      } else {
        Map<String, dynamic> json = {};
        json['success'] = false;
        json['error'] = response.statusCode;
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network Error: $e');
    }
  }
}
