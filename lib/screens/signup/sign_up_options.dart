import 'package:flutter/material.dart';
import 'package:zoom_clone/custom_widgets/button.dart';
import 'package:zoom_clone/screens/home_screen.dart';
import 'package:zoom_clone/screens/login_screen.dart';
import '../../Pallate.dart';
import '../../custom_widgets/auth_options_containers.dart';
import '../../custom_widgets/cutsom_helpers.dart';
import '../../custom_widgets/text_field.dart';
import '../../effects/Transition2.dart';
import '../../effects/transition4.dart';
import '../../effects/transition5.dart';
import '../../resources/Api.dart';

class SignUpOption extends StatefulWidget {
  const SignUpOption({super.key});

  @override
  State<SignUpOption> createState() => _SignUpOptionState();
}

class _SignUpOptionState extends State<SignUpOption> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  bool isButtonEnabled2 = false;
  bool isRegistering = false;

  // Sign up with Google
  void handleGoogleButton() {
    setState(() {
      isRegistering = true;
    });
    Api.signInWithGoogle(context).then((user) async {
      setState(() {
        isRegistering = false;
      });
      if (user != null) {
        bool userExists = await Api.userExistsGoogle();
        if (userExists) {
          Navigator.pushReplacement(context, SizeTransition4(HomeScreen()));
        } else {
          await Api.createUserGoogle().then((value) {
            Navigator.pushReplacement(context, SizeTransition4(HomeScreen()));
          });
        }
      }
    });
  }

  // Sign up with email-password
  Future<void> signUp() async {
    setState(() {
      isRegistering = true;
    });
    try {
      await Api.signUp(
        context,
        emailController.text,
        passController.text,
      );
      await Navigator.pushReplacement(context, SizeTransition2(HomeScreen()));
    } catch (error) {
      // Handle error
      print(error);
    } finally {
      setState(() {
        isRegistering = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(updateButtonState);
    passController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled2 = emailController.text.isNotEmpty && passController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    emailController.removeListener(updateButtonState);
    passController.removeListener(updateButtonState);
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return Scaffold(
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
            Navigator.pushReplacement(context, SizeTransition5(LoginScreen()));
          },
        ),
        title: Text(
          "Sign Up",
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
                    controller: emailController,
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
                    controller: passController,
                    isNumber: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      final passwordRegex = RegExp(r'^(?=.*[!@#\$%^&*])(?=.*[a-z])(?=.*[A-Z]).{6,}$');
                      if (!passwordRegex.hasMatch(value)) {
                        return 'Password must contain at least one special character, one lowercase letter, and one uppercase letter';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  customButton(
                    onPressed: isButtonEnabled2
                        ? () {
                      if (_formKey2.currentState!.validate()) {
                        signUp();
                      }
                    }
                        : () {},
                    text: 'Sign Up',
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
                        "OTHER SIGN UP METHODS",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                  authContainer(
                    onPressed: handleGoogleButton,
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
          if (isRegistering)
            Center(
              child: CircularProgressIndicator(
                color: AppColors.theme['primaryColor'],
              ),
            ),
        ],
      ),
    );
  }
}
