import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practise/model/user.dart';

class UserService {
  static String _url = "https://jsonplaceholder.typicode.com/users";

  static Future getuser() async {
    http.Response response = await http.get(_url);
    String content = response.body;
    List usersjson = jsonDecode(content);
    List<User> usersdart =
        usersjson.map((json) => User.fromjson(json)).toList();
    return usersdart;
  }
}
