import 'package:animal_feed_game/screens/home_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp( MyApp(cameras: cameras,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key , required this.cameras});
  final List<CameraDescription> cameras;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Feed Animals",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey
      ),
      home: HomeScreen(cameras: cameras,),
    );
  }
}