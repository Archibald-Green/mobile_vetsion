class Progress {
  int id;
  int bookid;
  int pageid;
  int userid;
  int passed;
  Progress({required this.id, required this.bookid, required this.pageid, required this.userid, required this.passed,});
  
  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
        id: json['id'],
        bookid: json['bookid'],
        pageid: json['pageid'],
        userid: json['userid'],
        passed: json['passed'],
        );
  }
}

