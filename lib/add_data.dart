import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Add_Data extends StatefulWidget {
  // const Add_Data({ Key? key }) : super(key: key);

  @override
  _Add_DataState createState() => _Add_DataState();
}

class _Add_DataState extends State<Add_Data> {
  TextEditingController controllerTitle = new TextEditingController();
  TextEditingController controllerContent = new TextEditingController();
  TextEditingController controllerUrlImg = new TextEditingController();

  void addData() {
    var url = "https://e-commerce12345.000webhostapp.com/addnews.php";
    http.post(Uri.parse(url), body: {
      "newstitle": controllerTitle.text,
      "newscontent": controllerContent.text,
      "image_url": controllerUrlImg.text
    });
    Fluttertoast.showToast(msg: "Berita Baru berhasil ditambahkan. Cek di Menu Utama!",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
    
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tambah Berita"),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.30),
              child: TextField(
                controller: controllerTitle,
                decoration: new InputDecoration(
                    hintText: "Isi Judul Berita Disini...", labelText: "Judul"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.30),
              child: TextField(
                controller: controllerContent,
                decoration: new InputDecoration(
                    hintText: "Isi Deskripsi Berita Disini...",
                    labelText: "Deskripsi Berita"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.30),
              child: TextField(
                controller: controllerUrlImg,
                decoration: new InputDecoration(
                    hintText: "Isi URL Gambar Berita Disini...",
                    labelText: "URL Gambar"),
              ),
            ),
            MaterialButton(
              child: Text("Simpan Data"),
              onPressed: () {addData();},
            )
          ],
        ),
      ),
    );
  }
}
