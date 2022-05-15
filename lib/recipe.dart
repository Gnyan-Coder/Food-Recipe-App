import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class Recipe extends StatefulWidget {
  // const Recipe({Key? key}) : super(key: key);
  String url;
  Recipe(this.url);

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  late String finalUrl;
  final Completer<WebViewController> controller=Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    if(widget.url.toString().contains("http://")){
      finalUrl=widget.url.toString().replaceAll("http", "https");
    }else{
      finalUrl=widget.url;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RECIPE"),
        centerTitle: true,
      ),
      body: Container(
        child: WebView(
          initialUrl:finalUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController){
            setState(() {
              controller.complete(webViewController);
            });
          },
        ),
      ),
    );
  }
}
