import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pogmaster/config/config.dart';

class Histroy extends StatefulWidget {
  _Histroy createState() => _Histroy();
}

class _Histroy extends State<Histroy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("alarms")
              .where("finalPaid", isEqualTo: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xffdaa520),
                ),
              );
            }
            if (snapshot.hasError)
              return Center(
                child: Text("Some error came"),
              );
            if (!snapshot.hasData) {
              return Center(child: Text("No data available"));
            }
            return ListView(
              children: snapshot.data.docs.map((document) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        width: Config.screenWidth,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Neartest Location :  " +
                                  document.data()['nearestLocation'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Marmelad",
                                //  fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Problem Of TheVehicle :  " +
                                  document.data()['problemOfTheVehicle'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Marmelad",
                                //  fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Vehicle Number :  " +
                                  document.data()['vehicleNumber'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Marmelad",
                                // fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Driver Name :  " +
                                  document.data()['nameOfTheDriver'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Marmelad",
                                // fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Driver Contact Number :  " +
                                  document.data()['driverContactNumber'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Marmelad",
                                // fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Created Date :  " +
                                  document.data()['createdDate'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Marmelad",
                                //fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Ammout : " +
                                  document
                                      .data()['amountToBePaid']
                                      .toDouble()
                                      .toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Marmelad",
                                //fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "PaymentId : " + document.data()['paymentId'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Marmelad",
                                //fontSize: 20,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Spare Parts : " + document.data()["spearParts"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Marmelad",
                                fontSize: 18,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      elevation: 10,
                    ),
                  ],
                );
              }).toList(),
            );
          }),
    );
  }
}
