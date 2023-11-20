import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../effects/transition5.dart';
import '../screens/login_screen.dart';
import 'models/user.dart';

class Api {
  // Objects ----------------------------------------------------------------
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // to return current user
  static User get user => auth.currentUser!;

  static MeetUser? curUser ;


  // for accessing firebase storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  // Sign out -----------
  static Future<void> signOut(BuildContext context) async {
    await Api.auth.signOut().then((value) async {
      await GoogleSignIn().signOut().then((value) {
        Future.delayed(Duration.zero, () {
          Navigator.pushReplacement(
            context,
            SizeTransition5(LoginScreen()),
          );
        });
      });
    });
  }
  // Auth Works here---------------------------------------------------------

  //1).GOOGLE SIGNIN
  static Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      await InternetAddress.lookup("google.com");
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await Api.auth.signInWithCredential(credential);
    } catch (e) {
      print('_signInWithGoogle ${e}');
      print('please check internet');
      return null;
    }
  }

  // sign in with email/password
  static Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {


      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message ?? 'An error occurred during sign in.'),
        backgroundColor: Colors.red,
      ));
    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred. Please try again later.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  // signup method-------------------------------------------------------------------------------------------------------------------------------------
  static Future<void> signUp(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await createUserEmail(userCredential, email, password);

    } on FirebaseAuthException catch (e) {


      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message ?? 'An error occurred during registration.'),
        backgroundColor: Colors.red,
      ));
    } catch (e) {


      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred. Please try again later.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  //   Check User (log in with email/password) Existance in Firebase

  static Future<bool> userExistsEmail(String userId) async {
    return (await firestore.collection('users').doc(userId).get()).exists;
  }

  // create user if log in with email
  static Future<void> createUserEmail(
      UserCredential userCredential, String email, String password) async {
    print("User id : ${userCredential.user!.uid}");

    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final meetUser = MeetUser(
      id: userCredential.user!.uid,
      name: "",
      email: email,
      image: "",
      createdAt: time,
      method: "Email-Password",
    );

    return await firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .set(meetUser.toJson());
  }

  //   Check User (log in with google) Existance in Firebase

  static Future<bool> userExistsGoogle() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // If User not exist then create(Log in with google) new Zoom User
  static Future<void> createUserGoogle() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

     final meetUser = MeetUser(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      image: user.photoURL.toString(),
      createdAt: time,
      method: "Google",
    );

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(meetUser.toJson());
  }

  // for storing self information
  static MeetUser me = MeetUser(
    id: user.uid,
    name: user.displayName.toString(),
    email: user.email.toString(),
    image: user.photoURL.toString(),
    createdAt: '',
    method: '',
  );

  // update user profile picture

  static Future<void> fillDetailsEmailUser(File file, String name) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    print('Extension: $ext');

    //storage file ref with path
    final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      print('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    me.image = await ref.getDownloadURL();
    me.name = name ;
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'image': me.image, 'name': me.name});
  }


  // accessing current user information

  static Future<MeetUser?> getSelfData(String uid) async {
    DocumentSnapshot doc = await firestore.collection("users").doc(uid).get();

    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
       Api.curUser = MeetUser.fromJson(data);
    } else {
      return null;
    }
    return null;
  }

}
