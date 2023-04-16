class PageLinks {
  int id;
  String name;
  int idfrompage;
  int idtopage;

  PageLinks({required this.id, required this.name, required this.idfrompage, required this.idtopage,});

  factory PageLinks.fromJson(Map<String, dynamic> json) {
    return PageLinks(
        id: json['id'],
        name: json['name'],
        idfrompage: json['idfrompage'],
        idtopage: json['idtopage'],
    );
  }
}