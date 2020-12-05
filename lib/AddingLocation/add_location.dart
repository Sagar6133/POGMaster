import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pogmaster/config/config.dart';

class Location extends StatefulWidget{
  _Location createState()=> _Location();
}

class _Location extends State<Location>{
  final _ref=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context){
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
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
              smsCodeDailog(context);
            },
          )
        ],
        title: Text("Locations",
          style:TextStyle(
            fontFamily: "Marmelad",
            fontSize: 25,
            color:Color(0xffdaa520),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _ref.collection("Location").snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError) return Center(child: Text("Some Error Came"),);
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(backgroundColor: Color(0xffdaa520),),);
          }
          return ListView(
             children: snapshot.data.docs.map((document){
               return Card(
                 child: Container(
                   child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                     Row(
                       mainAxisAlignment:MainAxisAlignment.center,
                       children: <Widget>[
                         Text(document.data()["location"],
                           style: TextStyle(
                             fontFamily: "Marmelad",
                             fontSize: 18,
                             color:Colors.black,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         FlatButton(
                           child: Text("Edit",style: TextStyle(color: Colors.blue),),
                           onPressed: (){
                             editLoc(context,document.data()["location"],document.id);
                           },
                         ),
                         FlatButton(
                           child: Text("Delete",style: TextStyle(color: Colors.blue),),
                           onPressed: (){
                             _ref.collection("Location").doc(document.id).delete();
                           },
                         ),
                       ],
                     ),
                  ]
                  ),
                 ),
               );
             }).toList()
          );
        }
      ),
    );
  }
  Future<bool> smsCodeDailog(BuildContext context){
    var loc;
    return  showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return WillPopScope(
            child: AlertDialog(
              title: Text("Enter New Location",
                style: TextStyle(
                  color: Color(0xffdaa520),
                ),
                textAlign: TextAlign.center,
              ),
              content: Container(
                height: Config.screenHeight/4,
               child :Column(
                children: [
                  TextField(
                    onChanged: (value){
                      loc=value;
                    },
                    textAlign: TextAlign.center,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      fillColor:Color(0xffdaa520),
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
                          if(loc!=null){
                            try {
                              Map<String,dynamic> alarm= {
                                "location":loc.trim()
                              };
                              _ref.collection("Location").add(alarm).then((value) => Navigator.of(context).pop());
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
  Future<bool> editLoc(BuildContext context,String locExist,String id){
    var loc;
    return  showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return WillPopScope(
            child: AlertDialog(
              title: Text("Edit Location",
                style: TextStyle(
                  color: Color(0xffdaa520),
                ),
                textAlign: TextAlign.center,
              ),
              content: Container(
                height: Config.screenHeight/4,
                child :Column(
                  children: [
                    TextField(
                      onChanged: (value){
                        loc=value;
                      },
                      textAlign: TextAlign.center,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        fillColor:Color(0xffdaa520),
                      ),
                      controller: TextEditingController(text: locExist),
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
                            if(loc!=null){
                              try {
                                _ref.collection("Location").doc(id).update({"location":loc}).then((value) => Navigator.of(context).pop());
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