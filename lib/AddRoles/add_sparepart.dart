import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sparepart extends StatefulWidget{
  _Sparepart createState() => _Sparepart();
}
class _Sparepart extends State<Sparepart>{
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
             sparepartRedg(context);
           },
         )
       ],
       title: Text("Spareparts",
         style:TextStyle(
           fontFamily: "Marmelad",
           fontSize: 25,
           color:Color(0xffdaa520),
           fontWeight: FontWeight.bold,
         ),
       ),
     ),
     body: StreamBuilder(
       stream: _ref.collection("SparePartsShop").snapshots(),
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
                           Text(document.data()["shopName"],
                             style: TextStyle(
                               fontFamily: "Marmelad",
                               fontSize: 18,
                               color: Colors.black,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           Text(document.data()["shopPhoneNumber"],
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
                             //  editMechBio(context,document.data()["mechanicName"],document.data()["nearestLocation"],document.data()["mechanicPhoneNumber"],document.id);
                             },
                           ),
                           FlatButton(
                             child: Text("Delete",style: TextStyle(color: Colors.blue),),
                             onPressed: (){
                               _ref.collection("SparePartsShop").doc(document.id).delete();
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
  Future<bool> sparepartRedg(BuildContext context){
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
                          hintText: "Spare Part Shop Name"
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
                          hintText: "Shop Phone Number"
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
                                  "shopName":mech.trim(),
                                  "shopPhoneNumber":mechNumb.trim(),

                                };
                                _ref.collection("SparePartsShop").add(mechanic).then((value){
                                  if(value.id!=null){
                                    Center(child: CircularProgressIndicator(backgroundColor: Color(0xffdaa520),),);
                                    Navigator.of(context).pop();
                                    setState(() {
                                  //    selectedLocation=null;
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
                         // selectedLocation=null;
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