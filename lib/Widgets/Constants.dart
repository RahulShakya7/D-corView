import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//
// const primaryColor = Color(0xFF2697FF);
// const secondaryColor = Color(0xFF0B0B10);
// const bgColor = Color(0xFFE8E8E8);
// const textColor=Color(0xFF090909);
const lightThemeColor=Colors.black45;
const darkThemeColor=Colors.white70;
const defaultPadding = 12.0;
const kCompleted='Completed';
const kProcessing='Processing';
const kCancelled='Cancelled';


ThemeData darkTheme = ThemeData(

    backgroundColor: Colors.black45,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      displayColor:darkThemeColor,
      bodyColor: Colors.white,
    ),
    hintColor: darkThemeColor,
    inputDecorationTheme: InputDecorationTheme(
      iconColor: darkThemeColor,
      focusedBorder:OutlineInputBorder(
        borderSide: const BorderSide(color: darkThemeColor, width: 1.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
      border: const OutlineInputBorder(),
      labelStyle: const TextStyle(
        color:darkThemeColor,

      ),),



    focusColor: Colors.white,
    brightness: Brightness.dark,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: darkThemeColor,
      selectionColor: darkThemeColor,
      selectionHandleColor: darkThemeColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape:MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),

          ),),

          backgroundColor: MaterialStateProperty.all<Color>(Colors.purpleAccent),
          textStyle:  MaterialStateProperty.all<TextStyle>(const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
          )),
        )
    )
);

ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      color: Colors.deepPurpleAccent,
      centerTitle: true,

    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      displayColor: Colors.black54,
      bodyColor: Colors.black54,

    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: lightThemeColor,
      primary: lightThemeColor, //<-- SEE HERE
    ),
    hintColor: lightThemeColor,
    inputDecorationTheme: InputDecorationTheme(
      iconColor: lightThemeColor,
      focusedBorder:OutlineInputBorder(
        borderSide: const BorderSide(color: lightThemeColor, width: 1.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
      border: const OutlineInputBorder(),
      labelStyle: const TextStyle(
        color:lightThemeColor,

      ),),

    brightness: Brightness.light,

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape:MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),

          ),),

          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
          textStyle:  MaterialStateProperty.all<TextStyle>(const TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
        )
    )
);