import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewProvider extends ChangeNotifier {
  final WebViewController _webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(NavigationDelegate(
      onProgress: (progress) {
        const Center(
          child: CircularProgressIndicator(),
        );
      },
    ))
    ..loadRequest(Uri.parse("https://www.google.com/"));

  WebViewController get webViewController => _webViewController;
}
