import 'package:dart_amqp/dart_amqp.dart';
import 'package:sagas_meta/src/services/common_services_test.dart';
import 'package:sagas_meta/src/srv_api.dart';

void main() async{
  SrvClient client = new SrvClient(client:Client());
  var r=await CommonServicesTest(client).testScv(defaultValue: 1.0, message: 'hi');
  print(r);

  await client.close();
}

