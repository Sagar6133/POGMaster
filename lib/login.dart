import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pogmaster/Home/Home.dart';
import 'package:pogmaster/config/config.dart';

class Login extends StatefulWidget {
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  bool isLoading = false;
  TextEditingController _number = TextEditingController();
  TextEditingController _otp = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var verificationCode;
  var smsCode;
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return isLoading
        ? CircularProgressIndicator()
        : Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              "Register Your Phone Number",
                              style:
                                  Theme.of(context).textTheme.headline6.apply(
                                        fontFamily: "Marmelad",
                                        color: Color(0xffdaa520),
                                        fontWeightDelta: 3,
                                      ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (String arg) {
                                if (arg == null) {
                                  return "please enter phone number";
                                } else if (arg.length != 10) {
                                  return "phone number should be 10 digits";
                                } else
                                  return null;
                              },
                              onChanged: (String newVal) {
                                if (newVal.length == 10) {
                                  f1.unfocus();
                                  FocusScope.of(context).requestFocus(f2);
                                  print("here");
                                  _submit();
                                }
                              },
                              // enabled: true,
                              controller: _number,
                              keyboardType: TextInputType.number,
                              keyboardAppearance: Brightness.light,
                              decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffdaa520)),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(25.7),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffdaa520)),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                labelText: "Phone Number",
                                labelStyle: TextStyle(
                                  color: Color(0xffdaa520),
                                ),
                                filled: true,
                                hintText: "Enter your phone number",
                                hintStyle:
                                    new TextStyle(color: Color(0xffdaa520)),
                                fillColor: Colors.white12,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (String arg) {
                                if (arg == null) {
                                  return "please enter OTP";
                                } else if (arg.length != 6) {
                                  return "otp should be 6 digits";
                                }
                                return null;
                              },
                              focusNode: f2,
                              onChanged: (String newVal) {
                                if (newVal.length == 6) {
                                  f2.unfocus();
                                  //FocusScope.of(context).requestFocus(f3);
                                }
                              },
                              //enabled: true,
                              controller: _otp,
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffdaa520)),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(25.7),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffdaa520)),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                labelText: "OTP",
                                labelStyle: TextStyle(
                                  color: Color(0xffdaa520),
                                ),
                                filled: true,
                                hintText: "Enter OTP e.g.123456",
                                hintStyle:
                                    new TextStyle(color: Color(0xffdaa520)),
                                fillColor: Colors.white12,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            new RaisedButton(
                              color: Color(0xffdaa520),
                              textColor: Color(0xffdaa520),
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              elevation: 10,
                              onPressed: () {
                                setState(() {
                                  smsCode = _otp.text;
                                });
                                if (_formKey.currentState.validate()) {
                                  try {
                                    AuthCredential phoneAuthCredential =
                                        PhoneAuthProvider.credential(
                                            verificationId: verificationCode,
                                            smsCode: smsCode);
                                    FirebaseAuth.instance
                                        .signInWithCredential(
                                            phoneAuthCredential)
                                        .then((user) => {
                                              if (user != null)
                                                {
                                                  CircularProgressIndicator(),
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Home()),
                                                      (route) => false)
                                                }
                                              else
                                                {
                                                  Fluttertoast.showToast(
                                                      msg: "Entered Wrong Otp")
                                                }
                                            });
                                  } catch (e) {
                                    Fluttertoast.showToast(
                                        msg: "Entered Wrong Otp");
                                  }
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Future _submit() async {
    final PhoneVerificationCompleted verificationSuccess =
        (AuthCredential credential) {
      Fluttertoast.showToast(
        msg: "OTP sent",
        backgroundColor: Color(0xffdaa520),
      );
    };

    final PhoneVerificationFailed phoneVerificationFailed =
        (FirebaseAuthException exception) {
      Fluttertoast.showToast(
        msg: "Verification failed",
        backgroundColor: Color(0xffdaa520),
      );
    };
    final PhoneCodeSent phoneCodeSent = (String verId, [int forceCodeResend]) {
      verificationCode = verId;
    };
    final PhoneCodeAutoRetrievalTimeout autoRetrivalTimeout = (String verId) {
      this.verificationCode = verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91" + _number.text,
      timeout: const Duration(seconds: 120),
      verificationCompleted: verificationSuccess,
      verificationFailed: phoneVerificationFailed,
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: autoRetrivalTimeout,
    );
  }
}
