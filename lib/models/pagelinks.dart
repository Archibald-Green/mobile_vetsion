import 'item.dart';

class PageLinks {
  int id;
  String name;
  int idfrompage;
  int idtopage;
  List<Item> items ;

  PageLinks({required this.id, required this.name, required this.idfrompage, required this.idtopage,required this.items, });

  factory PageLinks.fromJson(Map<String, dynamic> json) {

     List<Item> items = [];

    List<dynamic> itemsJson = json['items'];
    itemsJson.forEach((element) {
      Item item = Item.fromJson(element);
      items.add(item);
    },);

    return PageLinks(
        id: json['id'],
        name: json['name'],
        idfrompage: json['idfrompage'],
        idtopage: json['idtopage'],
        items: items,
    );
  }
}