import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/blog_post.dart';
import '../services/api_service.dart';
import 'blog_create_page.dart';
import 'blog_update_page.dart';
import 'blog_detail_page.dart';

class BlogListPage extends StatefulWidget {
  final String token;

  BlogListPage({required this.token});

  @override
  _BlogListPageState createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(token: widget.token);
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
      timeInSecForIosWeb: 5, // Set this to the desired duration in seconds
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Posts', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<BlogPost>>(
        future: apiService.fetchBlogPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('No blog posts available.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final blogPost = snapshot.data![index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                elevation: 5,
                child: ListTile(
                  title: Text(blogPost.title, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('By ${blogPost.author}', style: TextStyle(color: Colors.grey[600])),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlogDetailPage(blogPost: blogPost),
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.orange),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlogUpdatePage(
                                blogPost: blogPost,
                                token: widget.token,
                              ),
                            ),
                          );
                          _showToast("Blog updated successfully!");
                          setState(() {}); // Refresh the list after update
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          if (blogPost.id != null) {
                            try {
                              await apiService.deleteBlogPost(blogPost.id!);
                              _showToast("Blog deleted successfully!");
                              setState(() {}); // Refresh the list after deletion
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to delete post: $e')),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogCreatePage(token: widget.token),
            ),
          );
          _showToast("New blog added successfully!");
          setState(() {}); // Refresh the list after a new blog is added
        },
      ),
    );
  }
}



// second time with user login default user
// import 'package:flutter/material.dart';
// import '../models/blog_post.dart';
// import '../services/api_service.dart';
// import 'blog_create_page.dart';
// import 'blog_update_page.dart';
// import 'blog_detail_page.dart';

// class BlogListPage extends StatefulWidget {
//   final String token;

//   BlogListPage({required this.token});

//   @override
//   _BlogListPageState createState() => _BlogListPageState();
// }

// class _BlogListPageState extends State<BlogListPage> {
//   late ApiService apiService;

//   @override
//   void initState() {
//     super.initState();
//     apiService = ApiService(token: widget.token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Blog Posts'),
//       ),
//       body: FutureBuilder<List<BlogPost>>(
//         future: apiService.fetchBlogPosts(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
//             return Center(child: Text('No blog posts available.'));
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               final blogPost = snapshot.data![index];
//               return ListTile(
//                 title: Text(blogPost.title),
//                 subtitle: Text(blogPost.author),
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BlogDetailPage(blogPost: blogPost),
//                   ),
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.edit),
//                       onPressed: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BlogUpdatePage(
//                             blogPost: blogPost,
//                             token: widget.token,
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () async {
//                         if (blogPost.id != null) {
//                           try {
//                             await apiService.deleteBlogPost(blogPost.id!);
//                             setState(() {}); // Refresh the list after deletion
//                           } catch (e) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('Failed to delete post: $e')),
//                             );
//                           }
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () => Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BlogCreatePage(token: widget.token),
//           ),
//         ),
//       ),
//     );
//   }
// }



//first time
// import 'package:flutter/material.dart';
// import '../models/blog_post.dart';
// import '../services/api_service.dart';
// import 'blog_create_page.dart';
// import 'blog_update_page.dart';
// import 'blog_detail_page.dart';

// class BlogListPage extends StatefulWidget {
//   @override
//   _BlogListPageState createState() => _BlogListPageState();
// }

// class _BlogListPageState extends State<BlogListPage> {
//   ApiService apiService = ApiService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Blog Posts'),
//       ),
//       body: FutureBuilder<List<BlogPost>>(
//         future: apiService.fetchBlogPosts(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
//             return Center(child: Text('No blog posts available.'));
//           }
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               final blogPost = snapshot.data![index];
//               return ListTile(
//                 title: Text(blogPost.title),
//                 subtitle: Text(blogPost.author),
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BlogDetailPage(blogPost: blogPost),
//                   ),
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.edit),
//                       onPressed: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BlogUpdatePage(blogPost: blogPost),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () async {
//                         if (blogPost.id != null) {
//                           await apiService.deleteBlogPost(blogPost.id!);
//                           setState(() {});
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () => Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BlogCreatePage(),
//           ),
//         ),
//       ),
//     );
//   }
// }
