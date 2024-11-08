import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zoom_clone/custom_widgets/button.dart';
import 'package:zoom_clone/screens/home_screen.dart';
import '../../Pallate.dart';
import '../../custom_widgets/auth_options_containers.dart';
import '../../custom_widgets/cutsom_helpers.dart';
import '../../custom_widgets/text_field.dart';
import '../../effects/transition4.dart';
import '../../effects/transition5.dart';
import '../../resources/Api.dart';
import '../greet_screen.dart';
import '../login_screen.dart';
import '../splash_screen.dart';

class SignInOption extends StatefulWidget {
  const SignInOption({super.key});

  @override
  State<SignInOption> createState() => _SignInOptionState();
}

class _SignInOptionState extends State<SignInOption> {
  TextEditingController eController = TextEditingController();
  TextEditingController pController = TextEditingController();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  bool isButtonEnabled2 = false;
  bool isLoading = false; // Loading state variable

  // Sign in with Google
  void handlegooglebutton() {
    setState(() {
      isLoading = true;
    });
    Api.signInWithGoogle(context).then((user) async {
      setState(() {
        isLoading = false;
      });
      if (user != null) {
        bool userExists = await Api.userExistsGoogle();
        if (userExists) {
          Navigator.pushReplacement(context, SizeTransition4(HomeScreen()));
        } else {
          await Api.createUserGoogle().then(
                  (value) => Navigator.pushReplacement(context, SizeTransition4(HomeScreen())));
        }
      }
    });
  }

  // Sign in with email and password
  Future<void> login() async {
    setState(() {
      isLoading = true; // Start loading
    });
    try {
      await Api.signIn(context, eController.text, pController.text);
      User? user = Api.auth.currentUser;
      if (user != null) {
        bool userExists = await Api.userExistsEmail(user.uid);
        if (userExists) {
          Navigator.pushReplacement(context, SizeTransition4(HomeScreen()));
        }
      }
    } catch (error) {
      // Handle error
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  @override
  void initState() {
    super.initState();
    eController.addListener(updateButtonState);
    pController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled2 = eController.text.isNotEmpty && pController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    eController.removeListener(updateButtonState);
    pController.removeListener(updateButtonState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            elevation: 0.2,
            backgroundColor: AppColors.theme['secondaryColor'],
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                size: 40,
                color: AppColors.theme['secondaryTextColor'],
              ),
              onPressed: () {
                Navigator.push(context, SizeTransition5(LoginScreen()));
              },
            ),
            title: Text(
              "Sign In",
              style: TextStyle(color: AppColors.theme['secondaryTextColor'], fontWeight: FontWeight.bold),
            ),
          ),
          body: Stack(
            children: [
              Form(
                key: _formKey2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey.shade100,
                        height: 60,
                        width: mq.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                          child: Text(
                            "ENTER YOUR EMAIL ADDRESS",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                      ),
                      Divider(height: 0.2),
                      customField(
                        hintText: 'Email',
                        controller: eController,
                        isNumber: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      Divider(height: 0.2),
                      customField(
                        hintText: 'Password',
                        controller: pController,
                        isNumber: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      customButton(
                        onPressed: isButtonEnabled2
                            ? () {
                          if (_formKey2.currentState!.validate()) {
                            login();
                          }
                        }
                            : () {},
                        text: 'Sign In',
                        textColor: isButtonEnabled2
                            ? AppColors.theme['primaryTextColor']
                            : Colors.grey.shade600,
                        buttonColor: isButtonEnabled2
                            ? AppColors.theme['primaryColor']
                            : AppColors.theme['buttonColor2'],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(right: mq.width * 0.56),
                        child: TextButton(
                          onPressed: () {},
                          child: Text("Forget Password?"),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        color: Colors.grey.shade100,
                        height: 60,
                        width: mq.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                          child: Text(
                            "OTHER SIGN IN METHODS",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                      ),
                      authContainer(
                        onPressed: handlegooglebutton,
                        text: 'Continue with Google',
                        path: 'assets/images/google.png',
                      ),
                      SizedBox(height: 10),
                      authContainer(
                        onPressed: () {},
                        text: 'Continue with Apple',
                        path: 'assets/images/apple-logo.png',
                      ),
                      SizedBox(height: 10),
                      authContainer(
                        onPressed: () {},
                        text: 'Continue with Facebook',
                        path: 'assets/images/facebook.png',
                      ),
                    ],
                  ),
                ),
              ),
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(
                    color:AppColors.theme['primaryColor'],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
