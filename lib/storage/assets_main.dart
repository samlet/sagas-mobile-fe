import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sagas_meta/sagas_meta.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: _loadAssets,
          child: Text('Load entity prefabs'),
        ),
      ),
    ),
  ));
}

void _loadAssets() async {
  /*
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int counter = (prefs.getInt('counter') ?? 0) + 1;
  print('Pressed $counter times.');
  await prefs.setInt('counter', counter);
  */
  // ByteData bytes = await rootBundle.load('assets/placeholder.png');
  // ByteData data = await rootBundle.load(join("assets", "ofbizDemo.data"));
  ByteData data = await rootBundle.load('data/prefabs/ofbizDemo.data');
  List<int> contents =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  print('The file is ${contents.length} bytes long.');

  var protoData=TaRecordset.fromBuffer(contents);
  print("....");
  print(protoData);
}
