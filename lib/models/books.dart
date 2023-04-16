class Books {
  int id;
  String title;
  int firstPage;

  Books({
    required this.id,
    required this.title,
    required this.firstPage,
  });

  factory Books.fromJson(Map<String, dynamic> json) {
    return Books(
      id: json['id'],
      title: json['title'],
      firstPage: json['first_page']
    );
  }
}