import 'package:firebase/ui/auth/verify_code.dart';
import 'package:firebase/utils/utilitis.dart';
import 'package:firebase/widgets/round_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneNumberController = TextEditingController();
  bool loading = false;
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
              controller: phoneNumberController,
              decoration: const InputDecoration(hintText: '+91 99999 00000'),
            ),
            const SizedBox(
              height: 80,
            ),
            RoundButton(
              title: 'Login ',
              loading: loading,
              onTap: () {
                setState(() {
                  loading = true;
                });
                auth.verifyPhoneNumber(
                    // Add phone number controller to read the number entered by by the user
                    phoneNumber: phoneNumberController.text,
                    // After phone number verification process will start
                    verificationCompleted: (_) {

                  setState(() {
                    loading = false;
                  });
                }, verificationFailed: (e) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMsg(e.toString());
                }, codeSent: (String verificationId, int? tokenId) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VerifyCodeScreen(verificationId: verificationId),
                      ));
                  setState(() {
                    loading = false;
                  });
                }, codeAutoRetrievalTimeout: (e) {
                  Utils().toastMsg(e.toString());
                  setState(() {
                    loading = false;
                  });
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
