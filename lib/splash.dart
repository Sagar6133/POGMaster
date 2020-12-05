import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pogmaster/Home/Home.dart';
import 'package:pogmaster/login.dart';

class Splash extends StatefulWidget {
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  navigationPage() {
    setData();
  }

  Future<void> setData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          if (FirebaseAuth.instance.currentUser.uid != null) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          }
        } catch (e) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()));
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Splash()));
    }
  }

  verification() {
    print(FirebaseAuth.instance.currentUser.uid);
    Fluttertoast.showToast(msg: FirebaseAuth.instance.currentUser.uid);
    Fluttertoast.showToast(msg: FirebaseAuth.instance.currentUser.phoneNumber);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              //ବାକି ଖାତା
              child: Text(
                "POG MASTER APP",
                style: Theme.of(context).textTheme.headline3.copyWith(
                      color: Color(0xff8DBBF2),
                      fontFamily: "Pacifico",
                    ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CircularProgressIndicator(
              backgroundColor: Colors.white54,
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
