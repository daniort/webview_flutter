import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple/loginstate.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginState>(
        create: (BuildContext context) => LoginState(),
        child: MaterialApp(
          title: 'Sample',
          home: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _state = Provider.of<LoginState>(context, listen: true);
    _state.onLoading();
    return Scaffold(
      bottomSheet: _state.isloading()
          ? LinearProgressIndicator(backgroundColor: Colors.red)
          : SizedBox(),
      appBar: AppBar(
        title: Text('Example'),
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Expanded(
            child: WebView(
              onPageStarted: (String url) {
                print('>>>>>>>>>>>>>Page started loading: $url');
              },
              onPageFinished: (String url) {
                _state.offLoading();
                print('>>>>>>>>>>>>>>Page finished loading: $url');
              },
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
                _state.offLoading();
              },
              initialUrl: 'https://flutter.dev/',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ],
      ),
    );
  }
}
