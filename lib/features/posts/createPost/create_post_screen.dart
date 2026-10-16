import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  final dio = Dio(
    BaseOptions(
      validateStatus: (status) {
        return status! <= 400 && status >= 200;
      },
    ),
  );

  var loading = false;

  void createPost() async {
    loading = true;

    setState(() {});

    try {
      int userId = Hive.box("userBox").get("id");

      final response = await dio.post(
        "https://dummyjson.com/posts/add",
        data: {
          "title": titleController.text,
          "body": bodyController.text,
          "userId": userId,
        },
      );

      String message = "";

      if (response.statusCode == 201) {
        message = "Post Created Successfully";
        titleController.clear();
        bodyController.clear();
      } else {
        message = response.data["message"];
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      print(e.toString());
    } finally {
      loading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Post")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 24,
          children: [
            TextField(
              controller: titleController,
              maxLines: 1,
              minLines: 1,
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            TextField(
              controller: bodyController,
              maxLines: 10,
              minLines: 5,
              decoration: InputDecoration(
                hintText: "Body",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            loading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () {
                      createPost();
                    },
                    child: Text("Create Post"),
                  ),
          ],
        ),
      ),
    );
  }
}
