
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreConf{
  var usercollectionReference = FirebaseFirestore.instance.collection("USERLIST");
  var taskcollectionReference = FirebaseFirestore.instance.collection("TASKLIST");
}