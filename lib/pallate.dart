import 'package:flutter/material.dart';

hexStringToColors(String hexColor){
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }

  return Color(int.parse(hexColor, radix: 16));
}


class AppColors {
  static Map theme = themes["theme1"];

  static Map themes = {
    "theme1": {
      "primaryColor": hexStringToColors("#0047AB"),
      "secondaryColor" : hexStringToColors("#ffffff"),
      "primaryTextColor": hexStringToColors("#ffffff"),
      "secondaryTextColor" : hexStringToColors("#000000"),
      "buttonColor1" : hexStringToColors("#f26d21"),
      "buttonColor2": hexStringToColors("#E5E4E2"),
    },

  };


}