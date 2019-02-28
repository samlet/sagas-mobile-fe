///
//  Generated code. Do not modify.
//  source: hello.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

import 'dart:async' as $async;

import 'package:grpc/grpc.dart';

import 'google/protobuf/empty.pb.dart' as $0;
import 'hello.pb.dart';
export 'hello.pb.dart';

class HelloServiceClient extends Client {
  static final _$sayHello = new ClientMethod<$0.Empty, ResponseHello>(
      '/model.HelloService/SayHello',
      ($0.Empty value) => value.writeToBuffer(),
      (List<int> value) => new ResponseHello.fromBuffer(value));

  HelloServiceClient(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<ResponseHello> sayHello($0.Empty request,
      {CallOptions options}) {
    final call = $createCall(
        _$sayHello, new $async.Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }
}

abstract class HelloServiceBase extends Service {
  String get $name => 'model.HelloService';

  HelloServiceBase() {
    $addMethod(new ServiceMethod<$0.Empty, ResponseHello>(
        'SayHello',
        sayHello_Pre,
        false,
        false,
        (List<int> value) => new $0.Empty.fromBuffer(value),
        (ResponseHello value) => value.writeToBuffer()));
  }

  $async.Future<ResponseHello> sayHello_Pre(
      ServiceCall call, $async.Future request) async {
    return sayHello(call, await request);
  }

  $async.Future<ResponseHello> sayHello(ServiceCall call, $0.Empty request);
}
