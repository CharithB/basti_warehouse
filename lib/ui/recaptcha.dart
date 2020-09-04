import 'package:flutter/material.dart';

import 'flutter_recaptcha_v2.dart';
import 'login_page.dart';

class ReCaptcha extends StatefulWidget {
  @override
  _ReCaptchaState createState() => _ReCaptchaState();
}

class _ReCaptchaState extends State<ReCaptcha> {
  String verifyResult = "";

  RecaptchaV2Controller recaptchaV2Controller = RecaptchaV2Controller();

  @override
  void initState() {
    recaptchaV2Controller.show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _moveToLastScreen,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            RecaptchaV2(
              apiKey: "6Le-7sQZAAAAAAj18Upw6_sgiExFtOc3Bv3PLAfr",
              apiSecret: "6Le-7sQZAAAAACHsLBjyZjip9fmGeaPX7A-OWio1",
              controller: recaptchaV2Controller,
              onVerifiedError: (err) {
                print(err);
              },
              onVerifiedSuccessfully: (success) {
                setState(() {
                  if (success) {
                    verifyResult = "You've been verified successfully.";
                  } else {
                    verifyResult = "Failed to verify.";
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _moveToLastScreen() {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      //page redirect to UserProfile and pass logged user email
    );
  }
}
