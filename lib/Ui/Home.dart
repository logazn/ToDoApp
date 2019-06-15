import 'package:flutter/material.dart';
import 'notodo_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Todo section"),
        backgroundColor: Colors.redAccent,
      ),
      body: new NotoDoScreen(),
    );
  }
}
