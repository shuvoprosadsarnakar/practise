import 'dart:html';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:practise/model/user.dart';
import 'package:practise/services/usermanager.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String equation = "0";
  String result = "0";
  String expression = "";
  bool isColoured = false;
  Color buttonColour;
  UserManager manager = UserManager();

  onButtonClick(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        try {
          Parser p = Parser();
          Expression exp = p.parse(equation);
          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          result = "error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation += buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, bool isColoured) {
    return Container(
      margin: EdgeInsets.all(0),
      child: FlatButton(
          child: Text(
            buttonText,
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: isColoured
              ? Color.fromARGB(205, 175, 69, 47).withOpacity(0.10)
              : null,
          padding: EdgeInsets.all(30),
          height: MediaQuery.of(context).size.height * .1,
          onPressed: () => onButtonClick(buttonText)),
    );
  }

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
        child: Column(children: <Widget>[
          Spacer(),
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                equation,
                style: TextStyle(color: Colors.white, fontSize: 48.0),
              )),
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                result,
                style: TextStyle(color: Colors.white, fontSize: 48.0),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildButton("", false),
              buildButton("", false),
              buildButton("C", true),
              buildButton("÷", true),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                  stream: manager.userslistview,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    List<User> users = snapshot.data;
                    return ListView.separated(
                      itemCount: users?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        User _user = users[index];
                        return ListTile(
                          title: Text(_user.name),
                        );
                      },
                      separatorBuilder:(context, index)=> Divider() ,
                    );
                  })
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     buildButton("7",false),
          //     buildButton("8",false),
          //     buildButton("9",false),
          //     buildButton("*",true),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     buildButton("4",false),
          //     buildButton("5",false),
          //     buildButton("6",false),
          //     buildButton("-",true),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     buildButton("1",false),
          //     buildButton("2",false),
          //     buildButton("3",false),
          //     buildButton("+",true),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     buildButton(".",false),
          //     buildButton("0",false),
          //     buildButton("⌫",true),
          //     buildButton("=",false),
          //   ],
          // ),
        ]),
      ),
    );
  }
}
