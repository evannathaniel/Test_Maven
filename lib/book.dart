class Book{
  final String id;
  String judul;
  String description;
  String publisher;
  String poster;
  String backdrop;
  String date;
  String? creator;
  
  Book({required this.id,required this.judul,required this.description,required this.publisher,
   required this.poster, required this.backdrop,required this.date,this.creator});
  
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['id'],
        judul: json['volumeInfo']['title'],
        publisher: json['volumeInfo']['publisher']?? "",
        description: json['volumeInfo']['description']?? "",
        poster:json['volumeInfo']['imageLinks']['smallThumbnail']?? "",
        backdrop: json['volumeInfo']['imageLinks']['thumbnail']?? "",
        date:json['volumeInfo']['publishedDate'] ?? "",
        creator: json['volumeInfo']['authors'].toString());
  }
}

var listBook = <Book>[];