// import 'package:flutter/material.dart';
// import 'package:mobileapp/controllers/home_controller.dart';
// import 'package:mobileapp/models/books.dart';
// import 'package:mobileapp/pages/MainDrawer.dart';
// import 'package:mobileapp/pages/auth/login.dart';
// import 'package:mobileapp/pages/news/book_main.dart';
// import 'package:mobileapp/services/storage.dart';
// import 'package:url_launcher/url_launcher.dart';

// class BooksLists extends StatefulWidget {
//   final HomeController _homeController = HomeController();
//   @override
//   _BooksPageState createState() => _BooksPageState();

  
// }

// class _BooksPageState extends State<BooksLists> {
//   List<Books> _listBooks = [];

//   @override
//   void initState() {
//     super.initState();
//     UsernameUpdate();
//     widget._homeController.getBooks().then((listNews) {
//       setState(() {
//         _listBooks = listNews;
//       });
//     });
//   }

//   final SecureStorage storage = SecureStorage();
//   String buttonText = '';
//   String? _username = '';

//   Future<String?> getUsername() async {
//     _username = await storage.getUsername();
//     return _username;
//   }

//   void UsernameUpdate() {
//     getUsername().then((String? username) {
//       setState(() {
//         if (username == null) {
//           buttonText = 'Вход';
//         }
//         else {
//           _username = username.toString();
//           buttonText = '(${_username})Выход';
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.lightBlue,
//         title: const Text('ЖКХ услуги'),
//         actions: <Widget>[
//           TextButton(
//               onPressed: () {
//                 if (buttonText == '(${_username})Выход') {
//                   storage.deleteData();
//                   setState(() {
//                     buttonText = 'Вход';
//                   });
//                 }
//                 else {
//                   Navigator.push(
//                         context, MaterialPageRoute(builder: (_) => Login()));
//                 }
//               },
//               child: Text(buttonText))
//         ],
//       ),
//       drawer: Drawer(
//         child: MainDrawer(),
//       ),
//       body: ListView.builder(
//         itemCount: _listBooks.length,
//         itemBuilder: (context, index) {
//           final itemNews = _listBooks[_listBooks.length-index-1];
//           return Container(
//             margin: EdgeInsets.all(10),
//             padding: EdgeInsets.all(10),
//             color: Colors.cyan[100],
//             child: Column(
//               children: [
//                     Text(itemNews.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
//                     Container(
//                       margin: EdgeInsets.only(top: 10),
//                       child: OutlinedButton(
//                       onPressed: () => {  Navigator.push(context, MaterialPageRoute(builder: (context) => NewPage(page: itemNews.id))),
//                       print('_____________________________________________________________________-'),
//                       print(itemNews.id),
//                     },
//                     child: Text('Подробнее', style: TextStyle(color: Colors.black),),
//                   ),
//                 ) ,
                        
//                 // Container(
//                 //   margin: EdgeInsets.only(top: 10),
//                 //   // child: OutlinedButton(
//                 //   // // onPressed: () => {
//                 //   // //   Navigator.push(context, MaterialPageRoute(builder: (context) => NewPage(page: itemNews.id)))
//                 //   // //   },
//                 //   // // child: Text('Подробнее', style: TextStyle(color: Colors.black),),
//                 //   // ),
//                 // ),
//                 // Align(
//                 //   alignment: Alignment.bottomRight,
//                 //   child: Text(
//                 //   '${itemNews.timeCreate.split('-')[2].split('T')[0]}.${itemNews.split('-')[1]}.${itemNews.timeCreate.split('-')[0]}г.',
//                 //   style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
//                 //   textAlign: TextAlign.right,
//                 //     ),
//                 // ),
//               ],
//               ),
//           );
//         },
//       ),
//     );
//   }
// }
