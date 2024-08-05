// theme_config.dart
import 'package:flutter/material.dart';
import 'package:vendoreventlia/view/widgets/appcolors.dart';

class ThemeConfig {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        brightness: Brightness.dark,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        titleSmall: TextStyle(color: Colors.white),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.appBarBackgroundColor,
        foregroundColor: AppColors.foregroundColor,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.buttonColor,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.elevatedButtonColor,
          foregroundColor: AppColors.foregroundColor,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFillColor,
        labelStyle: TextStyle(color: AppColors.foregroundColor),
        hintStyle: TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide.none,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.foregroundColor,
      ),
    );
  }
}
