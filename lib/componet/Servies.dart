import 'dart:convert';
import 'dart:math';
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
      final response = await http.post('https://app.minor.li/basti/register.php',headers: headers,body: data);
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

  //user login
  static Future<String> loginUser(
      String _email,
      String _password,
      ) async {
    try {

      var map = Map<String, dynamic>();
      map["email"] = _email;
      map["password"] = _password;
      final data = json.encode(map);
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post('https://app.minor.li/basti/login.php',headers: headers,body: data);
      print(response.statusCode.toString());
        return response.statusCode.toString();


    } catch (e) {
      return "error";
    }
  }

  //email_verify
  static Future<String> emailVerify(
      String _email,

      ) async {
    try {
      print(_email);
      final _random = new Random();
      int next(int min, int max) => min + _random.nextInt(max - min);

      String _vCode = next(1000,9999).toString();
      print(_vCode);

      var map = Map<String, dynamic>();
      map["email"] = _email;
      map['vCode'] = _vCode;
      final data = json.encode(map);
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post('https://app.minor.li/basti/mailler.php',
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

  static Future<String> checkEmailStatus(
      String _email,

      ) async {
    try {
      print(_email);

      var map = Map<String, dynamic>();
      map["email"] = _email;
      final data = json.encode(map);
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post('https://app.minor.li/basti/checkVerifyStatus.php',
          headers: headers,
          body: data);

      print('addUser Response: ${response.body}');
      if (response.body == "1") {
        return "1";
      } else if (response.body == "0") {
        return "0";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> updateEmailStatus(
      String _email,
      String vCode,
      ) async {
    try {
      print(_email);

      var map = Map<String, dynamic>();
      map["email"] = _email;
      map["vCode"] = vCode;

      final data = json.encode(map);
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post('https://app.minor.li/basti/updateEmailCode.php',
          headers: headers,
          body: data);
      print('Response: ${response.body}');
      if (response.body == "1") {
        return "1";
      } else if (response.body == "0") {
        return "0";
      }
    } catch (e) {
      return "error";
    }
  }

}