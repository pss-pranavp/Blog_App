import 'package:flutter/material.dart';
import '../models/blog_post.dart';
import '../services/api_service.dart';
import '../widgets/blog_post_form.dart';

class BlogCreatePage extends StatelessWidget {
  final String token;

  BlogCreatePage({required this.token});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService(token: token);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Blog Post'),
      ),
      body: BlogPostForm(
        onSave: (title, author, content) async {
          final newPost = BlogPost(
            title: title,
            author: author,
            content: content,
            timestamp: DateTime.now(),
          );
          await apiService.createBlogPost(newPost);
          Navigator.pop(context);
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../models/blog_post.dart';
// import '../services/api_service.dart';
// import '../widgets/blog_post_form.dart';

// class BlogCreatePage extends StatelessWidget {
//   final ApiService apiService = ApiService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Blog Post'),
//       ),
//       body: BlogPostForm(
//         onSave: (title, author, content) async {
//           final newPost = BlogPost(
//             title: title,
//             author: author,
//             content: content,
//             timestamp: DateTime.now(), // Set current time as timestamp
//           );
//           await apiService.createBlogPost(newPost);
//           Navigator.pop(context);
//         },
//       ),
//     );
//   }
// }
