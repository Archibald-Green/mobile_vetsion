import 'package:mobileapp/models/bookpage.dart';
import 'package:mobileapp/models/pagelinks.dart';

class BookPagePageLinks {
  late BookPage bookPage;
  
  late List<PageLinks> pageLinks;

  BookPagePageLinks();

  factory BookPagePageLinks.fromJson(Map<String, dynamic> json) {
    BookPagePageLinks bookPagePageLinks = BookPagePageLinks();
    bookPagePageLinks.pageLinks = [];

    bookPagePageLinks.bookPage = BookPage.fromJson(json['book_page']);
    
    List<dynamic> pageLinksJson = json['page_links'];
    pageLinksJson.forEach((element) {
      PageLinks pagelink = PageLinks.fromJson(element);
      bookPagePageLinks.pageLinks.add(pagelink);
    });
    
    return bookPagePageLinks;
  }
}