import 'package:mobileapp/models/books.dart';

import 'item.dart';

class BookPage {
  int id;
  Books book;
  String title;
  String body;
  String coverart;
 
  List<Item> items ;
  

  BookPage({
    required this.id,
    required this.book,
    required this.title,
    required this.body,
    required this.coverart,
    required this.items,
  });

  factory BookPage.fromJson(Map<String, dynamic> json) {
    Books book = Books.fromJson(json['book']);

    List<Item> items = [];

    List<dynamic> itemsJson = json['items'];
    itemsJson.forEach((element) {
      Item item = Item.fromJson(element);
      items.add(item);
    },);

    return BookPage(
    
      id: json['id'] ?? 0,
      book: book,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      coverart: json['cover_art'] ?? '',
      items: items,
     
    );
  }
}

