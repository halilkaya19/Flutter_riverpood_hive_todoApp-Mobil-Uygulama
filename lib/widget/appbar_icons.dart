import 'package:flutter/material.dart';

class AppbarIcons extends StatelessWidget {
  final VoidCallback hover;
  final Icon icons;
  const AppbarIcons({required this.hover,required this.icons,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: hover, icon:icons);
  }
}
