//import "package:test/test.dart";
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:test_api/test_api.dart';
void main() {
  test("file read", () async {
    var file = new File("./README.md");
    var lines =
    file.openRead().transform(utf8.decoder).transform(const LineSplitter());
    await for (var line in lines) {
      if (!line.startsWith('#')) {
        print(line);
      }
    }
  });
}