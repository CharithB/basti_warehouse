import 'dart:convert';
import 'package:http/http.dart' as http;
class Services {

  static Future<String> addUser(
      String _firstName,
      String _lastName,
      String _company,
      String _email,
      String _password,
      ) async {
    try {
      var map = Map<String, dynamic>();
      map["fname"] = _firstName;
      map["lname"] = _lastName;
      map["company"] = _company;
      map["email"] = _email;
      map["password"] = _password;
      final data = json.encode(map);
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post('https://etrendsapp.000webhostapp.com/fiverr/register.php',headers: headers,body: data);
      //print('addUser Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  //user login
  static Future<String> loginUser(
      String _email,
      String _password,
      ) async {
    try {
      print(_email);
      print(_password);

      var map = Map<String, dynamic>();
      map["email"] = _email;
      map["password"] = _password;
      final data = json.encode(map);
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post('https://etrendsapp.000webhostapp.com/fiverr/login.php',
          headers: headers,
          body: data);
      print('addUser Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

}