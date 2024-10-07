import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/blog_post.dart';

class ApiService {
  final String token;

  ApiService({required this.token});

  static const String baseUrl = 'http://127.0.0.1:8000/api';

  // Fetch blog posts with token authentication
  Future<List<BlogPost>> fetchBlogPosts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/blog/blogpost/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => BlogPost.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load blog posts');
    }
  }

  // Create a new blog post with token authentication
  Future<void> createBlogPost(BlogPost blogPost) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(blogPost.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create blog post');
    }
  }

  // Update an existing blog post with token authentication
  Future<void> updateBlogPost(int id, BlogPost blogPost) async {
    final response = await http.put(
      Uri.parse('$baseUrl/posts/$id/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(blogPost.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update blog post');
    }
  }

  // Delete a blog post with token authentication
  Future<void> deleteBlogPost(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/posts/$id/'),
      headers: {
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete blog post');
    }
  }
}


// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/blog_post.dart';

// class ApiService {
//   static const String baseUrl = 'http://127.0.0.1:8000/api';

//   Future<List<BlogPost>> fetchBlogPosts() async {
//     final response = await http.get(Uri.parse('$baseUrl/blog/blogpost/'));
//     if (response.statusCode == 200) {
//       List<dynamic> body = jsonDecode(response.body);
//       return body.map((json) => BlogPost.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load blog posts');
//     }
//   }

//   Future<void> createBlogPost(BlogPost blogPost) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/posts/'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(blogPost.toJson()),
//     );
//     if (response.statusCode != 201) {
//       throw Exception('Failed to create blog post');
//     }
//   }

//   Future<void> updateBlogPost(int id, BlogPost blogPost) async {
//     final response = await http.put(
//       Uri.parse('$baseUrl/posts/$id/'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(blogPost.toJson()),
//     );
//     if (response.statusCode != 200) {
//       throw Exception('Failed to update blog post');
//     }
//   }

//   Future<void> deleteBlogPost(int id) async {
//     final response = await http.delete(
//       Uri.parse('$baseUrl/posts/$id/'),
//     );
//     if (response.statusCode != 204) {
//       throw Exception('Failed to delete blog post');
//     }
//   }
// }
