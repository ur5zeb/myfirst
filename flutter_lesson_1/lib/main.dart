import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MyFirstApp(),
  );
}

class MyFirstApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyFirstAppState();
  }
}

class _MyFirstAppState extends State<MyFirstApp> {
  late bool _loading;
  late double _progressValue;
  @override
  void initState() {
    _loading = false;
    _progressValue = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('My first app'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Enter your login',
                        labelText: 'login *'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.password),
                      hintText: 'Enter your password',
                      labelText: 'password *',
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
