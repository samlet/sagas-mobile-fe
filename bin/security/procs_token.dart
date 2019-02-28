import 'package:sagas_meta/src/broker_api.dart';
import 'package:sagas_meta/src/meta/forms.pb.dart';
import 'package:sagas_meta/src/meta/hello.pb.dart';
import 'package:sagas_meta/src/meta/metainfo.pb.dart';
import 'package:sagas_meta/src/meta/values.pb.dart';

Future<String> create(BrokerClient brokerClient) async{
  var entries=TaStringEntries.create()
    ..values.addAll({"name":"general", "user":"system"});
  MetaQuery query=MetaQuery.create()
    ..infoType='action'
    ..uri="SecurityManager.createToken"
    ..data=entries.writeToBuffer();
  var result=await brokerClient.invoke(query.writeToBuffer());
  var resp=MetaPayload.fromBuffer(result);
  print(resp.type);
  if(resp.type==MetaPayloadType.ACTION_RESULT) {
    // var form = MetaForm.fromBuffer(resp.body);
    var token=TaFieldValue.fromBuffer(resp.body);
    print('ok.');
    print(token);
    return token.stringVal;
  }else{
    print('err.');
    return "";
  }
}

void verify(BrokerClient brokerClient, String token) async{
  var entries=TaFieldValue.create()
    ..stringVal=token;
  MetaQuery query=MetaQuery.create()
    ..infoType='action'
    ..uri="SecurityManager.verifyToken"
    ..data=entries.writeToBuffer();
  var result=await brokerClient.invoke(query.writeToBuffer());
  var resp=MetaPayload.fromBuffer(result);
  print(resp.type);
  if(resp.type==MetaPayloadType.ACTION_RESULT) {
    var data=TaJson.fromBuffer(resp.body);
    print('ok.');
    print(data);
  }else{
    print('err.');
  }
}

void main() async{
  BrokerClient brokerClient=new BrokerClient('meta_queue');
  var token=await create(brokerClient);
  await verify(brokerClient, token);
  await brokerClient.close();
}



