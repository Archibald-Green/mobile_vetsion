import 'dart:convert';
import 'package:mobileapp/api/api_connect.dart';
import 'package:mobileapp/api/api_models.dart';
import 'package:mobileapp/models/bookpage.dart';
import 'package:mobileapp/models/item.dart';
import 'package:mobileapp/models/pagelinks.dart';
import 'package:mobileapp/models/books.dart';
import 'package:mobileapp/models/progress.dart';
import 'package:mobileapp/services/status_code.dart';
import 'package:mobileapp/services/storage.dart';

import '../models/book_page_page_links.dart';

class HomeController {

  Future<UserLoginStatusCode> loginUser(String username, String password) async {
    UserLogin userLogin = UserLogin(username: username, password: password);
    Map reply = await loginApi(userLogin);
    UserLoginStatusCode statusCode = reply.values.first;
    if (statusCode.name == 200) {
      Token token = Token.fromJson(json.decode(reply.values.last));

      SecureStorage storage = SecureStorage();
      storage.addTokensToDb(token.token, token.refreshToken);
      storage.addUsernameToDb(username);
    }
    return statusCode;
  }

  Future<String> registerUser(String username, String email, String password1, String password2,) async {
    UserRegistration userRegistration = UserRegistration(username: username, email: email, password1: password1, password2: password2,);
    dynamic result = await registrationApi(userRegistration);
    String reply = '';
    if (result[0] == 'YES') {
      loginUser(username, password1);
    }
    result.forEach((element){
      reply = reply+'${element}\n';
    });
    return reply;
  }

  // Future<List<Book>> getNews() async{
  //   List<Book> allNews = [];
  //   List<dynamic> result = await newsApi();
  //   result.forEach((element) {
  //     allNews.add(Book(id: element['id'], title: element['title'], text: element['text'], timeCreate: element['time_create']));
  //   });
  //   return allNews;
  // }

  // Future<Book> getNew(int page) async{
  //   dynamic result = await newApi(page);
  //   Book news = Book.fromJson(result);
  //   return news;
  // }

  // Future<Reports> getReport() async{
  //   dynamic result = await bookListApi();
  //   Reports report = Reports.fromJson(result);
  //   return report;
  // }

  // Future<Books> getBook(int page) async{
  //   dynamic result = await bookListApi(page);
  //   Books book = Books.fromJson(result);
  //   return book;
  // }

  Future<List<Books>> getBooks() async{
    List<Books> allBooks = [];
    List<dynamic> result = await booksListApi();
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    print(result);
    result.forEach((element) {
      allBooks.add(Books.fromJson(element));
      print('Работай даваааааааааааааааааааааааааааай');
    });
    
    return allBooks;
  }


  // Future<PageLinks> getPage(int bookID) async{
  //   Map<String, dynamic> result = await bookListApi(bookID);
  //   print("QQQQQQQQQQQQQQQQQQQQQQQQQ:   ${result}");
  //   PageLinks pageLinks = PageLinks(id: result['id'], name: result['name'], idfrompage: result['from_page'], idtopage: result['to_page'], items: result['items']);
    
  //   // result.forEach((element) {
  //   //   BookPage page = BookPage.fromJson(element);
  //   //   // element['from_page']['book']['id']
  //   //   pages.add(page);
  //   // });
    
  //   return pageLinks;
  // }

  

//   Future<List<BookPage>> getPages() async{
//   List<BookPage> allPage = [];
//   try {
//     List<dynamic> result = await pagesListApi();
//     result.forEach((element) {
//       allPage.add(BookPage.fromJson(element));
//     });
//   } catch (e) {
//     print("Error while fetching pages: $e");
//     // handle the error, such as displaying a message to the user
//   }
//   return allPage;
// }

  

  // Future<Receipts> getReceipt(int page) async{
  //   dynamic result = await receiptApi(page);
  //   Receipts receipt = Receipts.fromJson(result);
  //   return receipt;
  // }

  
  // Future<Item> getItem(int page) async{
  //   dynamic result = await bookListApi(page);
  //   Item itemId = Item.fromJson(result);
  //   return itemId;
  // }

  // Future<List<Item>> getItems() async{
  //   List<Item> allItems = [];
  //   dynamic result = await itemsListApi();
  //   print('cccccccccccccccccccccccccccccccccccccccccccccccccc');
  //   print(result);
  //   result.forEach((element) {
  //     allItems.add(Item.fromJson(element));
  //   });
  //   return allItems;
  // }

  

 Future<PageLinks> getPageLink(int bookID, int linkpageID) async{
    List<dynamic> result = await linkListApi(bookID, linkpageID);
    List<PageLinks> pageslink = [];
    result.forEach((element) {
      print("FFFF:     ${element}");
      PageLinks page = PageLinks.fromJson(element);
      pageslink.add(page);
      element['from_page']['id'];
    });
    print('zdec vasha reklama ${pageslink}');
    return pageslink.first;
  }


//  Future<PageLinks> getPageIDLink(int bookID, int linkpageID) async{
//     Object result = await linkIDListApi(bookID, linkpageID);

//     print('sdasdadsadasdadama ${pageslink}');
//     return pageslink.first;
// }


  Future<List<PageLinks>> getPageLinks() async{
    List<PageLinks> allPageLink = [];
    List<dynamic> result = await linksListApi();
    print('ddddddddddddddddddddddddddddddddddddddddddddd');
    print(result);
    result.forEach((element) {
      allPageLink.add(PageLinks.fromJson(element));
    });
    return allPageLink;
  }


  // Future<Progress> getProgress(int page) async{
  //     dynamic result = await bookListApi(page);
  //     Progress progressId = Progress.fromJson(result);
  //     return progressId;
  //   }

  //  Future<List<Progress>> getProgresses() async{
  //   List<Progress> allProgress = [];
  //   List<dynamic> result = await progressListApi();
  //   print('fffffffffffffffffffffffffffffffffffffffffffffffffffff');
  //   print(result);
  //   result.forEach((element) {
  //     allProgress.add(Progress.fromJson(element));
  //   });
  //   return allProgress;
  // }

  Future<BookPagePageLinks> getBookPagePageLinks(int bookID) async{
    Map<String, dynamic> result = await bookPageLinkListApi(bookID);
    print("QQQQQQQQQQQQQQQQQQQQQQQQQ:   ${result}");

    BookPagePageLinks bookPagePageLinks = BookPagePageLinks.fromJson(result);
    return bookPagePageLinks;
    
  }

}

