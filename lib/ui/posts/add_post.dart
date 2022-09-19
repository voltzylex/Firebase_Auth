import 'package:firebase/utils/utilitis.dart';
import 'package:firebase/widgets/round_buttons.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool loading = false;
  final postController = TextEditingController();
  // Refrense to save text in database
  final databaseRef = FirebaseDatabase.instance.ref('Test');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: const InputDecoration(
                  hintText: "Whats in your mind ?",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
              loading: loading,
              title: "Add Note",
              onTap: () {
                // Allow to show animation loading screen
                setState(() {
                  loading = true;
                });
                //
                databaseRef
                    .child(DateTime.now().millisecondsSinceEpoch.toString())
                    .child('comments')
                    .set({
                  // This will give a unique id from date and time and give title == text from enterd by the user
                  'title': postController.text.toString(),
                  'id': DateTime.now().millisecondsSinceEpoch.toString(),
                }).then((value) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMsg('postAdded');
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMsg(error.toString());
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
