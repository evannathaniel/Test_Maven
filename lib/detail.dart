import 'package:book_app/book.dart';
import 'package:flutter/material.dart';

class DetailBook extends StatefulWidget {
  final String book_id;
  DetailBook({Key? key, required this.book_id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _DetailBookState();
  }
}

class _DetailBookState extends State<DetailBook> {
  Book? book;
  @override
  void initState() {
    super.initState();
  }

  Widget tampilData() {
    for (Book b in listBook) {
      if (b.id == this.widget.book_id) {
        book = b;
      }
    }

    if (book != null) {
      return Card(
          elevation: 10,
          margin: EdgeInsets.all(10),
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(book!.judul, style: TextStyle(fontSize: 25)),
            ),
            Image.network(book!.backdrop),
            Padding(
                padding: EdgeInsets.all(10),
                child:
                    Text(book!.publisher + "", style: TextStyle(fontSize: 17))),
            Padding(
                padding: EdgeInsets.all(10),
                child:
                    Text(book!.creator! + "", style: TextStyle(fontSize: 17))),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(book!.date + "", style: TextStyle(fontSize: 17))),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(book!.description, style: TextStyle(fontSize: 15))),
          ]));
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Book'),
        ),
        body: ListView(children: <Widget>[tampilData()]));
  }
}
