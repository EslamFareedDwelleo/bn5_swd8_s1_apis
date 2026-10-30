import 'package:bn5_swd8_s1_apis/core/components/icon_fav_animation.dart';
import 'package:bn5_swd8_s1_apis/core/utils/navigation_helper.dart';
import 'package:bn5_swd8_s1_apis/features/posts/comments/comments_screen.dart';
import 'package:bn5_swd8_s1_apis/features/posts/createPost/create_post_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum Gender { male, female }

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  Gender currentUserGender = Gender.female;

  @override
  void initState() {
    getPosts();
    super.initState();
  }

  List posts = [];

  bool loading = true;

  void getPosts() async {
    final response = await Dio().get("https://dummyjson.com/posts");
    if (response.statusCode == 200) {
      Map data = response.data;
      posts = data["posts"];
    }
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) {
                List tags = posts[index]["tags"];
                return Card(
                  child: ListTile(
                    onTap: () {
                      context.goTo(CommentsScreen(id: posts[index]["id"]));
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         CommentsScreen(id: posts[index]["id"]),
                      //   ),
                      // );
                    },
                    title: Text(posts[index]["title"]),
                    subtitle: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            itemBuilder: (c, i) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(tags[i]),
                              );
                            },
                            itemCount: tags.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        Text(posts[index]["body"]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                IconFav(),
                                Text("${posts[index]["reactions"]["likes"]}"),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.delete),
                                Text(
                                  "${posts[index]["reactions"]["dislikes"]}",
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.visibility),
                                Text("${posts[index]["views"]}"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: posts.length,
            ),
    );
  }
}
