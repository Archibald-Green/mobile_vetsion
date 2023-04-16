import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobileapp/models/progress.dart';
import 'package:mobileapp/services/status_code.dart';
import 'package:mobileapp/services/storage.dart';
import 'api_models.dart';

final _base = "http://192.168.1.207:8000";
final _signInURL = "/api/token/";
final _refreshEndpoint = "/api/token/refresh/";
final _signUpEndpoint = "/api/register/";

final _booksEndpoint = "/api/api/book_view/";
final _bookIdEndpoint = "/api/api/book_view/<int:pk>";

final _bookPagesEndpoint = "/api/api/book_page_view/";
final _bookPageIdEndpoint = "api/api/book_page_view/<int:pk>";

final _itemsEdpoint = "/api/api/item_view/";
final _itemIdEdpoint = "/api/api/item_view/<int:pk>";


final _pageLinksEndpoint = "/api/api/page_link_view/";
final _pageLinkIdEndpoint = "/api/api/page_link_view/<int:pk>";

final _progressesEdpoint = "/api/api/bool_progress_view/";
final _progressIdEdpoint = "/api/api/bool_progress_view/<int:pk>";

final _registrationEndpoint = "/api/api/registration/";


final _refresh = _base + _refreshEndpoint;
final _login = _base + _signInURL;

final _book = _base + _bookIdEndpoint;
final _books = _base + _booksEndpoint;

final _page = _base + _bookPageIdEndpoint;
final _pages = _base + _bookPagesEndpoint;

final _item = _base + _itemIdEdpoint;
final _items = _base + _itemsEdpoint;

final _registration = _base + _registrationEndpoint;

final _link = _base + _pageLinkIdEndpoint;
final _links = _base + _pageLinksEndpoint;

final _progress= _base + _progressIdEdpoint;
final _progresses= _base + _progressesEdpoint;


Future<void> refreshToken() async{
  var token = await SecureStorage().getRefreshToken();
  if (token != null) {
    token = token;
  }
  Map<String, String> refreshTokenMap = {'refresh':'${token}'};
  http.Response response = await http.post(
    Uri.parse(_refresh),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(refreshTokenMap),
  );
  SecureStorage storage = SecureStorage();
  if (response.statusCode == 200) {
    Token token = Token.fromJson(json.decode(response.body));
    storage.addTokensToDb(token.token, token.refreshToken);
  } else {
    throw Exception(json.decode(response.body));
  }
}




Future<Map> loginApi(UserLogin userLogin) async {
  final http.Response response = await http.post(
    Uri.parse(_login),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  UserLoginStatusCode statusCode = UserLoginStatusCode.fromName(response.statusCode);
  Map<String, dynamic> reply = {'status': statusCode, 'resonse_body': response.body};
  return reply;
}




Future<List> registrationApi(UserRegistration userRegistration) async {
  final http.Response response = await http.post(
    Uri.parse(_registration),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userRegistration.toDatabaseJson()),
  );
  List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));
  return result;
}


Future<List<dynamic>> booksListApi() async {
  var token = await SecureStorage().getToken();
  print(token);
  print('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');
  if (token != null) {
    token = 'Bearer ${token}';
  }
  http.Response response = await http.get(
    Uri.parse(_books),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${token}',
    },
  );
  if (response.statusCode == 401) {
    refreshToken();
    await Future.delayed(const Duration(seconds: 1));
    return booksListApi();
  }
  List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));
  print('Boooooooooookkkkkkkkkkksssssss');
  print(result);
  return result;
}



Future<List<dynamic>> bookListApi(int page) async {
  var token = await SecureStorage().getToken();
  print ('asssssssssssssssssssssssssssssssss');
  if (token != null) {
    token = 'Bearer ${token}';
  }
  http.Response response = await http.get(
    Uri.parse(_book),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${token}',
    },
  );
  if (response.statusCode == 401) {
    refreshToken();
    await Future.delayed(const Duration(seconds: 1));
    return bookListApi(page);
  }
  List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));
  print('__________________________________________________');
  print(result);
  return result;
}



Future<List<dynamic>> pagesListApi() async {
  print ('cccccccccccccccccccccccccccccccccccccccccccccc');
  var token = await SecureStorage().getToken();
  if (token != null) {
    token = 'Bearer ${token}';
  }
  http.Response response = await http.get(
    Uri.parse(_pages),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${token}',
    },
  );
  if (response.statusCode == 401) {
    refreshToken();
    await Future.delayed(const Duration(seconds: 1));
    return pagesListApi();
  }
  List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));
  print(result);
  print ('ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc');
  return result;
}



Future<List<dynamic>> pageListApi() async {
  var token = await SecureStorage().getToken();
  if (token != null) {
    token = 'Bearer ${token}';
  }
  http.Response response = await http.get(
    Uri.parse(_page),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${token}',
    },
  );
  if (response.statusCode == 401) {
    refreshToken();
    await Future.delayed(const Duration(seconds: 1));
    return pageListApi();
  }
  List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));
  print(result);
  return result;
}




Future<List<dynamic>> itemsListApi() async {
  print('ddddddddddddddddddddddddddddddddd');
  var token = await SecureStorage().getToken();
  if (token != null) {
    token = 'Bearer ${token}';
  }
  http.Response response = await http.get(
    Uri.parse(_items),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${token}',
    },
  );
  if (response.statusCode == 401) {
    refreshToken();
    await Future.delayed(const Duration(seconds: 1));
    return itemsListApi();
  }
  List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));
  print(result);
  print('ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
  return result;
}



Future<List<dynamic>> itemListApi() async {
  var token = await SecureStorage().getToken();
  if (token != null) {
    token = 'Bearer ${token}';
  }
  http.Response response = await http.get(
    Uri.parse(_item),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${token}',
    },
  );
  if (response.statusCode == 401) {
    refreshToken();
    await Future.delayed(const Duration(seconds: 1));
    return itemListApi();
  }
  List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));
  print(result);
  return result;
}



Future<List<dynamic>> linksListApi() async {
  print('ffffffffffffffffffffffffffffffffffffffffffff');
  var token = await SecureStorage().getToken();
  if (token != null) {
    token = 'Bearer ${token}';
  }
  http.Response response = await http.get(
    Uri.parse(_links),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${token}',
    },
  );
  if (response.statusCode == 401) {
    refreshToken();
    await Future.delayed(const Duration(seconds: 1));
    return linksListApi();
  }
  List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));
  print(result);
  print('fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');
  return result;
}



Future<List<dynamic>> linkListApi() async {
  var token = await SecureStorage().getToken();
  if (token != null) {
    token = 'Bearer ${token}';
  }
  http.Response response = await http.get(
    Uri.parse(_link),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${token}',
    },
  );
  if (response.statusCode == 401) {
    refreshToken();
    await Future.delayed(const Duration(seconds: 1));
    return linkListApi();
  }
  List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));
  print(result);
  return result;
}



Future<List<dynamic>> progressesListApi() async {
  var token = await SecureStorage().getToken();
  print('');
  if (token != null) {
    token = 'Bearer ${token}';
  }
  http.Response response = await http.get(
    Uri.parse(_progresses),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${token}',
    },
  );
  if (response.statusCode == 401) {
    refreshToken();
    await Future.delayed(const Duration(seconds: 1));
    return progressesListApi();
  }
  List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));
  print(result);
  return result;
}

Future<List<dynamic>> progressListApi() async {
  var token = await SecureStorage().getToken();
  if (token != null) {
    token = 'Bearer ${token}';
  }
  http.Response response = await http.get(
    Uri.parse(_progress),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${token}',
    },
  );
  if (response.statusCode == 401) {
    refreshToken();
    await Future.delayed(const Duration(seconds: 1));
    return progressListApi();
  }
  List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));
  print(result);
  return result;
}
