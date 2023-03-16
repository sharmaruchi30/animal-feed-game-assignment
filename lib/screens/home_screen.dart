import 'package:animal_feed_game/screens/feed_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const HomeScreen({super.key, required this.cameras});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> animals = ['Smilodon' , 'Mammoth' , 'Orca' , 'Dino' , 'Dodo'];
  List<String> imgbaby = ['assets/smilodon/babyS.png' ,'assets/mammoth/BabyM.png' , 'assets/orca/BabyO.png' , 'assets/dino/BabyD.png' , 'assets/dodo/Baby_dodo.png'];
  List<String> imgkid = ['assets/smilodon/KidS.png' ,'assets/mammoth/KidM.png' , 'assets/orca/KidO.png' , 'assets/dino/KidD.png' , 'assets/dodo/Baby_dodo.png'];
  List<String> imgteen = ['assets/smilodon/TeenS.png' ,'assets/mammoth/TeenM.png' , 'assets/orca/TeenO.png' , 'assets/dino/TeenD.png' , 'assets/dodo/Teen_dodo.png'];  
  int selectedIndex = 0;
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
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: animals.length,
                  itemBuilder: ((context, index) {
                  
                  return Padding(
                    padding: const EdgeInsets.only( bottom:8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                        selectedIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedIndex == index  ? Colors.grey.shade400 : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(22,)
                        ),
                    
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(animals[index] ,
                            style: GoogleFonts.andika(
                              fontSize: 18
                            ),
                            ),
                    
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image(image: AssetImage(imgbaby[index])),
                            )
                          ],
                    
                          
                        ),
                      ),
                    ),
                  );
                })),
              ),

              const SizedBox(height: 20,),
              Center(
                
                child: ElevatedButton(
                  
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FeedScreen(cameras: widget.cameras, animal: animals[selectedIndex], babyImg: imgbaby[selectedIndex], kidImg: imgkid[selectedIndex], teenImg: imgteen[selectedIndex],) ));
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