import 'package:catalog/common/grpc_commons.dart';
import 'package:sagas_meta/src/meta/google/protobuf/empty.pb.dart';
import 'package:sagas_meta/src/meta/hello.pb.dart';
import 'package:sagas_meta/src/meta/hello.pbgrpc.dart';

class HelloService {
  static Future<ResponseHello> SayHello() async{
    var client = HelloServiceClient(GrpcClientSingleton().client);
    return await client.sayHello(Empty());
  }
}
