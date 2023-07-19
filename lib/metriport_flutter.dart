import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  final String clientApiKey;
  final String token;
  final bool sandbox;
  final String? colorMode;
  final String? customColor;
  final List<String>? providers;
  final String? url;
  final String? apiUrl;

  const WebView({
    required this.clientApiKey,
    required this.token,
    required this.sandbox,
    this.colorMode,
    this.customColor,
    this.providers,
    this.url,
    this.apiUrl,
    key,
  }) : super(key: key);

  @override
  State<WebView> createState() => WebViewState();
}

class WebViewState extends State<WebView> {
  late final WebViewController controller;

  static const StandardMessageCodec _decoder = StandardMessageCodec();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = {
      "clientApiKey": widget.clientApiKey,
      "token": widget.token,
      "sandbox": widget.sandbox,
      "colorMode": widget.colorMode,
      "customColor": widget.customColor,
      "providers": widget.providers,
      "url": widget.url,
      "apiUrl": widget.apiUrl,
      "key": widget.key,
    };

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        String url = widget.url ?? "https://connect.metriport.com";
        url = url = "$url?token=${widget.token}";
        url = widget.sandbox ? "$url&sandbox=true" : url;

        if (widget.colorMode != null) {
          url = "$url&colorMode=${widget.colorMode}";
        }

        if (widget.customColor != null) {
          url = "$url&customColor=${widget.customColor}";
        }

        if (widget.providers != null) {
          var providersStr = widget.providers?.join(',');

          url = "$url&providers=$providersStr";
        }

        controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(url));

        return Scaffold(
          body: WebViewWidget(
            controller: controller,
          ),
        );
      case TargetPlatform.iOS:
        return UiKitView(
            viewType: 'MetriportWebView',
            creationParams: args,
            creationParamsCodec: _decoder);
      default:
        return Text(
            '$defaultTargetPlatform is not yet supported by the web_view plugin');
    }
  }
}
