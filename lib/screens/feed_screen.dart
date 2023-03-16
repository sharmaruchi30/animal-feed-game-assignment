
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:animal_feed_game/screens/done.dart';
import 'package:animal_feed_game/screens/utils/notification_service.dart';

class FeedScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  String animal;
  String babyImg;
  String kidImg;
  String teenImg;
  FeedScreen({
    Key? key,
    required this.cameras,
    required this.animal,
    required this.babyImg,
    required this.kidImg,
    required this.teenImg,
  }) : super(key: key);
  

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final  _reference = FirebaseFirestore.instance.collection("AllImages");
  late CameraController _cameraController;
  var image;
  String imageUrl='';
  int count = 0;

  NotificationService notificationService = NotificationService();
  late Future<void> cameraValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationService.initializeNotifications();
    _cameraController =
        CameraController(widget.cameras[0], ResolutionPreset.medium);
    cameraValue = _cameraController.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cameraController.dispose();
  }
  // late File _image;

  // final imagePicker = ImagePicker();

  // Future getImage() async{
  //   final image = await imagePicker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     _image = File(image!.path);
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 470,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28)),
                color: Colors.grey.shade200,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Image(image: AssetImage("assets/Fork.png")),
                        Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(100)),
                            child: image == null
                                ? FutureBuilder<void>(
                                    future: cameraValue,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        _cameraController
                                            .setFlashMode(FlashMode.off);
                                        // If the Future is complete, display the preview.
                                        return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(150),
                                            child: AspectRatio(
                                                aspectRatio: 1,
                                                child: CameraPreview(
                                                    _cameraController)));
                                      } else {
                                        // Otherwise, display a loading indicator.
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(150),
                                    child: Image.file(File(image.path)))

                            // child: _cameraController.value.isInitialized ? ClipRRect(borderRadius: BorderRadius.circular(150), child: AspectRatio( aspectRatio: 1, child: CameraPreview(_cameraController))) : const SizedBox(),
                            ),
                        const Image(image: AssetImage("assets/Spoon.png")),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      image == null ? "Click Your Meal" : "Will you eat this?",
                      style: GoogleFonts.andika(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    image == null
                        ? SizedBox(
                            height: 80,
                            width: 80,
                            child: FloatingActionButton(
                              onPressed: () async {
                                try {
                                  // await cameraValue;

                                  image = await _cameraController.takePicture();
                                  if (!mounted) {
                                    return;
                                  }
                                  // imageTaken = true;
                                  else {
                                    setState(() {});
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: const Icon(
                                Icons.camera_alt,
                                size: 35,
                              ),
                            ))
                        // IconButton(onPressed: (){

                        // }, icon: const Icon(Icons.camera_alt))

                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: FloatingActionButton(
                                    onPressed: () async{
                                      if (image == null) return;
                                      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
                                       // creating reference to upload image
                                       Reference refRoot = FirebaseStorage.instance.ref();
                                       Reference refDirImages = refRoot.child('images');

                                      Reference refImgToUpload = refDirImages.child(fileName);
                                      
                                      

                                      try{
                                        await refImgToUpload.putFile(File(image.path));
                                        imageUrl = await refImgToUpload.getDownloadURL();

                                        
                                        notificationService.sendNotification("", "Thank you for sharing food with me.");
                                      }
                                      catch(error){
                                          print(error);
                                      }
                                      finally{
                                          if ( imageUrl != ""){
                                          //   Map<String,String> sendImageData = {
                                          //  'image' : imageUrl,
                                          //   };
                                          var data = {
                                            'image' : imageUrl
                                          };
                                          await _reference.add(data);
                                          }
                                          else{
                                            print("Image URl =" + imageUrl);
                                          }
                                      }
                                      
                                      count++;
                                      print(count);
                                      // if (count == 3){
                                        
                                      //   // sleep(Duration(seconds:2));
                                      //   Navigator.push(context, MaterialPageRoute(builder: ((context) => const DonePage())));
                                      //   count=0;
                                      
                                      // }
                                      
                                      image = null;
                                      setState(() {
                                        
                                      });
                                    },
                                    child: const Icon(
                                      Icons.check,
                                      size: 35,
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      image = null;
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.cancel,
                                      size: 35,
                                    ),
                                  )),
                            ],
                          )
                  ],
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.blueGrey,
                          ),
                          child: const Icon(
                            Icons.keyboard_backspace_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      Text("Current State : ${count==1? 'Kid ${widget.animal}': count == 2 ? 'Teen ${widget.animal}' : 'Baby ${widget.animal}'}", 
                      style: GoogleFonts.andika(),
                      ), 
                    ],
                  ),
                  AnimatedContainer(
                    height: count ==1 ? 260 : count == 2? 270 : 250 ,
                    duration: Duration(seconds: 1),
                    onEnd: () {
                      if (count == 2){
                          sleep(Duration(seconds: 1));
                           Navigator.push(context, MaterialPageRoute(builder: ((context) => const DonePage())));
                           count=0;
                      }
                    },
                    child: Image(image: count == 1? AssetImage(widget.kidImg) : count == 2? AssetImage(widget.teenImg): AssetImage(widget.babyImg)),
                    
                  ),
                  // const SizedBox(height: 5,),
                  // Text("Current State : ${count==1? 'Kid' : count == 2 ? 'Teen' : 'Baby'}", 
                  // style: GoogleFonts.andika(),
                  // )
                ],
              )),
        ]),
      ),
    );
  }
  
 
}
