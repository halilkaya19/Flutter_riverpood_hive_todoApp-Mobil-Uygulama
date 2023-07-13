import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppbarConstants{

    static final AppBarTheme appbarthemeStyle = const AppBarTheme(
        systemOverlayStyle:SystemUiOverlayStyle.light ,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        actionsIconTheme: IconThemeData(
            color: Colors.black,
        ),
    );

}