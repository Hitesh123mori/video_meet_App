import 'package:flutter/material.dart';

import '../Pallate.dart';


class Dialogs{

  //
  // static void showSnackBar(BuildContext context,String msg){
  //
  //   ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(msg),
  //       )
  //   ) ;
  //
  // }


  static void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) =>  Center(child: CircularProgressIndicator(color: AppColors.theme['primaryColor'],)),
    );
  }

}

