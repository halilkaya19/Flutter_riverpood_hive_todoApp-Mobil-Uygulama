import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapphiveriverpoodoneweek/models/todo_model.dart';
import 'package:todoapphiveriverpoodoneweek/pages/todo_home_page.dart';

import 'constants/appbar_constants.dart';
import 'constants/colors_constants.dart';
import 'constants/textstyle_constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  configLoading();
  await Hive.initFlutter("uygulama");
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<TodoModel>('todoModels');
  runApp(const ProviderScope(child:MyApp()));
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1000)
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.blue
    ..backgroundColor = Colors.white10
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.6)
    ..userInteractions = true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppbarConstants.appbarthemeStyle,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryColors
        ),
        textTheme: TextStyleApp.textThemeStyle
      ),
      home: TodoHomePages(),
    );
  }

}


