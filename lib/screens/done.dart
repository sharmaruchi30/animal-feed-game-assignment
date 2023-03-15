import 'package:animal_feed_game/screens/image_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Good Job !" , 
            style: GoogleFonts.andika(
              fontSize: 32
            ),
            ),
          ),

          ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  ImageViewScreen()));
          }, child: Text("See All Stored Images"))
        ],
      ),
    );
  }
}