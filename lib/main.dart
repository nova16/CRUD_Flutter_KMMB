import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'add_data.dart';
import 'detail_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // const MyApp({ Key? key }) : super(key: key);
      final String initialRoute;
      MyApp({this.initialRoute});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List> getData() async {
    final response = await http
        .get(Uri.parse("https://e-commerce12345.000webhostapp.com/list.php"));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    var _myData = getData();
    FutureOr onGoBack(dynamic value) {
      _myData = getData();
      setState(() {});
    }

    void handleClick(String value, BuildContext context) {
      switch (value) {
        case 'Tambah Data':
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_Data())).then(onGoBack);
          break;
        case 'Keluar':
          break;
      }
    }

    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Latihan CRUD Flutter"),
            actions: [
              PopupMenuButton<String>(onSelected: (String choice) {
                handleClick(choice, context);
              }, itemBuilder: (BuildContext contetext) {
                return {'Tambah Data', 'Keluar'}.map((String choice) {
                  return PopupMenuItem(value: choice, child: Text(choice));
                }).toList();
              }),
            ],
          ),
          body: FutureBuilder<List>(
              future: _myData,
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? new ItemList(
                        list: snapshot.data,
                      )
                    : new Center(
                        child: CircularProgressIndicator(),
                      );
              }),
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return new Container(
            padding: const EdgeInsets.all(10.0),
            child: new GestureDetector(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new DetailData(list: list, index: i))),
              child: new Card(
                  child: new ListTile(
                title: new Text(list[i]['title']),
                subtitle: new Text(list[i]['desc_sub']),
                leading: new Image.network(list[i]['img_url'],
                    width: 100, fit: BoxFit.contain),
              )),
            ),
          );
        });
  }
}
