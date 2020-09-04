import 'package:flutter/material.dart';

import 'flutter_recaptchalogin_v2.dart';

class ReCaptchaLogin extends StatefulWidget {
  @override
  _ReCaptchaLoginState createState() => _ReCaptchaLoginState();
}

class _ReCaptchaLoginState extends State<ReCaptchaLogin> {
  String verifyResult = "";

  ReCaptchaLoginV2Controller recaptchaV2Controller = ReCaptchaLoginV2Controller();

  @override
  void initState() {
    recaptchaV2Controller.show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ReCaptchaLoginV2(
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
    );
  }
}
