import 'package:flutter/material.dart';
import 'package:mobileapp/controllers/home_controller.dart';
import 'package:mobileapp/models/bookpage.dart';
import 'package:mobileapp/pages/MainDrawer.dart';
import 'package:mobileapp/pages/auth/login.dart';
import 'package:mobileapp/services/storage.dart';
import 'package:tuple/tuple.dart';
import '../../models/book_page_page_links.dart';
import '../../models/pagelinks.dart';

class NewPage extends StatefulWidget {
  final int bookID;


  
  NewPage({required this.bookID});

  final HomeController _homeController = HomeController();
  @override
  _NewPageState createState() => _NewPageState(bookID: bookID);
}

class _NewPageState extends State<NewPage> {

  int bookID;
  late int linkpageID;
  late int fromID;

  _NewPageState({required this.bookID}) {
    linkpageID = 0; // or any other default value
  }

  late PageLinks _listpage;
  late PageLinks _pageLinks;
  late PageLinks _pageIDLinks;

  late BookPagePageLinks _bookPagePageLinks;

  @override
  void initState() {
    super.initState();
    UsernameUpdate();
  }


  final SecureStorage storage = SecureStorage();
  String buttonText = '';
  String? _username = '';
  List<ElevatedButton> pageButtons = [];

  Future<String?> getUsername() async {
    _username = await storage.getUsername();
    return _username;
  }

  void UsernameUpdate() {
    getUsername().then((String? username) {
      setState(() {
        if (username == null) {
          buttonText = 'Вход';
        }
        else {
          _username = username.toString();
          buttonText = '(${_username})Выход';
        }
      });
    });
  }
  
  void updatePageLink(int newLinkPageID) {
    setState(() {
      widget._homeController.getPageLink(bookID, newLinkPageID).then((listpagelink) {
        _pageLinks = [listpagelink] as PageLinks;
      });
    });
  }

  Future<BookPagePageLinks> getPageData() async {
    
    _bookPagePageLinks = await widget._homeController.getBookPagePageLinks(bookID);
    // print ('lolololololo $bookPagePageLinks');
    // setState(() {
    //   _bookPagePageLinks = bookPagePageLinks;
    // });

    _bookPagePageLinks.pageLinks.forEach((element) {
      pageButtons.add(ElevatedButton(
        onPressed: () {
          print("WWWWWWWWWWWWWWWWWWWWWWWWWWW");
          updatePageLink(element.id);
        },
        child: Text(element.name.split(',').map((name) => name.trim()).join(', ')),
      ));
    },);

    return _bookPagePageLinks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {});
        },
      ),
      appBar: AppBar(title: const Text("Future Builder Example")),
      body: FutureBuilder(
        future: getPageData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                child: SingleChildScrollView (
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    color: Colors.cyan[100],
                    child: Column(
                      children: [
                        Image.network(
                          snapshot.data!.bookPage.coverart,
                          width: 200,
                          height: 200,
                        ),
                        Text(snapshot.data!.bookPage.body, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                        // Text(snapshot.data!.body, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                        Text('Вы видите:' + snapshot.data!.bookPage.items.map((item) => item.name).join(', '), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                        Column (
                          children: pageButtons,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Text("Error: ${snapshot.error}");
          }
        },
      ),
    );
  }
}

