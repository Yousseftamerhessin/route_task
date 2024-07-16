import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StylesManger {
  static TextStyle rich() => GoogleFonts.vazirmatn(
      fontSize: 16, fontWeight: FontWeight.w700, color: Colors.teal);

  static TextStyle medium() => GoogleFonts.vazirmatn(
      fontSize: 14, fontWeight: FontWeight.w500, color: Colors.teal);

  static TextStyle small() => GoogleFonts.vazirmatn(
      fontSize: 12, fontWeight: FontWeight.w400, color: Colors.teal);

  static TextStyle extremelySmall() => GoogleFonts.vazirmatn(
      fontSize: 8, fontWeight: FontWeight.w700, color: Colors.teal);
}
