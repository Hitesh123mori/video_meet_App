// import 'package:flutter/material.dart';
// import 'package:zoom_clone/Pallate.dart';
// import 'package:zoom_clone/effects/transition4.dart';
// import 'package:zoom_clone/effects/transition5.dart';
// import 'package:zoom_clone/screens/login_screen.dart';
// import 'package:zoom_clone/screens/signup/sign_up_options.dart';
//
// import '../../custom_widgets/button.dart';
// import '../../custom_widgets/text_field.dart';
//
// class signUp extends StatefulWidget {
//   const signUp({super.key});
//
//   @override
//   State<signUp> createState() => _signUpState();
// }
//
// class _signUpState extends State<signUp> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController birthController = TextEditingController();
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   bool isButtonEnabled = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Add listeners to text controllers
//     nameController.addListener(updateButtonState);
//     birthController.addListener(updateButtonState);
//   }
//
//   void updateButtonState() {
//     setState(() {
//       isButtonEnabled = nameController.text.isNotEmpty && birthController.text.isNotEmpty;
//     });
//   }
//
//
//   @override
//   void dispose() {
//     // Remove listeners when the widget is disposed
//     nameController.removeListener(updateButtonState);
//     birthController.removeListener(updateButtonState);
//     super.dispose();
//   }
//
//   Widget build(BuildContext context) {
//     final mq = MediaQuery.of(context).size;
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Scaffold(
//           backgroundColor: Colors.grey.shade100,
//           appBar: AppBar(
//             elevation: 0.2,
//             backgroundColor: AppColors.theme['secondaryColor'],
//             centerTitle: true,
//             leading: IconButton(
//               icon: Icon(
//                 Icons.keyboard_arrow_left,
//                 size: 40,
//                 color: AppColors.theme['secondaryTextColor'],
//               ),
//               onPressed: () {
//                 Navigator.push(context, SizeTransition5(LoginScreen()));
//               },
//             ),
//             title: Text(
//               "sign Up",
//               style: TextStyle(color: AppColors.theme['secondaryTextColor']),
//             ),
//           ),
//           body: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   color: Colors.grey.shade100,
//                   height: 60,
//                   width: mq.width * 1,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 22,
//                       horizontal: 20,
//                     ),
//                     child: Text(
//                       "ENTER YOUR NAME",
//                       style: TextStyle(color: Colors.grey.shade600),
//                     ),
//                   ),
//                 ),
//                 customField(
//                   hintText: 'Your Name',
//                   controller: nameController,
//                   isNumber: false,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your name';
//                     }
//                     return null;
//                   },
//                 ),
//                 Container(
//                   color: Colors.grey.shade100,
//                   height: 60,
//                   width: mq.width * 1,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 22,
//                       horizontal: 20,
//                     ),
//                     child: Text(
//                       "VERIFY YOUR AGE",
//                       style: TextStyle(color: Colors.grey.shade600),
//                     ),
//                   ),
//                 ),
//                 customField(
//                   hintText: 'Birth Year',
//                   controller: birthController,
//                   isNumber: true,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your birth year';
//                     }
//                     return null;
//                   },
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 12.0, top: 10),
//                   child: Text(
//                     "Please confirm your birth year. This data will not be stored",
//                     style: TextStyle(color: Colors.grey.shade600),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 customButton(
//                   onPressed: isButtonEnabled
//                       ? () {
//                     if (_formKey.currentState!.validate()) {
//                       Navigator.pushReplacement(context, SizeTransition5(SignUpOption()));
//                     }
//                   }
//                       : () {}, // An empty callback if the button is disabled
//                   // An empty callback if the button is disabled
//                   text: 'Confirm',
//                   textColor: isButtonEnabled
//                       ? AppColors.theme['primaryTextColor']
//                       : Colors.grey.shade600,
//                   buttonColor: isButtonEnabled
//                       ? AppColors.theme['primaryColor']
//                       : AppColors.theme['buttonColor2'],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
