import 'package:mobileapp/models/books.dart';

import 'item.dart';

class Page {
  int id;
  Books book;
  String title;
  String body;
  String coverart;
 
  List<Item> items ;
  

  Page({
    required this.id,
    required this.book,
    required this.title,
    required this.body,
    required this.coverart,
    required this.items,
  });

  factory Page.fromJson(Map<String, dynamic> json) {
    Books book = Books.fromJson(json['book']);

    List<Item> items = [];

    List<dynamic> itemsJson = json['items'];
    itemsJson.forEach((element) {
      Item item = Item.fromJson(element);
      items.add(item);
    },);

    return Page(
    
      id: json['id'],
      book: book ,
      title: json['title'],
      body: json['body'],
      coverart: json['cover_art'],
      items: items,
     
    );
  }
}

