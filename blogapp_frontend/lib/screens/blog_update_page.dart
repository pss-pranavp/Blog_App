import 'package:flutter/material.dart';
import '../models/blog_post.dart';
import '../services/api_service.dart';
import '../widgets/blog_post_form.dart';

class BlogUpdatePage extends StatelessWidget {
  final BlogPost blogPost;
  final String token;

  BlogUpdatePage({required this.blogPost, required this.token});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService(token: token);

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Blog Post'),
      ),
      body: BlogPostForm(
        blogPost: blogPost,
        onSave: (title, author, content) async {
          if (blogPost.id != null) {
            final updatedPost = BlogPost(
              id: blogPost.id!,
              title: title,
              author: author,
              content: content,
              timestamp: blogPost.timestamp,
            );
            await apiService.updateBlogPost(blogPost.id!, updatedPost);
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Blog post ID is missing')),
            );
          }
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import '../models/blog_post.dart';
// import '../services/api_service.dart';
// import '../widgets/blog_post_form.dart';

// class BlogUpdatePage extends StatelessWidget {
//   final BlogPost blogPost;
//   final ApiService apiService = ApiService();

//   BlogUpdatePage({required this.blogPost});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Update Blog Post'),
//       ),
//       body: BlogPostForm(
//         blogPost: blogPost,
//         onSave: (title, author, content) async {
//           // Ensure id is non-null when passing to updateBlogPost
//           if (blogPost.id != null) {
//             final updatedPost = BlogPost(
//               id: blogPost.id!,
//               title: title,
//               author: author,
//               content: content,
//               timestamp: blogPost.timestamp,
//             );
//             await apiService.updateBlogPost(blogPost.id!, updatedPost);
//             Navigator.pop(context);
//           } else {
//             // Handle case where id is null (e.g., show an error)
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Blog post ID is missing')),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
