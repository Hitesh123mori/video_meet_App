import 'package:flutter/material.dart';
import 'package:zoom_clone/custom_widgets/button.dart';
import 'package:zoom_clone/screens/greet_screen.dart';
import '../../Pallate.dart';
import '../../custom_widgets/auth_options_containers.dart';
import '../../custom_widgets/cutsom_helpers.dart';
import '../../custom_widgets/text_field.dart';
import '../../effects/transition4.dart';
import '../../resources/Api.dart';
import '../splash_screen.dart';
import 'confirmation_signup.dart';

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


  void handlegooglebutton(){
    Dialogs.showProgressBar(context);
    Api.signInWithGoogle(context).then((user) async {
      Navigator.pop(context);

      if (user != null) {
        bool userExists = await Api.userExists();
        if (userExists) {
          Navigator.pushReplacement(context, SizeTransition4(GreetScreen()));
        } else {
          await Api.createUser().then((value) => Navigator.pushReplacement(context, SizeTransition4(GreetScreen()))) ;
        }
      }
    });
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
    // Remove listeners when the widget is disposed
    //
    emailController.removeListener(updateButtonState);
    passController.removeListener(updateButtonState);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    mq  = MediaQuery.of(context).size ;

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
                  Navigator.push(context, SizeTransition4(signUp()));
                },
              ),
              title: Text(
                "sign Up",
                style: TextStyle(color: AppColors.theme['secondaryTextColor']),
              ),
            ),
            body: Form(
              key: _formKey2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey.shade100,
                      height: 60,
                      width: mq.width * 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 22,
                          horizontal: 20,
                        ),
                        child: Text(
                          "ENTER YOUR EMAIL ADDRESS",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),
                    ),
                    Divider(height: 0.2,),
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
                    Divider(height: 0.2,),
                    customField(
                      hintText: 'Password',
                      controller: passController,
                      isNumber: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    customButton(
                      onPressed: isButtonEnabled2
                          ? () {
                        if (_formKey2.currentState!.validate()) {

                        }
                      }
                          : () {}, // An empty callback if the button is disabled
                      text: 'Sign Up',
                      textColor: isButtonEnabled2
                          ? AppColors.theme['primaryTextColor']
                          : Colors.grey.shade600,
                      buttonColor: isButtonEnabled2
                          ? AppColors.theme['primaryColor']
                          : AppColors.theme['buttonColor2'],
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding:  EdgeInsets.only(right :mq.width*0.56),
                      child: TextButton(
                          onPressed: (){},
                          child: Text("Forget Password?")
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      color: Colors.grey.shade100,
                      height: 60,
                      width: mq.width * 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 22,
                          horizontal: 20,
                        ),
                        child: Text(
                          "OTHER SIGN IN METHODS",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),
                    ),
                    authContainer(
                      onPressed: ()  {
                        handlegooglebutton() ;
                      },
                      text: 'Continue with Google',
                      path: 'assets/images/google.png',

                    ),
                    SizedBox(height: 10,),
                    authContainer(
                      onPressed: () {  },
                      text: 'Continue with Apple',
                      path: 'assets/images/apple-logo.png',

                    ),
                    SizedBox(height: 10,),
                    authContainer(
                      onPressed: () {  },
                      text: 'Continue with facebook',
                      path: 'assets/images/facebook.png',

                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
