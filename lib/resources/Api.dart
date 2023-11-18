import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone/custom_widgets/cutsom_helpers.dart';

import 'models/user.dart';

class Api {


  // Objects ----------------------------------------------------------------
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // to return current user
  static User get user => auth.currentUser!;



  // Auth Works here---------------------------------------------------------


  //1).GOOGLE SIGNIN
 static  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try{
      await InternetAddress.lookup("google.com");
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await Api.auth.signInWithCredential(credential);
    }catch(e){
      print('_signInWithGoogle ${e}') ;
      print('please check internet') ;
      Dialogs.showSnackBar(context, "Something Went Wrong Please Check Internet") ;
      return null ;
    }
  }


 //   2).Check User Existance in Firebase

  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // 3).If User not exist then creat new Zoom User
  static Future<void> createUser() async {


    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ZoomUser(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      image: user.photoURL.toString(),
      createdAt: time,
    );

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }



}
