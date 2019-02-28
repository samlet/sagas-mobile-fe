import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MaterialDemoDocumentationButton extends StatelessWidget {
  MaterialDemoDocumentationButton(String routeName, { Key key })
      : documentationUrl = "http://hello",
        super(key: key);

  final String documentationUrl;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.library_books),
        tooltip: 'API documentation',
        onPressed: () => launch(documentationUrl, forceWebView: true)
    );
  }
}