import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const _url = 'https://project-backend-pi-ivory.vercel.app/api/';

  static Future<Map<String, dynamic>> fetchBladderData() async {
    final response = await http.get(Uri.parse('${_url}live'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
  static Future<Map<String, dynamic>> fetchFullData() async {
    final response = await http.get(Uri.parse('${_url}fulldata'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
