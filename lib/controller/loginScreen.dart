
import 'dart:convert';

import 'package:demo_employee/controller/homeScreen.dart';
import 'package:demo_employee/model/common/SharePrefHelper.dart';
import 'package:demo_employee/model/common/ToastHelper.dart';
import 'package:demo_employee/view/textfield/CustomPasswordTextField.dart';
import 'package:demo_employee/view/textfield/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class loginScreen extends StatefulWidget {

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {


  var jsonUser="";
  var jsonPass="";

  var userNameCont=TextEditingController();
  var passwordCont=TextEditingController();

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/tempAuth.json');
    final data = await json.decode(response);
    jsonUser=data["username"];
    jsonPass=data["password"];
    print(data.toString());
  }


  Future<bool?> validation(){
    if(userNameCont.text.isEmpty){
      ToastHelper(message: "Enter username");
      return Future.value(false);
    }
    else if(passwordCont.text.isEmpty){
      ToastHelper(message: "Enter password");
      return Future.value(false);
    }
    else if(userNameCont.text!=jsonUser){
      ToastHelper(message: "username is not match");
      return Future.value(false);
    }
    else if(passwordCont.text!=jsonPass){
      ToastHelper(message: "password is not match");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.only(left: 20,
        right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login",
            style: TextStyle(
              fontSize: 30,
              color: Colors.blue
            )),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(left: 5,
              right: 5),
              child: Container(
                padding: EdgeInsets.only(left: 10,
                    right: 10,bottom: 20,top: 20),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: userNameCont,
                      hintText: "Enter username",
                    ),
                    SizedBox(height: 30),
                    CustomPasswordTextField(
                      controller: passwordCont,
                      hintText: "Enter password",
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            fixedSize: Size(300,50),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        onPressed: (){
                          validation().then((value){
                            if(value!){
                              userNameCont.clear();
                              passwordCont.clear();
                              SetIntoDefault("ISLOGIN","true");
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>homeScreen()),
                                      (route) => false);
                            }
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Login")
                          ],
                        )
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
