import 'package:detaillsapp/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {

  TextEditingController namecontroller     =   new TextEditingController();
  TextEditingController agecontroller      =   new TextEditingController();
  TextEditingController locationcontroller =   new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:

        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Employee', style: TextStyle(
              color: Colors.purpleAccent, fontWeight: FontWeight.w700,
              fontSize: 24,
            ),),
            Text('Form', style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.w700,
              fontSize: 24,
            ),)
          ],
        ),
      ),

      body: Container(
          margin: EdgeInsets.fromLTRB(34, 24, 10, 34),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('NAME', style: TextStyle(
            fontSize: 24,fontWeight: FontWeight.w900,
            color: Colors.blue,
          ),),

          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.only(left:10),
            decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: namecontroller,
              decoration:   InputDecoration(border: InputBorder.none),
            ),
          ),

          SizedBox(height: 8,),

          Text('AGE', style: TextStyle(
            fontSize: 22,fontWeight: FontWeight.w900,
            color: Colors.purpleAccent,
          ),),

          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.only(left:10),
            decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: agecontroller,
              decoration:   InputDecoration(border: InputBorder.none),
            ),
          ),

          SizedBox(height: 8,),

          Text('LOCATION', style: TextStyle(
            fontSize: 22,fontWeight: FontWeight.w900,
            color: Colors.redAccent,

          ),),

          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.only(left:10),
            decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: locationcontroller,
              decoration:   InputDecoration(border: InputBorder.none),
            ),
          ),

          SizedBox(height: 30,),

         Center(
           child: ElevatedButton(onPressed: ()  async{
             String Id= randomAlphaNumeric(10);
             Map<String,dynamic> empployeeInfomap ={
               "Name":namecontroller.text,
               "Age":agecontroller.text,
               "Location":locationcontroller.text,
               "Id" : Id,

             };
             await DatabaseMethods().addEmployeeDetails(empployeeInfomap, Id).then((value) {

               Fluttertoast.showToast(
               msg: "Added Successfully",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.CENTER,
               timeInSecForIosWeb: 1,
               backgroundColor: Colors.blueAccent,
               textColor: Colors.white,
               fontSize: 14.0,
               );
             },);

           },
             child: Text('ADD',
               style: TextStyle(color: Colors.grey,
                   fontSize: 18,fontStyle: FontStyle.italic),
             ),
                  ),
         ),
      ],
    ),
    ),
    );

  }
}
