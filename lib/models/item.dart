class Item {
  int id;
  String name;
  Item({required this.id, required this.name,});

  factory Item.fromJson( json) {
    return Item(
        id: json['id'] as int,
        name: json['name'] as String );
  }
}