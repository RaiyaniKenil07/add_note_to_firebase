import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditNotes extends StatefulWidget {
  DocumentSnapshot? docToEdit;

  EditNotes({this.docToEdit});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    title = TextEditingController(text: widget.docToEdit!["title"]);
    content = TextEditingController(text: widget.docToEdit!["content"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade300,
          title: Text("Edit Note"),
          actions: [
            FloatingActionButton(
              backgroundColor: Colors.transparent,
              heroTag: "save",
              onPressed: () {
                widget.docToEdit!.reference.update({
                  "title": title.text,
                  "content": content.text,
                }).whenComplete(() => Get.back());
                // ref.add({
                //   "title": title.text,
                //   "content": content.text,
                // }).whenComplete(() => Get.back());
              },
              child: Text("Save"),
              elevation: 0,
            ),
            FloatingActionButton(
              backgroundColor: Colors.transparent,
              heroTag: "Delete",
              onPressed: () {
                widget.docToEdit!.reference
                    .delete()
                    .whenComplete(() => Get.back());
              },
              child: Text("Delete"),
              elevation: 0,
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 9, vertical: 9),
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
