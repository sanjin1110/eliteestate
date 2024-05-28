import 'package:flutter/material.dart';

import '../constants/app_color_constant.dart';

class AppTheme {
  AppTheme._();

  static getApplicationTheme() {
    return ThemeData(
        colorScheme: const ColorScheme.light(
          primary: AppColorConstant.primaryColor,
        ),
        fontFamily: 'open_sans',
        useMaterial3: true,
        // Change app bar color

        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColorConstant.appBarColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        // Change elevated button theme

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 216, 73, 73),
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: const Color.fromARGB(255, 62, 89, 243),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
        ),

        // Change text field theme
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(15),
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelStyle: const TextStyle(
            fontSize: 20,
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColorConstant.primaryColor,
            ),
          ),
        ),
        // Circular progress bar theme
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColorConstant.primaryColor,
        ),
        //Bottom navigation bar theme

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color.fromARGB(255, 227, 227, 227),
          selectedItemColor: Colors.blue.shade500,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ));
  }
}
