import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import 'package:zoom_clone/resources/models/meeting.dart';
import '../effects/transition5.dart';
import '../screens/login_screen.dart';
import 'models/user.dart';

class Api {
  // Objects ----------------------------------------------------------------
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user {
    if (auth.currentUser == null) {
      throw Exception("User is not authenticated.");
    }
    return auth.currentUser!;
  }


  static String id = "${Api.curUser!.name}_${Api.curUser!.id}" ;

  static MeetUser? curUser ;






  // for accessing firebase storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  // Sign out -----------
  static Future<void> signOut(BuildContext context) async {
    try {
      // Sign out from Firebase authentication
      await Api.auth.signOut();
      Navigator.pushReplacement(
        context,
        SizeTransition5(LoginScreen()),
      );
    } catch (e) {
      print("Error signing out: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred during sign out")),
      );
    }
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

  static Future<void> signUp(
      BuildContext context, String email, String password) async {
    print("#COME");

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await createUserEmail(userCredential, email, password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully registered!'),
          backgroundColor: Colors.green,
        ),
      );

    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'email-already-in-use') {
        errorMessage = 'This email is already in use.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email format.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Password is too weak.';
      } else {
        errorMessage = 'An unknown error occurred.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  //   Check User (log in with email/password) Existance in Firebase

  static Future<bool> userExistsEmail(String userId) async {
    return (await firestore.collection('users').doc(userId).get()).exists;
  }

  // creating a personal meeting id for each user



 static String generateUniqueId(String email) {

    var bytes = utf8.encode(email);
    var digest = sha256.convert(bytes);


    int id = int.parse(digest.toString().substring(0, 8), radix: 16);

    String idString = id.toString();


    idString = idString.replaceFirst(RegExp('^0+'), '');


    idString = idString.isEmpty ? '0' : idString;

    idString = idString.padLeft(12, '0');

    return idString;
  }

  // create user if log in with email
  static Future<void> createUserEmail(
      UserCredential userCredential, String email, String password) async {
    print("User id : ${userCredential.user!.uid}");

    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final meetUser = MeetUser(
      id: userCredential.user!.uid,
      name: email,
      email: email,
      image: "",
      createdAt: time,
      method: "Email-Password",
      meetingId: generateUniqueId(email),
      isAudioConnect: true,
      isSpeakerOn: true,
      isVideoOn: true,

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


  // create a new meeting

  static Future<DocumentReference<Map<String, dynamic>>> createMeeting(String meetingName,String password) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final newMeeting = Meeting(
      name: meetingName,
      hostName: Api.curUser!.name,
      hostEmail: Api.curUser!.email,
      date: time,
      meetingId: Api.curUser!.meetingId,
      password: password,
    );

    return await FirebaseFirestore.instance
        .collection('users/${Api.curUser!.id}/your_meeting') // Use correct path
        .add(newMeeting.toJson());
  }



  // meeting that you joined


  static Future<Meeting?> fetchMeetingDataInHost(String id, String meetingPass, String meetingId , BuildContext context) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users/$id/your_meeting")
          .where("password", isEqualTo: meetingPass)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return await getMeetingInfo(querySnapshot.docs.first.id.toString(), id);
      } else {
        // Show a dialog if the query is not found
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Meeting Not Found'),
              content: Text('The meeting with ID $meetingId was not currently running.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return null;
      }
    } catch (e) {
      print("Error fetching meeting data: $e");
      return null;
    }
  }



  // fetch data for finding host id
  static Future<MeetUser?> fetchMeetingDataJoinedByAttribute(String userMeetingId,BuildContext context) async {
    final QuerySnapshot querySnapshot = await firestore.collection("users")
        .where("meetingId", isEqualTo: userMeetingId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {


      return await getJoiningData(querySnapshot.docs.first.id.toString()) ;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Meeting ID Not Found'),
            content: Text('Meeting ID $userMeetingId is not exist , Please try another.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
    return null;
  }





  // fetch data for finding host all info
  static Future<MeetUser?> getJoiningData(String documentId) async {
    DocumentSnapshot doc = await firestore.collection("users").doc(documentId).get();

    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      print("Mynaame : ${MeetUser.fromJson(data).name}") ;
      return MeetUser.fromJson(data);
    } else {
      return null;
    }
  }

  //fetch specific meeting

  static Future<Meeting?> getMeetingInfo(String documentId, String id) async {

    DocumentSnapshot doc = await firestore.collection("users/${id}/your_meeting").doc(documentId).get();

    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Meeting.fromJson(data);
    } else {
      return null;
    }
  }






  // store joining data in curUser database
  static Future<DocumentReference<Map<String, dynamic>>> joinMeeting(MeetUser meetUser,String Password , BuildContext context) async {


    Meeting? meeting =  await fetchMeetingDataInHost(meetUser.id,Password,meetUser.meetingId,context) ;


    final newMeeting = Meeting(
      name: meeting!.name,
      hostName: meeting!.hostName,
      hostEmail: meeting!.hostEmail,
      date: meeting!.date,
      meetingId: meetUser.meetingId,
      password: '',
    );

    return await FirebaseFirestore.instance
        .collection('users/${Api.curUser!.id}/Joined_Meeting') // Use correct path
        .add(newMeeting.toJson());
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
       meetingId: generateUniqueId(user.email.toString()),
       isAudioConnect: true,
       isSpeakerOn: true,
       isVideoOn: true,
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
    meetingId: '',
    isAudioConnect: true,
    isSpeakerOn: true,
    isVideoOn: true,
  );

  // update user profile picture

  static Future<void> updateProfilePicture(File file) async {
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
    curUser!.image = await ref.getDownloadURL();
    await firestore
        .collection('users')
        .doc(curUser!.id)
        .update({'image': curUser!.image});
  }


  // update user details picture

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

  // update user  join options

  static Future<void> updateJoinOptions(String name,bool isAudio,bool isVideo ,bool isSpeaker) async {
    firestore.collection('users').doc(user.uid).update({
      'name' : name,
      'isAudioConnect' :isAudio,
       'isSpeakerOn'  :isSpeaker,
       'isVideoOn' : isVideo,
    });
  }

  // sending invitaition to whatsapp


  static void sendInvitation(String data){
    String url = "whatsapp://send?text=${data}" ;
    launchUrl(Uri.parse(url)) ;
  }

  // get data of created meeting
  static Stream<QuerySnapshot<Map<String, dynamic>>> getCreatedMeetingData() {

    return firestore
        .collection('users/${curUser!.id}/your_meeting')
        .snapshots();
  }

  // get data of joined meeting
  static Stream<QuerySnapshot<Map<String, dynamic>>> getJoinedMeetingData() {

    return firestore
        .collection('users/${curUser!.id}/Joined_Meeting')
        .snapshots();
  }



  // get users
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {

    return firestore
        .collection('users')
        .where('id', isNotEqualTo: curUser?.id)
        .snapshots();
  }


  // get user contact
  static Stream<QuerySnapshot<Map<String, dynamic>>> getYourContact() {

    return firestore
        .collection('users/${curUser!.id}/your_contacts')
        .snapshots();
  }

  // your contacts

  static Future<void> addContacts(List<MeetUser> selectedUsers) async {
    // Create a WriteBatch
    WriteBatch batch = firestore.batch();

    for (var user in selectedUsers) {
      final meetUser = MeetUser(
        id: user.id,
        name: user.name,
        email: user.email,
        image: user.image,
        createdAt: user.createdAt,
        method: user.method,
        meetingId: user.meetingId,
        isAudioConnect: user.isAudioConnect,
        isSpeakerOn: user.isSpeakerOn,
        isVideoOn: user.isVideoOn,
      );

      // Add the user to the batch
      batch.set(
        firestore.collection('users/${curUser!.id}/your_contacts').doc(user.id),
        meetUser.toJson(),
      );
    }

    // Commit the batch
    return await batch.commit();
  }




  // fetch  contact details
  static Future<String?> fetchContactDetails(String name) async {

      final QuerySnapshot querySnapshot = await firestore.collection('users/${curUser?.id}/your_contacts')
          .where("name", isEqualTo: name)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print("finding done") ;
        deleteContact(querySnapshot.docs.first.id.toString());
        return querySnapshot.docs.first.id.toString() ;
      } else {
        return null;
      }

  }



  // when delete contact

  // when selection done delete users
  static Future<void> deleteContact(String id) async {

    try {
      await FirebaseFirestore.instance
          .collection("users/${curUser!.id}/your_contacts")
          .doc(id)
          .delete();
      print("deletion done") ;
    } catch (e) {
      print("Error delete selection contact: $e");
    }
  }


  // adding upcoming meetings


  static Future<DocumentReference<Map<String, dynamic>>> createUpcomingMeeting(String meetingName,String password, List<MeetUser> participants ,String Meetingtime) async {

    final newMeeting = Meeting(
      name: meetingName,
      hostName: Api.curUser!.name,
      hostEmail: Api.curUser!.email,
      date: Meetingtime,
      meetingId: Api.curUser!.meetingId,
      password: password,
    );


    await addParicipants(participants) ;

      return await FirebaseFirestore.instance
          .collection('users/${curUser!.id}/your_schedule/${generateUniqueId(id)}/meeting_info')
          .add(newMeeting.toJson());

  }


  // storing participants


  static Future<void> addParicipants(List<MeetUser> selectedUsers) async {
    // Create a WriteBatch


    WriteBatch batch = firestore.batch();

    for (var user in selectedUsers) {

      final meetUser = MeetUser(
        id: user.id,
        name: user.name,
        email: user.email,
        image: user.image,
        createdAt: user.createdAt,
        method: user.method,
        meetingId: user.meetingId,
        isAudioConnect: user.isAudioConnect,
        isSpeakerOn: user.isSpeakerOn,
        isVideoOn: user.isVideoOn,
      );



      // Add the user to the batch
      batch.set(
        firestore.collection('users/${curUser!.id}/your_schedule/${generateUniqueId(id)}/participants').doc(user.id),
        meetUser.toJson(),
      );




    }

    // Commit the batch
    return await batch.commit();
  }


  // acess meeting info


  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchUpcomingMeeting() {

    return firestore
        .collection('users/${curUser!.id}/your_schedule/${generateUniqueId(id)}/meeting_info')
        .snapshots();
  }



}
