import 'package:flutter/material.dart';

class NotoDoScreen extends StatefulWidget {
  @override
  _NotoDoScreenState createState() => _NotoDoScreenState();
}

class _NotoDoScreenState extends State<NotoDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Column(),
      floatingActionButton: new FloatingActionButton(
        tooltip: "Add Item",
        backgroundColor: Colors.redAccent,
        child: new ListTile(
          title: new Icon(Icons.add),
        ),
        onPressed: _showFormDialog,
      ),
    );
  }

//22111273
  void _showFormDialog() {}
}
