import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart';
import 'edit_data.dart';

class DetailData extends StatefulWidget {
  // const DetailData({ Key? key }) : super(key: key);
  List list;
  int index;
  DetailData({this.index, this.list});

  @override
  _DetailDataState createState() => _DetailDataState();
}

class _DetailDataState extends State<DetailData> {
  void deteleData() {
    var url = "https://e-commerce12345.000webhostapp.com/deletenews.php";
    http.post(Uri.parse(url),
        body: {"idnews": widget.list[widget.index]['id']});
    Fluttertoast.showToast(
        msg: "Berita " +
            widget.list[widget.index]["title"] +
            " Berhasil Dihapus!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM);
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Anda yakin mau menghapus berita ini? Judul Berita : '${widget.list[widget.index]['title']}'"),
      actions: <Widget>[
        new MaterialButton(
          child: new Text(
            "OK HAPUS!",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.red,
          onPressed: () {
            deteleData();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => new MyApp()),
            );
          },
        ),
        new MaterialButton(
          child: new Text(
            "CANCEL",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: new Text("${widget.list[widget.index]['title']}"),
      ),
      body: new SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
            child: new Center(
          child: new Column(
            children: <Widget>[
              new Padding(padding: const EdgeInsets.only(top: 20.0)),
              new Text(
                "${widget.list[widget.index]['title']}",
                style: new TextStyle(fontSize: 20.0),
              ),

              new Padding(padding: const EdgeInsets.only(top: 20.0)),
              new Image.network("${widget.list[widget.index]['img_url']}"),

              new Padding(padding: const EdgeInsets.only(top: 20.0)),
              new Text(
                "${widget.list[widget.index]['content']}",
                style: new TextStyle(fontSize: 15.0),
              ),

              new Padding(padding: const EdgeInsets.only(top: 20.0)),
              new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new MaterialButton(
                    child: new Text("EDIT"),
                    color: Colors.green,
                    onPressed: () =>Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new Edit_Data(list: widget.list, index: widget.index))),
                  ),
                  new MaterialButton(
                    child: new Text("HAPUS"),
                    color: Colors.red,
                    onPressed: () => confirm(),
                  ),
                ],
              ),

              new Padding(padding: const EdgeInsets.only(top: 20.0)),
            ],
          ),
        )),
      ),
    );
  }
}
