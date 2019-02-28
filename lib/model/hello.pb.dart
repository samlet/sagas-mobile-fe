///
//  Generated code. Do not modify.
//  source: hello.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, Map, override;

import 'package:protobuf/protobuf.dart' as $pb;

class ResponseHello extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('ResponseHello', package: const $pb.PackageName('model'))
    ..aOS(1, 'response')
    ..hasRequiredFields = false
  ;

  ResponseHello() : super();
  ResponseHello.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ResponseHello.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ResponseHello clone() => new ResponseHello()..mergeFromMessage(this);
  ResponseHello copyWith(void Function(ResponseHello) updates) => super.copyWith((message) => updates(message as ResponseHello));
  $pb.BuilderInfo get info_ => _i;
  static ResponseHello create() => new ResponseHello();
  static $pb.PbList<ResponseHello> createRepeated() => new $pb.PbList<ResponseHello>();
  static ResponseHello getDefault() => _defaultInstance ??= create()..freeze();
  static ResponseHello _defaultInstance;
  static void $checkItem(ResponseHello v) {
    if (v is! ResponseHello) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get response => $_getS(0, '');
  set response(String v) { $_setString(0, v); }
  bool hasResponse() => $_has(0);
  void clearResponse() => clearField(1);
}

