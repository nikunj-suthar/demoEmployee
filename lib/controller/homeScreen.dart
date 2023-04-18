
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_employee/controller/AddEmployeeScreen.dart';
import 'package:demo_employee/controller/EmployeeDetails.dart';
import 'package:demo_employee/controller/loginScreen.dart';
import 'package:demo_employee/model/common/SharePrefHelper.dart';
import 'package:demo_employee/model/common/ToastHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/common/FireStoreConf.dart';

class homeScreen extends StatefulWidget {
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {



  LogoutDailoge(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            elevation: 5,
            child: Container(
              padding: EdgeInsets.only(
                  top: 25,
                  bottom: 25,
                  right: 20,
                  left: 20
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      "Logout",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      )
                  ),
                  SizedBox(height: 30),
                  Text(
                      "Are you sure want to logout?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      )
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                fixedSize: Size(double.nan,50),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("No")
                              ],
                            )
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                fixedSize: Size(double.nan,50),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            onPressed: (){
                              RemoveFromDefault();
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>loginScreen()),
                                      (route) => false);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Yes")
                              ],
                            )
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Dashboard"),
        elevation: 2,
        actions: [
          InkWell(
              onTap: (){
                LogoutDailoge();
                // RemoveFromDefault();
              },
              child: Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Icon(Icons.logout,color: Colors.white,size: 22)))
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (conext)=>AddEmployeeScreen()));
          },
          elevation: 5,
          child: Icon(Icons.add,color: Colors.white,size: 23),
        ),
      ),
      body: Container(
        height:double.maxFinite,
        width: double.maxFinite,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FireStoreConf().usercollectionReference.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator()),
                      );
                    }

                    var tempData=[];
                    snapshot.data!.docs.forEach((element) {
                      tempData.add(element);
                    });
                    return ListView.separated(
                      itemCount: tempData.length,
                      padding: EdgeInsets.only(top: 20,
                          bottom: 20),
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EmployeeDetails(
                              id: tempData[index]["id"],
                            )));
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            margin: EdgeInsets.only(left: 20,right: 20),
                            child: Container(
                              padding: EdgeInsets.only(top: 20,bottom: 20,
                              left: 10,right: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(tempData[index]["name"],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500
                                            )
                                        ),
                                        SizedBox(height: 5),
                                        Text(tempData[index]["designation"],
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 16,
                                                fontWeight: FontWeight.w400
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                      onTap: (){
                                        FireStoreConf().usercollectionReference.doc(tempData[index]["id"]).delete();
                                        ToastHelper(message: "Record deleted successfully");
                                      },
                                      child: Icon(Icons.delete,color: Colors.red,size: 25)),
                                ],
                              ),
                            ),
                          ),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 10);
                    },
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
