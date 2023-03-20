import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Appstyle {
  static Color bgColor = Color(0xFF2E3440);
  static Color accentColor = Color(0x4C566A);
  static Color mainColor = Color(0x3B4252);

  static List<Color> cardsColor = [

    Color(0xFF5E81AC),
    Color(0xFF81A1C1),
    Color(0xFF88C0D0),
    Color(0xFF8FBCBB),
    Color(0xFFB48EAD),
  
  ];

  static TextStyle MainTitle = 
    GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold);
  
  static TextStyle MainBody = 
    GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.normal);

  static TextStyle MainDate = 
    GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.normal);
    
  


}