import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  Future addEmployeeDetails(Map<String, dynamic> empployeeInfomap , String Id)
  async{
    return await FirebaseFirestore.instance.collection("Employee")
        .doc(Id)
        .set(empployeeInfomap);
  }


  Future<Stream<QuerySnapshot>>getEmployeeDetails()
  async{
    return await FirebaseFirestore.
    instance.collection("Employee").
    snapshots();
  }

Future updateEmployeeDetail(String Id , Map <String , dynamic> updateinfo)async{ ////////
    return await FirebaseFirestore.instance.collection("Employee")
        .doc(Id)
        .update(updateinfo);
}

  Future deleteEmployeeDetail(String Id )async{        ///////////
    return await FirebaseFirestore.instance.collection("Employee")
        .doc(Id);
  }
}
