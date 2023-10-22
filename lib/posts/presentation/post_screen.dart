import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  final String postId;

  const PostScreen({
    required this.postId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('POST ID: $postId'),
      ),
    );
  }
}
