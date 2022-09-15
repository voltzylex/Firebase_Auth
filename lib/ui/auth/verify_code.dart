import 'package:firebase/ui/posts/posts_screen.dart';
import 'package:firebase/utils/utilitis.dart';
import 'package:firebase/widgets/round_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final verificationCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: verificationCodeController,
              decoration: const InputDecoration(hintText: '6 digit code'),
            ),
            const SizedBox(
              height: 80,
            ),
            RoundButton(
              title: 'Verify ',
              loading: loading,
              onTap: () async {
                setState(() {
                  loading = true;
                });
                final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: verificationCodeController.text.toString());
                try {
                  await auth.signInWithCredential(credential);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostsScreen(),
                      ));
                } catch (e) {
                  setState(() {
                    loading = false;
                    Utils().toastMsg(e.toString());
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
