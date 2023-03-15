import 'package:animal_feed_game/screens/feed_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  final List<CameraDescription> cameras;
  const HomeScreen({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                
                child: ElevatedButton(
                  
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FeedScreen(cameras: cameras,) ));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)
                  )
                ),
                 child:const Padding(
                   padding:  EdgeInsets.symmetric(horizontal: 60 ,vertical: 20),
                   child:  Text("Share your meal"),
                 )),
              )
            ],
          ),
        ),
      ),
    );
  }
}