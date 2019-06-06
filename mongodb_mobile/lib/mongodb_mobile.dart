import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'carrier.dart';

class MongodbMobile {
  static const MethodChannel _channel = const MethodChannel('mongodb_mobile');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// set MongoDB appID
  static Future<String> setAppID(dynamic config) async {
    var res = await _channel.invokeMethod('setAppID', config);
    debugPrint(
        '🍎 MongodbMobile: 🍀  Stitch AppID has been set, result: 🧩🧩🧩 $res');
    return '🧩🧩🧩 appID has been set';
  }

  /// insert one document intp collection
  static Future insert(Carrier carrier) async {
    var res = await _channel.invokeMethod('insert', carrier.toJson());
    debugPrint(
        '\n\n🍎 MongodbMobile: 🍀  document inserted, result: 🧩🧩🧩🧩🧩 id::  $res  🧩🧩🧩🧩');
    return res;
  }

  /// insert one document intp collection
  static Future delete(Carrier carrier) async {
    var res = await _channel.invokeMethod('delete', carrier.toJson());
    debugPrint(
        '\n\n🍎 MongodbMobile: 🍀  document deleted, result: 🧩🧩🧩🧩🧩 :  $res  🧩🧩🧩🧩');
    return res;
  }

  /// insert one document intp collection
  static Future getOne(Carrier carrier) async {
    var res = await _channel.invokeMethod('getOne', carrier.toJson());
    debugPrint(
        '\n\n🍎 MongodbMobile: 🍀  getOne , result: 🧩🧩🧩🧩🧩 :  $res  🧩🧩🧩🧩');
    return res;
  }

  /// replace one document in collection
  static Future replace(Carrier carrier) async {
    var res = await _channel.invokeMethod('replace', carrier.toJson());
    debugPrint(
        '\n\n🍎 MongodbMobile: 🍀  document replaced, result: 🧩🧩🧩🧩🧩 :  $res  🧩🧩🧩🧩');
    return res;
  }

  /// replace one document in collection
  static Future addToArray(Carrier carrier) async {
    var res = await _channel.invokeMethod('addToArray', carrier.toJson());
    debugPrint(
        '\n\n🍎 MongodbMobile: 🍀  element added to array, result: 🧩🧩🧩🧩🧩 :  $res  🧩🧩🧩🧩');
    return res;
  }

  /// getAll - get all documents from collection
  static Future getAll(Carrier carrier) async {
    var res = await _channel.invokeMethod('getAll', carrier.toJson());
    debugPrint(
        '\n\n🍎 MongodbMobile: 🍀  records retrieved, result from call: \n\n🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩 '
        '\n\n$res\n\n🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩\n\n');
    return res;
  }

  static Future query(Carrier carrier) async {
    var res = await _channel.invokeMethod('query', carrier.toJson());
    debugPrint(
        '\n\n🍎 MongodbMobile: 🍀  query records retrieved, result from call: \n\n🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩 '
        '\n\n$res\n\n🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩\n');
    return res;
  }
}
