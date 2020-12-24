import 'dart:async';

import 'package:practise/model/user.dart';
import 'package:practise/services/userservices.dart';

class UserManager {
  final StreamController<int> usercount = StreamController<int>();
  Stream<int> get getusercount => usercount.stream;

  Stream<List<User>> get userslistview async* {
    yield await UserService.getuser();
  }

  UserManager() {
    userslistview.listen((list)=> usercount.add(list.length));
  }
}
