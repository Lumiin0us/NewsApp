import 'package:flutter/material.dart';
import 'package:news_app/Providers/WebViewProvider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PageWebView extends StatefulWidget {
  const PageWebView({super.key});

  @override
  State<PageWebView> createState() => _PageWebViewState();
}

class _PageWebViewState extends State<PageWebView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WebViewProvider>(builder: (context, value, child) {
      return WebViewWidget(
        controller: value.webViewController,
      );
    });
  }
}
