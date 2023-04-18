
import 'package:demo_employee/controller/homeScreen.dart';
import 'package:demo_employee/controller/loginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/common/SharePrefHelper.dart';

class splashScreen extends StatefulWidget {
  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  getNavigation(){
    GetFromDefault("ISLOGIN").then((value){
      if(value=="true"){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>homeScreen()),
                (route) => false);
      }
      else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>loginScreen()),
                (route) => false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getNavigation();
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
