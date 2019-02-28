import 'package:catalog/common/grpc_commons.dart';
import 'package:catalog/model/google/protobuf/empty.pb.dart';
import 'package:catalog/model/hello.pb.dart';
import 'package:catalog/model/hello.pbgrpc.dart';

class HelloService {
  static Future<ResponseHello> SayHello() async{
    var client = HelloServiceClient(GrpcClientSingleton().client);
    return await client.sayHello(Empty());
  }
}
