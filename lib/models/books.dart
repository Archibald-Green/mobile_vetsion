class Books {
  int id;
  String title;
  int firstPage;

  Books({
    required this.id,
    required this.title,
    required this.firstPage,
  });

  factory Books.fromJson(json) {
    return Books(
      id: json['id']  as int,
      title: json['title'] as String,
      firstPage: json['first_page'] as int
    );
  }
}