import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNote extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection("Notes");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade300,
          title: Text("Edit Note"),
          actions: [
            FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                ref.add({
                  "title": title.text,
                  "content": content.text,
                }).whenComplete(() => Get.back());
              },
              child: Text("Save"),
              elevation: 0,
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 8),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(hintText: "Title"),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: TextField(
                    controller: content,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(hintText: "Content"),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
