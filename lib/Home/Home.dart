import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pogmaster/AddRoles/add_mechanics.dart';
import 'package:pogmaster/AddRoles/add_sparepart.dart';
import 'package:pogmaster/AddingLocation/add_location.dart';
import 'package:pogmaster/Home/histroy.dart';
import 'package:pogmaster/config/config.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final ref = FirebaseFirestore.instance.collection("alarms");
  TextEditingController ammount = TextEditingController();
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: new IconThemeData(color: Color(0xffdaa520)),
        title: Text(
          "Home",
          style: TextStyle(
            fontFamily: "Marmelad",
            fontSize: 25,
            color: Color(0xffdaa520),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: ref.where("finalPaid", isEqualTo: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text("Some Error Came"),
            );
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xffdaa520),
              ),
            );
          }
          return ListView(
            children: snapshot.data.docs.map((document) {
              AlarmList alarmList = AlarmList(
                document.data()['nearestLocation'],
                document.data()['problemOfTheVehicle'],
                document.data()['vehicleNumber'],
                document.data()['nameOfTheDriver'],
                document.data()['driverContactNumber'],
                document.data()['vehicleType'],
                document.data()['ownerNumber'],
                document.data()['isPaid'],
                document.data()['createdDate'],
                document.data()['amountToBePaid'].toDouble(),
                document.data()['ammountAssigned'],
                document.data()['paymentId'],
              );
              return alarmList.ammountAssigned
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Card(
                          color: Color(0xffefefcd),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            width: Config.screenWidth,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Owner Contact Number :  " +
                                      document.data()['ownerNumber'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Neartest Location :  " +
                                      document.data()['nearestLocation'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Exart Location :  " +
                                      document.data()['nearestLocation'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Problem Of TheVehicle :  " +
                                      document.data()['exartLocation'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Vehicle Number :  " +
                                      alarmList.vehicleNumber,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Driver Name :  " + alarmList.nameOfTheDriver,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Driver Contact Number :  " +
                                      alarmList.driverContactNumber,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Created Date :  " + alarmList.createdDate,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Ammout : " +
                                      alarmList.amountToBePaid.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Payment ID : " +
                                      alarmList.paymentId.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Spare Parts : " +
                                      document.data()["spearParts"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Towing : " + document.data()["towing"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                FlatButton(
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  onPressed: () {
                                    sparepartRedg(context, document.id);
                                  },
                                ),
                                FlatButton(
                                  child: Text(
                                    "Close Order",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  onPressed: () {
                                    ref
                                        .doc(document.id)
                                        .update({"finalPaid": true});
                                  },
                                ),
                              ],
                            ),
                          ),
                          elevation: 10,
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Card(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            width: Config.screenWidth,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Neartest Location :  " +
                                      alarmList.selectedNeartestLocation,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Problem Of TheVehicle :  " +
                                      alarmList.problemOfTheVehicle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Vehicle Number :  " +
                                      alarmList.vehicleNumber,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Driver Name :  " + alarmList.nameOfTheDriver,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Driver Contact Number :  " +
                                      alarmList.driverContactNumber,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Created Date :  " + alarmList.createdDate,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Ammout : " +
                                      document.data()["finalAmount"].toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Spare Parts : " +
                                      document.data()["spearParts"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Spare Parts Amounts : " +
                                      document.data()["finalAmount"].toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Towing : " + document.data()["towing"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Marmelad",
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: ammount,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    fillColor: Color(0xffdaa520),
                                    hintText: "Enter the first service amount ",
                                    hintStyle: TextStyle(
                                      color: Color(0xffdaa520),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: "Marmelad",
                                    ),
                                    focusColor: Color(0xffdaa520),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("Mechanic")
                                        .where("nearestLocation",
                                            isEqualTo: alarmList
                                                .selectedNeartestLocation)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError)
                                        return Center(
                                          child: Text("Some Error Came"),
                                        );
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor: Color(0xffdaa520),
                                          ),
                                        );
                                      }
                                      return DropdownButton(
                                        items:
                                            snapshot.data.docs.map((document) {
                                          return DropdownMenuItem<String>(
                                            value: document
                                                    .data()["mechanicName"] +
                                                " " +
                                                document.data()[
                                                    "mechanicPhoneNumber"],
                                            child: Text(document
                                                    .data()["mechanicName"] +
                                                " " +
                                                document.data()[
                                                    "mechanicPhoneNumber"]),
                                          );
                                        }).toList(),
                                        onChanged: (String val) {
                                          setState(() {});
                                        },
                                        hint: Text('Mechanic'),
                                      );
                                    }),
                                SizedBox(
                                  height: 20,
                                ),
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("SparePartsShop")
                                        .where("nearestLocation",
                                            isEqualTo: alarmList
                                                .selectedNeartestLocation)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError)
                                        return Center(
                                          child: Text("Some Error Came"),
                                        );
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor: Color(0xffdaa520),
                                          ),
                                        );
                                      }
                                      return DropdownButton(
                                        items:
                                            snapshot.data.docs.map((document) {
                                          return DropdownMenuItem<String>(
                                            value: document.data()["shopName"] +
                                                " " +
                                                document
                                                    .data()["shopPhoneNumber"],
                                            child: Text(document
                                                    .data()["shopName"] +
                                                " " +
                                                document
                                                    .data()["shopPhoneNumber"]),
                                          );
                                        }).toList(),
                                        onChanged: (String val) {
                                          setState(() {});
                                        },
                                        hint: Text('Spare Parts Shop'),
                                      );
                                    }),
                                RaisedButton(
                                  child: Text(
                                    "Submit",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  color: Color(0xffdaa520),
                                  elevation: 20,
                                  splashColor: Colors.white12,
                                  onPressed: () async {
                                    if (ammount.text != null) {
                                      ref.doc(document.id).update({
                                        "amountToBePaid":
                                            double.parse(ammount.text),
                                        "ammountAssigned": true
                                      }).then((value) => Center(
                                            child: Text("Done"),
                                          ));
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                )
                              ],
                            ),
                          ),
                          elevation: 10,
                        ),
                      ],
                    );
            }).toList(),
          );
        },
      ),
      drawer: Container(
        width: Config.screenWidth * 6 / 8,
        child: Drawer(
          elevation: 30,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xffefefcd),
                  shape: BoxShape.rectangle,
                ),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        size: 50,
                        color: Color(0xffdaa520),
                      ),
                      Text(
                        "Admin PUPU Bhai",
                        style: TextStyle(
                            color: Color(0xffdaa520),
                            fontFamily: "Marmelad",
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Add Location',
                  style: TextStyle(
                    fontFamily: "Marmelad",
                    fontSize: 17,
                    color: Color(0xffdaa520),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Location()));
                },
              ),
              ListTile(
                title: Text(
                  'Add Mechanic',
                  style: TextStyle(
                    fontFamily: "Marmelad",
                    fontSize: 17,
                    color: Color(0xffdaa520),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Mechanic()));
                },
              ),
              ListTile(
                title: Text(
                  'Add Sparepart Shop',
                  style: TextStyle(
                    fontFamily: "Marmelad",
                    fontSize: 17,
                    color: Color(0xffdaa520),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Sparepart()));
                },
              ),
              ListTile(
                title: Text(
                  'Histroy',
                  style: TextStyle(
                    fontFamily: "Marmelad",
                    fontSize: 17,
                    color: Color(0xffdaa520),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Histroy()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> sparepartRedg(BuildContext context, String id) {
    String totalParts = "";
    String ammount = "";
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            child: AlertDialog(
              title: Text(
                "Add Spare Parts details",
                style: TextStyle(
                  color: Color(0xffdaa520),
                ),
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          totalParts = value;
                        });
                      },
                      textAlign: TextAlign.center,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          fillColor: Color(0xffdaa520),
                          hintText: "Spare Part Name"),
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          ammount = value;
                        });
                      },
                      textAlign: TextAlign.center,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          fillColor: Color(0xffdaa520),
                          hintText: "total Ammount"),
                    ),
                    FlatButton(
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Color(0xffdaa520),
                        ),
                      ),
                      onPressed: () async {
                        CircularProgressIndicator(
                          backgroundColor: Color(0xffdaa520),
                          strokeWidth: 5,
                        );
                        try {
                          final result =
                              await InternetAddress.lookup('google.com');
                          if (result.isNotEmpty &&
                              result[0].rawAddress.isNotEmpty) {
                            print(totalParts);
                            print(ammount);
                            print(id);
                            if (totalParts != null && ammount != null) {
                              ref.doc(id).update({
                                "amountToBePaid": double.parse(ammount),
                                "spearParts": totalParts,
                                "ammountAssigned": true,
                                "isPaid": false
                              }).then((value) => Navigator.of(context).pop());
                            }
                          }
                        } on SocketException catch (_) {
                          Fluttertoast.showToast(msg: "No Internet Connection");
                        }
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Color(0xffdaa520),
                        ),
                      ),
                      onPressed: () {
                        CircularProgressIndicator(
                          backgroundColor: Color(0xffdaa520),
                          strokeWidth: 5,
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 50),
            ),
          );
        });
  }
}

class AlarmList {
  String selectedNeartestLocation;
  String problemOfTheVehicle;
  String vehicleNumber;
  String nameOfTheDriver;
  String driverContactNumber;
  String vehicleType;
  String ownerNumber;
  bool isPaid;
  String createdDate;
  double amountToBePaid;
  bool ammountAssigned;
  String paymentId;

  AlarmList(
    this.selectedNeartestLocation,
    this.problemOfTheVehicle,
    this.vehicleNumber,
    this.nameOfTheDriver,
    this.driverContactNumber,
    this.vehicleType,
    this.ownerNumber,
    this.isPaid,
    this.createdDate,
    this.amountToBePaid,
    this.ammountAssigned,
    this.paymentId,
  );
}
