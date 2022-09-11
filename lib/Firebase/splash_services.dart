import 'dart:async';
import 'package:firebase/ui/auth/login_screen.dart';
import 'package:firebase/ui/posts/posts_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    // App will be restart and check if the current user is log in or not

    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    // If the user have already entered the login details it will skip the login screen and directly move on the post screen
    if(user!=null){
      Timer(
        const Duration(seconds: 3),
            () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostsScreen(),
          ),
        ),
      );
    }
    // Else it will go the the login screen to enter their login detail

    else{
      Timer(
        const Duration(seconds: 3),
            () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        ),
      );
    }

  }
}
