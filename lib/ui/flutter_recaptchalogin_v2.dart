library flutter_recaptcha_v2;

import 'package:bastiwarehouse/ui/login_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bastiwarehouse/style/theme.dart' as Theme;
import 'dart:convert';
import 'home.dart';

class ReCaptchaLoginV2 extends StatefulWidget {
  final String apiKey;
  final String apiSecret;
  final String pluginURL = "https://recaptcha-flutter-plugin.firebaseapp.com/";
  final ReCaptchaLoginV2Controller controller;

  final ValueChanged<bool> onVerifiedSuccessfully;
  final ValueChanged<String> onVerifiedError;
  String status;
  ReCaptchaLoginV2({
    this.status,
    this.apiKey,
    this.apiSecret,
    ReCaptchaLoginV2Controller controller,
    this.onVerifiedSuccessfully,
    this.onVerifiedError,
  })  : controller = controller ?? ReCaptchaLoginV2Controller(),
        assert(apiKey != null, "Google ReCaptcha API KEY is missing."),
        assert(apiSecret != null, "Google ReCaptcha API SECRET is missing.");

  @override
  State<StatefulWidget> createState() => _ReCaptchaLoginV2State(status);
}

class _ReCaptchaLoginV2State extends State<ReCaptchaLoginV2> {
  String status;
  _ReCaptchaLoginV2State(this.status);
  ReCaptchaLoginV2Controller controller;
  WebViewController webViewController;

  void verifyToken(String token) async {
    String url = "https://www.google.com/recaptcha/api/siteverify";
    http.Response response = await http.post(url, body: {
      "secret": widget.apiSecret,
      "response": token,
    });
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      if (json['success']) {
        widget.onVerifiedSuccessfully(true);
      } else {
        widget.onVerifiedSuccessfully(false);
        widget.onVerifiedError(json['error-codes'].toString());
      }
    }

    // hide captcha
    controller.hide();
  }

  void onListen() {
    if (controller.visible) {
      if (webViewController != null) {
        webViewController.clearCache();
        webViewController.reload();
      }
    }
    setState(() {
      controller.visible;
    });
  }

  @override
  void initState() {
    controller = widget.controller;
    controller.addListener(onListen);
    super.initState();
  }

  @override
  void didUpdateWidget(ReCaptchaLoginV2 oldWidget) {
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(onListen);
      controller = widget.controller;
      controller.removeListener(onListen);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.removeListener(onListen);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controller.visible
        ? Stack(
      children: <Widget>[
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            child: WebView(
              initialUrl: "${widget.pluginURL}?api_key=${widget.apiKey}",
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: <JavascriptChannel>[

                JavascriptChannel(
                  name: 'RecaptchaFlutterChannel',
                  onMessageReceived: (JavascriptMessage receiver) async {
                    
                    String _token = receiver.message;
                    if (_token.contains("verify")) {

                      _token = _token.substring(7);
                      print(_token);
                    }
                   verifyToken(_token);
                    },
                ),
              ].toSet(),
              onWebViewCreated: (_controller) {
                webViewController = _controller;
              },
            ),
          ),
        ),
      ],
    )
        : Container();
  }
}

class ReCaptchaLoginV2Controller extends ChangeNotifier {
  bool isDisposed = false;
  List<VoidCallback> _listeners = [];

  bool _visible = false;

  bool get visible => _visible;

  void show() {
    _visible = true;
    if (!isDisposed) notifyListeners();
  }

  void hide() {
    _visible = false;
    if (!isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    _listeners = [];
    isDisposed = true;
    super.dispose();
  }

  @override
  void addListener(listener) {
    _listeners.add(listener);
    super.addListener(listener);
  }

  @override
  void removeListener(listener) {
    _listeners.remove(listener);
    super.removeListener(listener);
  }
}
