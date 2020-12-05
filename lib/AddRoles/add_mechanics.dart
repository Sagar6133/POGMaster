import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Mechanic extends StatefulWidget{
  _Mechanic createState()=> _Mechanic();
}
class _Mechanic extends State<Mechanic>{
  final _ref=FirebaseFirestore.instance;
  List<String> locations=[];
  String selectedLocation;
  @override
  void initState() {
    super.initState();
    _ref.collection("Location").snapshots().listen((event) {
      event.docs.forEach((element) {
          locations.add(element.data()["location"]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar:AppBar(
       centerTitle: true,
       backgroundColor: Colors.white,
       elevation: 2,
       iconTheme: new IconThemeData(color: Color(0xffdaa520)),
       actions: <Widget>[
         IconButton(
           icon: Icon(
             Icons.add,
             size: 30,
             color: Color(0xffdaa520),
           ),
           onPressed: () {
             mechanicRedg(context);
           },
         )
       ],
       title: Text("Mechanic",
         style:TextStyle(
           fontFamily: "Marmelad",
           fontSize: 25,
           color:Color(0xffdaa520),
           fontWeight: FontWeight.bold,
         ),
       ),
     ),
     body: StreamBuilder(
       stream: _ref.collection("Mechanic").snapshots(),
       builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
         if(snapshot.hasError) return Center(child: Text("Some Error Came"),);
         if(!snapshot.hasData){
           return Center(child: CircularProgressIndicator(backgroundColor: Color(0xffdaa520),),);
         }
         return ListView(
           children:snapshot.data.docs.map((document){
             return Card(
               child: Container(
                 child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: <Widget>[
                       Column(
                         children: [
                           Text(document.data()["mechanicName"],
                             style: TextStyle(
                               fontFamily: "Marmelad",
                               fontSize: 18,
                               color: Colors.black,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           Text(document.data()["mechanicPhoneNumber"],
                             style: TextStyle(
                               fontFamily: "Marmelad",
                               fontSize: 18,
                               color:Colors.black,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           Text(document.data()["nearestLocation"],
                             style: TextStyle(
                               fontFamily: "Marmelad",
                               fontSize: 18,
                               color:Colors.black,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment:MainAxisAlignment.center,
                         children: <Widget>[
                           FlatButton(
                             child: Text("Edit",style: TextStyle(color: Colors.blue),),
                             onPressed: (){
                               editMechBio(context,document.data()["mechanicName"],document.data()["nearestLocation"],document.data()["mechanicPhoneNumber"],document.id);
                             },
                           ),
                           FlatButton(
                             child: Text("Delete",style: TextStyle(color: Colors.blue),),
                             onPressed: (){
                               _ref.collection("Mechanic").doc(document.id).delete();
                             },
                           ),
                         ],
                       ),
                     ]
                 ),
               ),
             );
           }).toList(),
         );
       },
     ),
   );
  }
  Future<bool> editMechBio(BuildContext context,String name,String loc,String phoneNumber,String id){
    String nameEdited;
    String numberEdited;
   setState(() {
     nameEdited=name;
     numberEdited=phoneNumber;
   });
    return  showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return WillPopScope(
            child: AlertDialog(
              title: Text("Edit Mechanic",
                style: TextStyle(
                  color: Color(0xffdaa520),
                ),
                textAlign: TextAlign.center,
              ),
              content:SingleChildScrollView(
                child :Column(
                  children: [
                    TextField(
                      onChanged: (value){
                        nameEdited=value;
                      },
                      textAlign: TextAlign.center,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        fillColor:Color(0xffdaa520),
                      ),
                      controller: TextEditingController(text: name),
                    ),
                    TextField(
                      onChanged: (value){
                        numberEdited=value;
                      },
                      textAlign: TextAlign.center,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor:Color(0xffdaa520),
                      ),
                      controller: TextEditingController(text: phoneNumber),
                    ),
                    FlatButton(
                      child: Text("Save",
                        style: TextStyle(
                          color: Color(0xffdaa520),
                        ),
                      ),
                      onPressed: () async{
                        CircularProgressIndicator(backgroundColor: Color(0xffdaa520),strokeWidth: 5,);
                        try {
                          final result =await InternetAddress.lookup('google.com');
                          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                            if(nameEdited!=null && numberEdited!=null){
                              try {
                                _ref.collection("Mechanic").doc(id).update(
                                    {
                                      "mechanicName":nameEdited.trim(),
                                      "mechanicPhoneNumber":numberEdited.trim()
                                    }
                                    ).then((value) => Navigator.of(context).pop());
                                setState(() {
                                  selectedLocation=null;
                                });
                              }catch(e){
                                print(e);
                              }
                            }
                          }
                        }on SocketException catch (_) {
                          Fluttertoast.showToast(msg: "No Internet Connection");
                        }
                      },
                    ),
                    FlatButton(
                      child: Text("Cancel",
                        style: TextStyle(
                          color: Color(0xffdaa520),
                        ),
                      ),
                      onPressed: (){
                        CircularProgressIndicator(backgroundColor: Color(0xffdaa520),strokeWidth: 5,);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 50),
            ),
          );
        }
    );
  }
  Future<bool> mechanicRedg(BuildContext context){
    String mech;
    String mechNumb;
    return  showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return WillPopScope(
            child: AlertDialog(
              title: Text("Add New Mechanic",
                style: TextStyle(
                  color: Color(0xffdaa520),
                ),
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                 child :Column(
                  children: [
                    DropdownButton(
                      items: locations.map(
                            (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (String val) {
                        setState(() {
                          selectedLocation=val;
                        });
                      },
                      hint: Text('Location'),
                      value:selectedLocation,
                    ),
                    TextField(
                      onChanged: (value){
                        mech=value;
                      },
                      textAlign: TextAlign.center,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        fillColor:Color(0xffdaa520),
                        hintText: "Mechanic Name"
                      ),
                    ),
                    TextField(
                      onChanged: (value){
                        mechNumb=value;
                      },
                      textAlign: TextAlign.center,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor:Color(0xffdaa520),
                        hintText: "Mechanic Phone Number"
                      ),
                    ),
                    FlatButton(
                      child: Text("Save",
                        style: TextStyle(
                          color: Color(0xffdaa520),
                        ),
                      ),
                      onPressed: () async{
                        CircularProgressIndicator(backgroundColor: Color(0xffdaa520),strokeWidth: 5,);
                        try {
                          final result =await InternetAddress.lookup('google.com');
                          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                            if(mech!=null && mechNumb!=null && selectedLocation!=null){
                              try {
                                Map<String,dynamic> mechanic= {
                                  "nearestLocation":selectedLocation,
                                  "mechanicName":mech.trim(),
                                  "mechanicPhoneNumber":mechNumb.trim(),

                                };
                                _ref.collection("Mechanic").add(mechanic).then((value){
                                  if(value.id!=null){
                                    Center(child: CircularProgressIndicator(backgroundColor: Color(0xffdaa520),),);
                                    Navigator.of(context).pop();
                                    setState(() {
                                      selectedLocation=null;
                                    });
                                  }else{
                                    Center(child: CircularProgressIndicator(backgroundColor: Color(0xffdaa520),),);
                                  }
                                });
                                return Text("done");
                              }catch(e){
                                print(e);
                              }
                            }
                          }
                        }on SocketException catch (_) {
                          Fluttertoast.showToast(msg: "No Internet Connection");
                        }
                      },
                    ),
                    FlatButton(
                      child: Text("Cancel",
                        style: TextStyle(
                          color: Color(0xffdaa520),
                        ),
                      ),
                      onPressed: (){
                        CircularProgressIndicator(backgroundColor: Color(0xffdaa520),strokeWidth: 5,);
                        setState(() {
                          selectedLocation=null;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                 ),
                 ),
              contentPadding: EdgeInsets.symmetric(horizontal: 50),
            ),
          );
        }
    );
  }
}