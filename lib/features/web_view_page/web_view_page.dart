import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewArgs {
  final String url;

  WebViewArgs({
    required this.url,
  });
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({
    Key? key,
  }) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final WebViewArgs args =
    ModalRoute.of(context)!.settings.arguments as WebViewArgs;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          // backgroundColor: Colors.transparent,
          // foregroundColor: Colors.transparent,
          // shadowColor: Colors.transparent,
          leading: InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child:const Icon(Icons.arrow_back_sharp),
          ),
        ),
        body:Container(
          height: MediaQuery.of(context).size.height,
          child: WebView(
            gestureNavigationEnabled: true,
            onWebViewCreated: (controller) async {
              // _controller.complete(controller);
              _controller = controller;
              print('XXxXX${await _controller.currentUrl()}');
            },
            initialUrl: args.url,
            javascriptMode: JavascriptMode.unrestricted,

          ),
        ),
      ),
    );
  }
}
