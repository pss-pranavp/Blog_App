import 'package:flutter/material.dart';
import '../models/blog_post.dart';

class BlogDetailPage extends StatelessWidget {
  final BlogPost blogPost;

  // Use 'required' keyword instead of '@required'
  BlogDetailPage({required this.blogPost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blogPost.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              blogPost.author,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(blogPost.content),
            SizedBox(height: 10),
            Text(
              'Published on: ${blogPost.timestamp.toLocal().toString().split(' ')[0]}',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
