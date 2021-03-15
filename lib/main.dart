import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = const MethodChannel("call.demo");
  List<dynamic> _batteryLevel=[];

  _getBatteryLevel() async {
    List<dynamic> batteryLevel;
    try {
      final List<dynamic> result = await platform.invokeMethod("getBatteryLevel");
      batteryLevel =result;
    } on PlatformException catch (e) {
      batteryLevel = ["Fali ${e.message}"];
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.get_app),
        onPressed: _getBatteryLevel,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Text(_batteryLevel[index]);
        },
        itemCount: _batteryLevel.length,
      ),
    );
  }
}
