//import 'package:intl/intl.dart'; // For formatting date if needed

class BlogPost {
  final int? id;
  final String title;
  final String author;
  final String content;
  final DateTime timestamp;

  BlogPost({
    this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.timestamp,
  });

  // Factory constructor to create a BlogPost from JSON
  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'] as int?,
      title: json['title'] as String,
      author: json['author'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  // Method to convert a BlogPost to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'content': content,
      'timestamp': timestamp.toIso8601String(), // Format timestamp to ISO 8601
    };
  }
}
