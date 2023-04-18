
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_employee/model/common/FireStoreConf.dart';
import 'package:demo_employee/model/common/ToastHelper.dart';
import 'package:demo_employee/view/textfield/CustomTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeDetails extends StatefulWidget {
  String? id;

  EmployeeDetails({this.id});

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {

  var tasknameCont=TextEditingController();
  var descCont=TextEditingController();

  Future<bool?> validation(){
    if(tasknameCont.text.isEmpty){
      ToastHelper(message: "Enter task name");
      return Future.value(false);
    }
    else if(descCont.text.isEmpty){
      ToastHelper(message: "Enter description");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Employee Details"),
        elevation: 2,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.only(
            top: 10,
            left: 20,
            right: 20
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      controller: tasknameCont,
                      hintText: "Enter taskname",
                    ),
                    SizedBox(height: 30),
                    CustomTextField(
                      controller: descCont,
                      hintText: "Enter desc",
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
                          validation().then((value) {
                            if(value!){

                              var map={"taskname":tasknameCont.text,"description":descCont.text,
                                "empID":widget.id,"status":"Inprogress"};
                              FireStoreConf().taskcollectionReference.add(map).then((value){
                                FireStoreConf().taskcollectionReference.doc(value.id).update({"id":value.id});
                                tasknameCont.clear();
                                descCont.clear();
                              });
                            }
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Add task")
                          ],
                        )
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FireStoreConf().taskcollectionReference
                      .where("empID",isEqualTo: widget.id)
                      .snapshots(),
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

                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            // margin: EdgeInsets.only(left: 20,right: 20),
                            child: Container(
                              padding: EdgeInsets.only(top: 20,bottom: 20,
                                  left: 10,right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(tempData[index]["taskname"],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500
                                          )
                                      ),
                                      SizedBox(height: 5),
                                      Text(tempData[index]["description"],
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400
                                          )
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text("Pending",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500
                                          )
                                      ),
                                      Transform.scale(
                                        scale: 0.8,
                                        child: CupertinoSwitch(
                                            value: tempData[index]["status"]=="Inprogress"?
                                            true:false,
                                            activeColor: Colors.green,
                                            trackColor: Colors.orange,
                                            onChanged: (value){
                                              var map={"status":value?"Inprogress":"pending"};
                                              FireStoreConf().taskcollectionReference
                                                  .doc(tempData[index]["id"]).update(map);
                                            }),
                                      ),
                                      Text("In Progress",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500
                                          )
                                      ),
                                    ],
                                  )
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
