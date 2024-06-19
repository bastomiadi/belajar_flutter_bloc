// lib/models/post.dart
class Post {
  final int id;
  final String title;
  final String body;

  //final DateTime date;
  //final String? status;
  Post({
    required this.id,
    required this.title,
    required this.body,
    //this.status,
    //required this.date
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      //status: json['status'],
      //date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      //'status': status,
      //'date': date.toIso8601String(),
    };
  }
}
