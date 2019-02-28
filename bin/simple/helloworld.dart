import 'dart:async';
import 'dart:io';
import 'package:recommender_list/recommender_list.dart';

Future<String> createSome(DateTime dt, ) => Future(() => dt.toString());

void main() async{
  print('Hello, World!');
  Directory directory = Directory.current;
  print('current directory is ${directory.path}');

  var awesome = Awesome();
  print('awesome: ${awesome.isAwesome}');

  var r=await createSome(DateTime.now());
  print(r);
}
