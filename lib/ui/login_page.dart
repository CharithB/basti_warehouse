import 'package:bastiwarehouse/style/theme.dart' as Theme;
import 'package:bastiwarehouse/utils/bubble_indication_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeFirstName = FocusNode();
  final FocusNode myFocusNodeLastName = FocusNode();
  final FocusNode myFocusNodeCompanyName = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignUp = true;
  bool _obscureTextSignUpConfirm = true;
  bool _termsAndConditions = false;

  TextEditingController signUpEmailController = new TextEditingController();
  TextEditingController signUpFirstNameController = new TextEditingController();
  TextEditingController signUpLastNameController = new TextEditingController();
  TextEditingController signUpCompanyNameController =
      new TextEditingController();
  TextEditingController signUpPasswordController = new TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      new TextEditingController();

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        // ignore: missing_return
        onNotification: (overScroll) {
          overScroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 775.0
                ? MediaQuery.of(context).size.height
                : 800.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Theme.Colors.loginGradientStart,
                    Theme.Colors.loginGradientEnd
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 75.0),
                  child: new Image(
                      width: 250.0,
                      height: 191.0,
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/img/login_logo.png')),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: _buildMenuBar(context),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (i) {
                      if (i == 0) {
                        setState(() {
                          right = Colors.white;
                          left = Colors.black;
                        });
                      } else if (i == 1) {
                        setState(() {
                          right = Colors.black;
                          left = Colors.white;
                        });
                      }
                    },
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignIn(context),
                      ),
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignUp(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeFirstName.dispose();
    myFocusNodeLastName.dispose();
    myFocusNodeCompanyName.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Color(0xFF00CB84),
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Existing",
                  style: TextStyle(
                      color: left,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "New",
                  style: TextStyle(
                      color: right,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "Email Address",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.key,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextLogin
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 170.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.Colors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Theme.Colors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientEnd,
                        Theme.Colors.loginGradientStart
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () {
                      if (loginEmailController.text.isEmpty ||
                          loginPasswordController.text.isEmpty) {
                        showInSnackBar("Field Cannot be Empty ");
                      } else {
                        final bool isValid =
                            EmailValidator.validate(loginEmailController.text);

                        if (isValid) {
                          showInSnackBar("Loging...");
                        } else {
                          showInSnackBar("Wrong Email");
                        }
                      }
                    }),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
                onPressed: () {
                  _openPopup(context);
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: "WorkSansMedium"),
                )
                ),
          ),
//===================================================================== or ==========================================================================
//          Padding(
//            padding: EdgeInsets.only(top: 10.0),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Container(
//                  decoration: BoxDecoration(
//                    gradient: new LinearGradient(
//                        colors: [
//                          Colors.white10,
//                          Colors.white,
//                        ],
//                        begin: const FractionalOffset(0.0, 0.0),
//                        end: const FractionalOffset(1.0, 1.0),
//                        stops: [0.0, 1.0],
//                        tileMode: TileMode.clamp),
//                  ),
//                  width: 100.0,
//                  height: 1.0,
//                ),
//                Padding(
//                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
//                  child: Text(
//                    "Or",
//                    style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 16.0,
//                        fontFamily: "WorkSansMedium"),
//                  ),
//                ),
//                Container(
//                  decoration: BoxDecoration(
//                    gradient: new LinearGradient(
//                        colors: [
//                          Colors.white,
//                          Colors.white10,
//                        ],
//                        begin: const FractionalOffset(0.0, 0.0),
//                        end: const FractionalOffset(1.0, 1.0),
//                        stops: [0.0, 1.0],
//                        tileMode: TileMode.clamp),
//                  ),
//                  width: 100.0,
//                  height: 1.0,
//                ),
//              ],
//            ),
//          ),
//=======================================================================================================================================================
//=============================================Facebook and Google Buttons Disabled======================================================================
//          Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Padding(
//                padding: EdgeInsets.only(top: 10.0, right: 40.0),
//                child: GestureDetector(
//                  onTap: () => showInSnackBar("Facebook button pressed"),
//                  child: Container(
//                    padding: const EdgeInsets.all(15.0),
//                    decoration: new BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
//                    child: new Icon(
//                      FontAwesomeIcons.facebookF,
//                      color: Color(0xFF0084ff),
//                    ),
//                  ),
//                ),
//              ),
//              Padding(
//                padding: EdgeInsets.only(top: 10.0),
//                child: GestureDetector(
//                  onTap: () => showInSnackBar("Google button pressed"),
//                  child: Container(
//                    padding: const EdgeInsets.all(15.0),
//                    decoration: new BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
//                    child: new Icon(
//                      FontAwesomeIcons.google,
//                      color: Color(0xFF0084ff),
//                    ),
//                  ),
//                ),
//              ),
//            ],
//          ),
//===============================================================================================================================================================
        ],
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              overflow: Overflow.visible,
              children: <Widget>[
                Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    width: 300.0,
                    height: 360.0,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextField(
                              focusNode: myFocusNodeFirstName,
                              controller: signUpFirstNameController,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.user,
                                  color: Colors.black,
                                ),
                                hintText: "First Name",
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextField(
                              focusNode: myFocusNodeLastName,
                              controller: signUpLastNameController,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.user,
                                  color: Colors.black,
                                ),
                                hintText: "Last Name",
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextField(
                              focusNode: myFocusNodeCompanyName,
                              controller: signUpCompanyNameController,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.building,
                                  color: Colors.black,
                                ),
                                hintText: "Company",
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextField(
                              focusNode: myFocusNodeEmail,
                              controller: signUpEmailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.envelope,
                                  color: Colors.black,
                                ),
                                hintText: "Email Address",
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextField(
                              focusNode: myFocusNodePassword,
                              controller: signUpPasswordController,
                              obscureText: _obscureTextSignUp,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.key,
                                  color: Colors.black,
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0),
                                suffixIcon: GestureDetector(
                                  onTap: _toggleSignUp,
                                  child: Icon(
                                    _obscureTextSignUp
                                        ? FontAwesomeIcons.eye
                                        : FontAwesomeIcons.eyeSlash,
                                    size: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                bottom: 20.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextField(
                              controller: signUpConfirmPasswordController,
                              obscureText: _obscureTextSignUpConfirm,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.key,
                                  color: Colors.black,
                                ),
                                hintText: "Confirmation",
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0),
                                suffixIcon: GestureDetector(
                                  onTap: _toggleSignUpConfirm,
                                  child: Icon(
                                    _obscureTextSignUpConfirm
                                        ? FontAwesomeIcons.eye
                                        : FontAwesomeIcons.eyeSlash,
                                    size: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CheckboxListTile(
                              value: _termsAndConditions,
                              onChanged: (val) {
                                if (_termsAndConditions == false) {
                                  setState(() {
                                    _termsAndConditions = true;
                                  });
                                } else if (_termsAndConditions == true) {
                                  setState(() {
                                    _termsAndConditions = false;
                                  });
                                }
                              },
                              title: new Text(
                                'I agree to the Terms and Conditions.',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: "WorkSansMedium"),
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: EdgeInsets.only(top: 340.0),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Theme.Colors.loginGradientStart,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                        BoxShadow(
                          color: Theme.Colors.loginGradientEnd,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                      ],
                      gradient: new LinearGradient(
                          colors: [
                            Theme.Colors.loginGradientEnd,
                            Theme.Colors.loginGradientStart
                          ],
                          begin: const FractionalOffset(0.2, 0.2),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: Theme.Colors.loginGradientEnd,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: "WorkSansBold"),
                          ),
                        ),
                        onPressed: () {
                          {
                            if (signUpFirstNameController.text.isEmpty ||
                                signUpLastNameController.text.isEmpty ||
                                signUpCompanyNameController.text.isEmpty ||
                                signUpEmailController.text.isEmpty ||
                                signUpPasswordController.text.isEmpty ||
                                signUpConfirmPasswordController.text.isEmpty) {
                              showInSnackBar("Field Cannot be Empty ");
                            } else {
                              final bool isValid = EmailValidator.validate(
                                  signUpEmailController.text);

                              if (isValid) {
                                if (_termsAndConditions.toString() == "true") {
                                  if (signUpPasswordController.text ==
                                      signUpConfirmPasswordController.text) {
                                    showInSnackBar("Welcome "+signUpFirstNameController.text);
                                    //signUpClear();
                                    _onSignInButtonPress();
                                  } else {
                                    showInSnackBar("Password Not Matched");
                                  }
                                } else {
                                  showInSnackBar("Agree to The Policy...");
                                }
                              } else {
                                showInSnackBar("Wrong Email");
                              }
                            }
                          }
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void signUpClear() {
    signUpFirstNameController.text = "";
    signUpLastNameController.text = "";
    signUpCompanyNameController.text = "";
    signUpEmailController.text = "";
    signUpPasswordController.text = "";
    signUpConfirmPasswordController.text = "";
    _termsAndConditions = false;
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 900), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 900), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignUp() {
    setState(() {
      _obscureTextSignUp = !_obscureTextSignUp;
    });
  }

  void _toggleSignUpConfirm() {
    setState(() {
      _obscureTextSignUpConfirm = !_obscureTextSignUpConfirm;
    });
  }

 void _openPopup(context) {
   var alertStyle = AlertStyle(
     animationType: AnimationType.fromTop,
     isCloseButton: true,
     isOverlayTapDismiss: false,
     descStyle: TextStyle(fontWeight: FontWeight.normal,color: Colors.grey,fontFamily: "WorkSansMedium",fontSize: 14.0,),
     animationDuration: Duration(milliseconds: 400),
     alertBorder: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(10.0),
       side: BorderSide(
         color: Colors.grey,
       ),
     ),
     titleStyle: TextStyle(
         color: Colors.black,
         fontSize: 20.0,
         fontFamily: "WorkSansMedium"),

   );
    Alert(
        context: context,
        style: alertStyle,
        title: "Forgot Your Password?",
        desc: "To recover your password, you need to enter your registered email address. We will sent the recovery code to your email",
        content: Column(
          children: <Widget>[
            TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                icon: Icon(Icons.email,color: Colors.grey),

                labelText: 'Type Your Email',labelStyle: TextStyle(
                  color:Colors.grey
              )
              ),

            ),
             ],
        ),
        buttons: [
          DialogButton(
            gradient: new LinearGradient(
                colors: [
                  Theme.Colors.loginGradientEnd,
                  Theme.Colors.loginGradientStart
                ],
                begin: const FractionalOffset(0.2, 0.2),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
            onPressed: () => Navigator.pop(context),
            child: Text(
              "REQUEST PASSWORD",

              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: "WorkSansMedium"),
            ),
          )
        ]).show();
  }
}
