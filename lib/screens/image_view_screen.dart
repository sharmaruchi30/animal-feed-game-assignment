import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
            const SizedBox(height: 20,),
              Expanded(
                child: StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection("AllImages").snapshots(),
                  builder: ((context, snapshot) {
                    return !snapshot.hasData
                        ? Text("Please wait ")
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 20,
                                    crossAxisCount: 3),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: ((context, index) {
                              return Image.network(
                                  "${snapshot.data!.docs[index]['image']}");
                            }));
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
