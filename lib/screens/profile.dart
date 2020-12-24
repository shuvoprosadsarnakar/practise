import 'dart:html';
import 'package:flutter/material.dart';
import 'package:practise/model/user.dart';
import 'package:practise/services/usermanager.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserManager manager = UserManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(205, 254, 171, 152),
                Color.fromARGB(255, 246, 136, 111)
              ])),
          child: StreamBuilder(
              stream: manager.userslistview,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List<User> users = snapshot.data;
                return ListView.separated(
                  itemCount: users?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    User _user = users[index];
                    return ListTile(
                      title: Text(_user.name),
                      subtitle: Text(_user.email),
                      trailing: Text(_user.phone),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                );
              })),
    );
  }
}
