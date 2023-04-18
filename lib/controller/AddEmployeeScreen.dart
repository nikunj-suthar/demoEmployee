
import 'package:demo_employee/model/common/FireStoreConf.dart';
import 'package:demo_employee/model/common/ToastHelper.dart';
import 'package:demo_employee/view/textfield/CustomTextField.dart';
import 'package:flutter/material.dart';

class AddEmployeeScreen extends StatefulWidget {

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {

  var nameCont=TextEditingController();
  var desgCont=TextEditingController();

  Future<bool?> validation(){
    if(nameCont.text.isEmpty){
      ToastHelper(message: "Enter name");
      return Future.value(false);
    }
    else if(desgCont.text.isEmpty){
      ToastHelper(message: "Enter designation");
      return Future.value(false);
    }
    return Future.value(true);
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
        title: Text("Add Employee"),
        elevation: 2,
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.only(left: 20,
            right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                      controller: nameCont,
                      hintText: "Enter name",
                    ),
                    SizedBox(height: 30),
                    CustomTextField(
                      controller: desgCont,
                      hintText: "Enter designation",
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
                             var map={"name":nameCont.text,"designation":desgCont.text};
                             FireStoreConf().usercollectionReference.add(map).then((value){
                               FireStoreConf().usercollectionReference.doc(value.id).update({"id":value.id});
                             });
                             Navigator.of(context).pop();
                           }
                         });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Add")
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
