import 'package:flutter/material.dart';

class NoDoItem extends StatelessWidget {
  // setting vairables to get from db
  String _itemName;
  String _dateCreated;
  int _id;
//setting var in db
  NoDoItem(this._dateCreated, this._itemName);
  NoDoItem.map(dynamic obj) {
    this._itemName = obj["itemname"];
    this._dateCreated = obj["datecreated"];
    this._id = obj["id"];
  }

  // gett from db
  String get itemName => _itemName;
  String get dateCreated => _dateCreated;
  int get id => _id;

//pulling from db, storing into map obj
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["itemName"] = _itemName;
    map["dateCreated"] = _dateCreated;
    if (_id != null) {
      //checks id
      map["id"] = _id;
    }
    return map; //returning object
  }

  //descructing from map obj into var
  NoDoItem.fromMap(Map<String, dynamic> Map) {
    this._itemName = Map["itemName"];
    this._dateCreated = Map["dateCreated"];
    this._id = Map["id"];
  }

  //layout
  @override
  Widget build(BuildContext context) {
    return Container(
      //layout for todo item
      margin: const EdgeInsets.all(8.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _itemName,
            style: new TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: Text("Created on: $_dateCreated",
                style: TextStyle(
                  color: Colors.white24,
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                )),
          )
        ],
      ),
    );
  }
}
