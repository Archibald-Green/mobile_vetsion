import 'package:flutter/material.dart';
import 'package:mobileapp/controllers/home_controller.dart';
import 'package:mobileapp/pages/MainDrawer.dart';
import 'package:mobileapp/pages/auth/login.dart';
import 'package:mobileapp/services/storage.dart';

class NewPage extends StatefulWidget {
  int page;
  NewPage({required this.page});

  final HomeController _homeController = HomeController();
  @override
  _NewPageState createState() => _NewPageState(page: page);
}

class _NewPageState extends State<NewPage> {
  int page;
  _NewPageState({required this.page});

  dynamic _listpage;

  @override
  void initState() {
    super.initState();
    UsernameUpdate();
    widget._homeController.getPage(page).then((listpage) {
      setState(() {
        _listpage = listpage;
      });
    });
  }

  final SecureStorage storage = SecureStorage();
  String buttonText = '';
  String? _username = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('ЖКХ услуги'),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                if (buttonText == '(${_username})Выход') {
                  storage.deleteData();
                  setState(() {
                    buttonText = 'Вход';
                  });
                }
                else {
                  Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Login()));
                }
              },
              child: Text(buttonText))
        ],
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: SingleChildScrollView (
        child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            color: Colors.cyan[100],
            child: Column(
              children: [
                Text(_listpage.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                Text(_listpage.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
              ],
              ),
          )
        )
    );
  }
}
