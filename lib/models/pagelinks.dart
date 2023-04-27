import 'bookpage.dart';
import 'item.dart';

class PageLinks {
  int id;
  String name;
  BookPage idfrompage;
  BookPage idtopage;

  PageLinks({required this.id, required this.name, required this.idfrompage, required this.idtopage });

  factory PageLinks.fromJson( json) {

    BookPage idfrompage = BookPage.fromJson(json['from_page']);
    BookPage idtopage = BookPage.fromJson(json['to_page']);

    return PageLinks(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        idfrompage: idfrompage,
        idtopage: idtopage,
    );
  }
}