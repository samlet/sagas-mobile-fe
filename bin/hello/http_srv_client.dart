import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

void main() async {
  String method="echo";
  Map<String,Object> params={"value": 5, "message": "hello world"};
  var result=await invoke(method, params);
  print(result);
  if (result.errCode == 0) {
    print('ok');
  } else {
    print('got a error');
  }
}

final httpClient = new http.Client();

Future<Result> invoke(String method, Map<String,Object> params) async{
  final response = await httpClient.post(
      'http://localhost:8099/rpc/$method',
      body: json.encode(params)
  );

  if (response.statusCode == 200) {
    // final data = json.decode(response.body) as List;
    final jsonResponse = json.decode(response.body) as Map;
    // print(jsonResponse);
    int errCode = jsonResponse['_result'];

    return Result()
      ..statusCode=response.statusCode
      ..errCode=errCode
      ..data=jsonResponse
    ;
  }else{
    print(response.statusCode);
    return Result()
      ..statusCode=response.statusCode
      ..errCode=2
      ..data={}
    ;
  }
}

class Result{
  int statusCode;

  int errCode;

  Map data;
  @override
  String toString() {
    return 'Result{statusCode: $statusCode, errCode: $errCode, data: $data}';
  }
}

