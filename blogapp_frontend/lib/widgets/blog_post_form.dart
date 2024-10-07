import 'package:flutter/material.dart';
import '../models/blog_post.dart';

class BlogPostForm extends StatefulWidget {
  final BlogPost? blogPost;
  final void Function(String title, String author, String content) onSave;

  BlogPostForm({this.blogPost, required this.onSave});

  @override
  _BlogPostFormState createState() => _BlogPostFormState();
}

class _BlogPostFormState extends State<BlogPostForm> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _author;
  late String _content;

  @override
  void initState() {
    super.initState();
    _title = widget.blogPost?.title ?? '';
    _author = widget.blogPost?.author ?? '';
    _content = widget.blogPost?.content ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: _title,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a title';
                }
                return null;
              },
              onSaved: (value) => _title = value ?? '',
            ),
            TextFormField(
              initialValue: _author,
              decoration: InputDecoration(labelText: 'Author'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter an author';
                }
                return null;
              },
              onSaved: (value) => _author = value ?? '',
            ),
            TextFormField(
              initialValue: _content,
              decoration: InputDecoration(labelText: 'Content'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter content';
                }
                return null;
              },
              onSaved: (value) => _content = value ?? '',
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  widget.onSave(_title, _author, _content);
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
