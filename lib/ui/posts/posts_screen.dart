import 'package:firebase/ui/auth/login_screen.dart';
import 'package:firebase/ui/posts/add_post.dart';
import 'package:firebase/utils/utilitis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  //  creating a firebase Instance
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Screen'),
        centerTitle: true,
        actions: [
          // Log out using firebase auth.SignOut
          IconButton(
            onPressed: () {
              auth
                  .signOut()
                  .then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen())))
                  .onError((error, stackTrace) {
                Utils().toastMsg(error.toString());
              });
            },
            icon: const Icon(Icons.login_outlined),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('This is post Screen')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPost(),
              ));
        },
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.forward_rounded),
      ),
    );
  }
}
