import 'dart:ui';

import 'package:flutter/material.dart';

class TextStyleApp{

  static const TextStyle appBarTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontSize: 23
  );

  static const TextStyle inputTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 18
  );

  static const TextTheme textThemeStyle = TextTheme(
    bodyMedium: TextStyle(fontSize:15,fontWeight: FontWeight.w600,color: Colors.black),
  );

}