import 'package:flutter/material.dart';


class Dialogs{


  static showSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }


  static void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

}

