import 'package:flutter/material.dart';
import 'package:metriport_flutter/web_view.dart';

void main() => runApp(const WebViewExample());

class WebViewExample extends StatelessWidget {
  const WebViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter WebView example')),
        body: const Column(
          children: [
            Expanded(
              child: WebView(
                clientApiKey: "CLIENT_API_KEY",
                token: "CONNECT_TOKEN",
                colorMode: "dark",
                customColor: "green",
                sandbox: false,
                providers: ["fitbit", "cronometer"],
              ),
            )
          ],
        ),
      ),
    );
  }
}
