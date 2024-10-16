import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String txt;
  final double size;
  const CustomText({super.key, required this.txt, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: size,
        fontFamily: GoogleFonts.aBeeZee.toString(),
      ),
    );
  }
}
