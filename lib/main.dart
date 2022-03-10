import 'dart:convert';

import 'package:book_app/book.dart';
import 'package:book_app/detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Search Book'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _txtcari = "";

  Future<String> fetchData() async {
    final response = await http.get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=%7B" +
            _txtcari +
            "%7D"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to read API');
    }
  }

  bacaData() {
    listBook.clear();
    Future<String> data = fetchData();
    data.then((value) {
      Map json = jsonDecode(value);
      for (var b in json['items']) {
        Book book = Book.fromJson(b);
        if (book.creator == null){
          book.creator = "";
          
        }
        listBook.add(book);
        
      }
      print("a");
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  Widget showBook() {
    if (listBook.isNotEmpty) {
      return ListView.builder(
          itemCount: listBook.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new Card(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                    leading: Image.network(listBook[index].poster),
                    title: GestureDetector(
                        child: Text(listBook[index].judul),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailBook(book_id: listBook[index].id),
                            ),
                          );
                        }),
                    subtitle: Column(children: [
                      Text(listBook[index].creator!),
                      Text(listBook[index].publisher+""),
                      Text(listBook[index].date+""),
                    ])),
              ],
            ));
          });
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.search),
              labelText: 'Judul mengandung kata:',
            ),
            onFieldSubmitted: (value) {
              _txtcari = value;
              bacaData();
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height -100,
            child: showBook()
          ),
        ])
  
    );
  }
}
