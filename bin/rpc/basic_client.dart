import 'dart:io';
import 'package:catalog/common/grpc_commons.dart';
import 'package:catalog/services/hello_service.dart';

Future<String> _sayHello() async {
  var hello = await HelloService.SayHello();
  return (hello.response);
}

Future main() async {
  print('invoke rpc ...');
  Directory directory = Directory.current;
  print('current directory is ${directory.path}');

  print(await _sayHello());
  /*
  _sayHello().then((x){
    print(x);
  });
  */
  await GrpcClientSingleton().client.shutdown();
}

