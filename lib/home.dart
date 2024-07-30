import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';
import 'package:detaillsapp/database.dart';
import 'employee.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController namecontroller     =   new TextEditingController();
  TextEditingController agecontroller      =   new TextEditingController();
  TextEditingController locationcontroller =   new TextEditingController();

 Stream?EmployeeStream;

 getontheload()async{
   EmployeeStream=await DatabaseMethods().getEmployeeDetails();
   setState(() {

   });
 }

 @override
  void initState() {
   getontheload();
    // TODO: implement initState
    super.initState();
  }

 Widget allEmployeeDetails(){

   // fxn call

   return StreamBuilder(stream: EmployeeStream,
       builder: (context,AsyncSnapshot snapshot){

     return snapshot.hasData? ListView.builder(

         itemCount: snapshot.data.docs.length,
         itemBuilder: (context,index){
         DocumentSnapshot ds=snapshot.data.docs[index];

         return Container(

           margin: EdgeInsets.only(bottom: 20.0),
           child: Material(
             elevation: 55.4,
             borderRadius: BorderRadius.circular(10),
             child: Container(
               width:MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                 color: Colors.grey, borderRadius: BorderRadius.circular(23),
               ),

               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,

                 children: [
                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("  Name : "+ds["Name"],style: TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.w700, fontSize: 18,
                     ),),
                     Spacer(),
                     GestureDetector (
                         onTap: (){
                           namecontroller.text=ds["Name"];
                           agecontroller.text=ds["Age"];
                           locationcontroller.text=ds["Location"];

                           EditEmployeeDetail(ds["Id"]);
                     },
                         child: Icon(Icons.edit, color: Colors.amberAccent,)),


                       GestureDetector(
                           onTap: () async{
                             await DatabaseMethods().deleteEmployeeDetail(ds["Id"]);
                           },
                           child:
                            Icon(Icons.delete, color: Colors.blueAccent)),



                     ],
                     ),
                       Text(" Age : " +ds["Age"],style: TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.w700, fontSize: 18,
                     ),
                     ),
                       Text("  location : " +ds["Location"],style: TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.w700, fontSize: 18,
                   ),
                       ),
                 ],
               ),
             ),
           ),
         );
       })
       : Container();
       });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Employee()));
      }, child: Icon(Icons.add),),

      appBar: AppBar(
        title:

        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flutter', style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.w700,
              fontSize: 24,
            ),),
            Text('Firebase', style: TextStyle(
              color: Colors.orangeAccent, fontWeight: FontWeight.w700,
              fontSize: 24,
            ),)
          ],
        ),
      ),

     body:
      Container(
        margin: EdgeInsets.fromLTRB(10, 14, 13, 20),
        child:
        Column(
          children: [
          Expanded(child:allEmployeeDetails()),
          ],
        ),
      )
    );
  }


 Future EditEmployeeDetail (String Id) => showDialog (context: context, builder:(context)=> AlertDialog(

   content: Container(
     child: Column(
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             GestureDetector(
               onTap: (){

                 Navigator.pop(context);
               },
               child: Icon(Icons.cancel,),
             ),

             Text('Edit ', style: TextStyle(
               color: Colors.blue, fontWeight: FontWeight.w700,
               fontSize: 24,
             ),),
             Text('Detail ', style: TextStyle(
               color: Colors.orangeAccent, fontWeight: FontWeight.w700,
               fontSize: 24,
              ),
             ),

           ],
         ),

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

         SizedBox(height: 20,),

         Center(
        child: ElevatedButton(onPressed: ()async{
          Map<String,dynamic> updateinfo={
            "Name": namecontroller.text,
            "Age":  agecontroller.text,
            "Id": Id,
            "Location" : locationcontroller.text,
          };
          await DatabaseMethods().updateEmployeeDetail(Id, updateinfo).then((Value){
            Navigator.pop(context);
          }
          );
        },
          child: Text("Update") ,
        ),
      )
       ],
     ),

   ),

 )

 );
}
