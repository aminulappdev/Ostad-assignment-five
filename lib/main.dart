import 'package:api_assignment/Utils/Colors.dart';
import 'package:flutter/material.dart';

import 'Screen/Product_list.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        inputDecorationTheme: inputDecoration(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
             backgroundColor: AppColors.appThemeColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          fixedSize: const Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          )
          )
        ),
        useMaterial3: true,
      ),
      home: const ProductListScreen(),
    );
  }

  InputDecorationTheme inputDecoration() {
    return InputDecorationTheme(
      hintStyle: const TextStyle(fontWeight: FontWeight.w300),
      fillColor: Colors.white,
      filled: true,
      border: outlineInputBorder(),
      errorBorder: outlineInputBorder(),
 
      );
  }

  OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(10));
  }
}
