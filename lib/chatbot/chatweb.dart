import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ChatBotWebView extends StatefulWidget {
  const ChatBotWebView({super.key});

  @override
  State<ChatBotWebView> createState() => _ChatBotWebViewState();
}

class _ChatBotWebViewState extends State<ChatBotWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat Bot'),
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(
            url:
                WebUri.uri(Uri.parse("https://animal-chatbot-fe.netlify.app/")),
          ),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              javaScriptEnabled: true,
              mediaPlaybackRequiresUserGesture: false,
            ),
          ),
        ));
  }
}
