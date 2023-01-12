import 'package:add_note_to_firebase/edit_noted.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  CollectionReference ref = FirebaseFirestore.instance.collection("Notes");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddNote());
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue.shade300,
          title: Text("Notes"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
              stream: ref.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return GridView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 6,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(EditNotes(
                          docToEdit: snapshot.data!.docs[index],
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue.shade100),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data!.docs[index]["title"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                              ),
                              child: Text(
                                snapshot.data!.docs[index]["content"],
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
        ));
  }
}
