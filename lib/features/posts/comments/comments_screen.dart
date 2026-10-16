import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CommentsScreen extends StatefulWidget {
  final int id;
  const CommentsScreen({super.key, required this.id});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  void initState() {
    getComments();
    super.initState();
  }

  List comments = [];

  bool loading = true;

  void getComments() async {
    final response = await Dio().get(
      "https://dummyjson.com/posts/${widget.id}/comments",
    );

    if (response.statusCode == 200) {
      final Map data = response.data;
      comments = data["comments"];
    }

    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comments")),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(comments[index]["user"]["fullName"]),
                        Icon(Icons.favorite),
                        Text("${comments[index]["likes"]}"),
                      ],
                    ),
                    subtitle: Text(comments[index]["body"]),
                  ),
                );
              },
              itemCount: comments.length,
            ),
    );
  }
}
