import 'package:flutter/material.dart';
import 'package:todoapp/Model/notodo_item.dart';
import 'package:todoapp/Util/database_client.dart';
import 'package:todoapp/Util/date_Formatter.dart';

class NotoDoScreen extends StatefulWidget {
  @override
  _NotoDoScreenState createState() => _NotoDoScreenState();
}

class _NotoDoScreenState extends State<NotoDoScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  var db = new DatabaseHelper();

  final List<NoDoItem> list = <NoDoItem>[];

  @override
  void initState() {
    super.initState();
    readNoDolistItem();
  }

  void _handleSubmit(String text) async {
    _textEditingController.clear();
//create nodo item
    NoDoItem noDoItem = new NoDoItem(text, DateTime.now().toIso8601String());
    int savedItemId = await db.saveItem(noDoItem);

    NoDoItem addedItem = await db.getItem(savedItemId);

    setState(() {
      list.insert(0, addedItem);
    });
    //print("Items saved so far are  $savedItemId" );
  }

  void _textEditingClear() {}
  //allowing text to be editied
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              itemCount: list.length,
              padding: EdgeInsets.all(10.0),
              itemBuilder: (_, int index) {
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    title: list[index],
                    onLongPress: () => updateItem(list[index], index),
                    trailing: new Listener(
                      key: new Key(list[index].itemName),
                      child: new Icon(
                        Icons.remove_circle,
                        color: Colors.redAccent,
                      ),
                      onPointerDown: (pointerEvent) =>
                          deleteNoDo(list[index].id, index),
                    ),
                  ),
                );
              },
            ),
          ),
          new Divider(
            height: 1.0,
          )
        ],
      ),
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

  void _showFormDialog() {
    var alert = new AlertDialog(
      content: Row(
        children: <Widget>[
          new Expanded(
            child: TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: "Item",
                  hintText: "eg. Do homework",
                  icon: new Icon(Icons.note_add)),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              _handleSubmit(_textEditingController.text);
              _textEditingClear();
              Navigator.pop(context);
            },
            child: Text("Save")),
        new FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert; //returns widget
        });
  }

  //Gets list from db with db object
  readNoDolistItem() async {
    List items = await db.getItems();
    items.forEach((item) {
      // NoDoItem noDoItem = NoDoItem.map(items);
      setState(() {
        list.add(NoDoItem.map(item)); //add items whenever user starts the app
      });
      //  print("db items ${NoDoItem.itemName}");
    });
  }

  deleteNoDo(int id, index) async {
    debugPrint("Deleted item");

    await db.deleteItem(id);
    setState(() {
      list.removeAt(index);
    });
  }

  updateItem(NoDoItem item, int index) {
    var alert = new AlertDialog(
      title: new Text("Update Item"),
      content: new Row(
        children: <Widget>[
          new Expanded(
              child: new TextField(
            controller: _textEditingController,
            autofocus: true,
            decoration: new InputDecoration(
                labelText: "item",
                hintText: "Buy lunch",
                icon: new Icon(Icons.update)),
          ))
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () async {
            NoDoItem noDoItemUpdated = new NoDoItem.fromMap({
              "itemName": _textEditingController.text,
              "dateCreated":
                  dateFormatted(), //calls method in class date formatter to get date
              "id": item.id
            });
          },
          child: new Text("Update Item"),
        ),
        new FlatButton(
          onPressed: () => Navigator.pop(context),
          child: new Text("Cancel"),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert; //returns widget
        });
  }
}
