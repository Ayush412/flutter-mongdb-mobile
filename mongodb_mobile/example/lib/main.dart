import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mongodb_mobile/carrier.dart';
import 'package:mongodb_mobile/mongodb_mobile.dart';

void main() {
  debugPrint(
      '🍎 🍎 🍎  Flutter MongoDB Mobile Platform Example App starting ... : 🧩🧩🧩');
  runApp(MongoExampleApp());
}

class MongoExampleApp extends StatefulWidget {
  @override
  _MongoExampleAppState createState() => _MongoExampleAppState();
}

class _MongoExampleAppState extends State<MongoExampleApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await MongodbMobile.platformVersion;
      debugPrint('_MyAppState: 🧩🧩🧩 Platform Version : 🍎  $platformVersion');
      var res = await MongodbMobile.setAppID({
        'appID': 'exampleApp',
        'type': 'local',
      });
      print(res);
    } on PlatformException catch (f) {
      print('👿👿👿👿👿👿👿👿 PlatformException 🍎 🍎 🍎 - $f');
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {});
  }

  Random random = Random(DateTime.now().millisecondsSinceEpoch);

  /// Add document to a collection
  Future insertDocument() async {
    debugPrint('\n\n💙 💙  inserting a typical document ....');
    dynamic result;
    try {
      var carrier = Carrier(db: 'testdb', collection: 'testCollection', data: {
        'name': 'Kassambe',
        'lastName': 'Obama',
        'wealth': random.nextInt(100000) * 1.04,
        'date': DateTime.now().toUtc().toIso8601String(),
        'desc': '💙  🍎 🍎  serve with purpose  🍎 🍎 💙'
      });
      result = await MongodbMobile.insert(carrier);
      debugPrint(
          '\n\n🧩🧩🧩🧩🧩🧩  _MyAppState: insertDocument 🧩🧩🧩 document added : 🍎 statusCode: $result\n\n\n');
      showSnackbar(
          message: ' 🧩🧩🧩  Document inserted',
          scaffoldKey: _key,
          backgroundColor: Colors.black,
          textColor: Colors.white);
    } on PlatformException catch (f) {
      print('👿👿👿👿👿👿👿👿 PlatformException 🍎 🍎 🍎 - $f');
      result = 'Failed to get platform version.';
      var d =
          "\ud83d\udc99\ud83d\udc99\ud83d\udc99 serve with purpose \ud83d\udc99\ud83d\udc99\ud83d\udc99";
    }
  }

  /// Add document to a collection
  Future addToArray() async {
    debugPrint('\n\n💙 💙 addToArray nested in  document ....');
    dynamic result;
    try {
      var carrier = Carrier(
          db: 'testdb',
          collection: 'testCollection',
          id: "5cf8a2206bc83124d1e93787",
          arrayName: "musicTracks",
          data: {
            'artist': 'Michael Jackson',
            'track': 'Crazy Suzy',
            'date': new DateTime.now().toIso8601String(),
          });
      result = await MongodbMobile.addToArray(carrier);
      debugPrint(
          '\n\n🧩🧩🧩🧩🧩🧩 _MyAppState: addToArray 🧩🧩🧩 element added to nested array : 🍎 result: $result\n\n\n');
      showSnackbar(
          message: ' 🧩🧩🧩  element added to nested array',
          scaffoldKey: _key,
          backgroundColor: Colors.black,
          textColor: Colors.lightBlue);
    } on PlatformException catch (f) {
      print('👿👿👿👿👿👿👿👿 PlatformException 🍎 🍎 🍎 - $f');
      showSnackbar(
          scaffoldKey: _key,
          message: f.message,
          textColor: Colors.yellow,
          backgroundColor: Colors.red);
    }
  }

  List documents = List();

  /// Get all documents from a collection
  Future getAllDocuments() async {
    debugPrint('\n\n💙 💙  getAllDocuments ....');
    try {
      var carrier = Carrier(db: 'testdb', collection: 'testCollection');
      documents = await MongodbMobile.getAll(carrier);
      debugPrint(
          '\n\n🍎 🍎 🍎 _MyAppState: getAllDocuments 🧩🧩🧩  retrieved : 🍎 ${documents.length} documents 🍎 \n\n\n');

      showSnackbar(
          message: '🍎 🍎 🍎  ${documents.length} documents found',
          scaffoldKey: _key,
          backgroundColor: Colors.black,
          textColor: Colors.white);
    } on PlatformException catch (f) {
      print('👿👿👿👿👿👿👿👿 PlatformException 🍎 🍎 🍎 - $f');
    }
  }

  /// Delete document from a collection
  Future delete() async {
    debugPrint('\n\n💙 💙  delete ....');
    try {
      var carrier = Carrier(
          db: 'testdb',
          collection: 'testCollection',
          id: '5cf972ec6bc831030099670d');
      var res = await MongodbMobile.delete(carrier);
      debugPrint(
          '\n\n🍎 🍎 🍎 _MyAppState:delete: 🧩🧩🧩  deleted : 🍎  : $res 🍎 \n\n\n');

      showSnackbar(
          message: '🍎 🍎 🍎  document deleted',
          scaffoldKey: _key,
          backgroundColor: Colors.black,
          textColor: Colors.white);
    } on PlatformException catch (f) {
      print('👿👿👿👿👿👿👿👿 PlatformException 🍎 🍎 🍎 - $f');
    }
  }

  /// Delete document from a collection
  Future getOne() async {
    debugPrint('\n\n💙 💙  get one doc ....');
    try {
      var carrier = Carrier(
          db: 'testdb',
          collection: 'testCollection',
          id: '5cf8e4aa6bc8315dd0a51755');
      var res = await MongodbMobile.getOne(carrier);
      debugPrint(
          '\n\n🍎 🍎 🍎 _MyAppState:delete: 🧩🧩🧩  get one : 🍎 : $res 🍎 \n\n\n');

      showSnackbar(
          message: '🍎 🍎 🍎  document retrieved',
          scaffoldKey: _key,
          backgroundColor: Colors.black,
          textColor: Colors.white);
    } on PlatformException catch (f) {
      print('👿👿👿👿👿👿👿👿 PlatformException 🍎 🍎 🍎 - $f');
    }
  }

  /// Replace document from a collection
  Future replace() async {
    debugPrint('\n\n💙 💙  replace  ....');
    try {
      var carrier = Carrier(
          db: 'testdb',
          collection: 'testCollection',
          id: '5cf8a0c16bc831de7f4c9b85',
          data: {
            'name': 'Aubrey St Vincent',
            'lastName': 'Malabie III',
            'wealth': 650000.09,
            'date': DateTime.now().toUtc().toIso8601String(),
            'desc': '💙 serve with UPDATED purpose 💙'
          });
      var res = await MongodbMobile.replace(carrier);
      debugPrint(
          '\n\n🍎 🍎 🍎 _MyAppState:replace: 🧩🧩🧩  replaced : 🍎 1 document : $res 🍎 \n\n\n');

      showSnackbar(
          message: '🍎 🍎 🍎  document replaced',
          scaffoldKey: _key,
          backgroundColor: Colors.indigo.shade800,
          textColor: Colors.white);
    } on PlatformException catch (f) {
      print('👿👿👿👿👿👿👿👿 PlatformException 🍎 🍎 🍎 - $f');
    }
  }

  /// Query Mongo database using collection properties
  Future query() async {
    debugPrint('\n\n💙 💙  getByProperty ....');
    try {
      var carrier = Carrier(db: 'testdb', collection: 'testCollection', query: {
        "gt": {"wealth": 9000},
        "eq": {"lastName": "Obama"},
        "and": true,
        "or": false,
        "limit": 0
      });
      var object = await MongodbMobile.query(carrier);
      debugPrint(
          '\n\n🍎 🍎 🍎 _MyAppState: query: 🧩🧩🧩  retrieved : 🍎 ${object.length} documents 🍎 see below: \n\n\n');
      print(object);

      showSnackbar(
          message: ' 🍎 🍎 🍎  ${object.length} documents found',
          scaffoldKey: _key,
          backgroundColor: Colors.purple,
          textColor: Colors.white);
    } on PlatformException catch (f) {
      print('👿👿👿👿👿👿👿👿 PlatformException 🍎 🍎 🍎 - $f');
    }
  }

  void showSnackbar(
      {@required GlobalKey<ScaffoldState> scaffoldKey,
      @required String message,
      @required Color textColor,
      @required Color backgroundColor}) {
    if (scaffoldKey.currentState == null) {
      print('AppSnackbar.showSnackbar --- currentState is NULL, quit ..');
      return;
    }
    scaffoldKey.currentState.removeCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: _getText(message, textColor),
      duration: new Duration(seconds: 15),
      backgroundColor: backgroundColor,
    ));
  }

  static Widget _getText(
    String message,
    Color textColor,
  ) {
    return Text(
      message,
      overflow: TextOverflow.clip,
      style: new TextStyle(color: textColor),
    );
  }

  GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _key,
        appBar: AppBar(
          title: const Text('Flutter MongoDB Plugin App'),
          backgroundColor: Colors.blueGrey.shade400,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Checking out Flutter MongoDB Plugin',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Use the plugin to access MongoDB embedded on-device as well as MongoDB Atlas on all the cloud providers.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.brown.shade50,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.bug_report),
          backgroundColor: Colors.red.shade700,
          elevation: 24,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
                    Container(
                      width: 260,
                      child: RaisedButton(
                        onPressed: insertDocument,
                        elevation: 16,
                        color: Colors.pink.shade300,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Insert One Document',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 260,
                      child: RaisedButton(
                        onPressed: getAllDocuments,
                        elevation: 16,
                        color: Colors.purple.shade300,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Get All Documents',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 260,
                      child: RaisedButton(
                        onPressed: query,
                        elevation: 16,
                        color: Colors.teal.shade300,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Query By Properties',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 260,
                      child: RaisedButton(
                        onPressed: delete,
                        elevation: 16,
                        color: Colors.blue.shade400,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Delete Document',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 260,
                      child: RaisedButton(
                        onPressed: replace,
                        elevation: 16,
                        color: Colors.brown.shade400,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Replace Document',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 260,
                      child: RaisedButton(
                        onPressed: getOne,
                        elevation: 16,
                        color: Colors.indigo.shade400,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Get One Document',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 260,
                      child: RaisedButton(
                        onPressed: addToArray,
                        elevation: 16,
                        color: Colors.orange.shade500,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Add To Array',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
