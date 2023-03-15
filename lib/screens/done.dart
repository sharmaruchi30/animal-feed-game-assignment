import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Good Job !" , 
          style: GoogleFonts.andika(
            fontSize: 32
          ),
          ),
        ),
      ),
    );
  }
}