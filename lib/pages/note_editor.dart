//page that pops up to initially create the note

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_application_1/style/app_style.dart';
import 'package:flutter_application_1/widgets/note_card.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id = Random().nextInt(Appstyle.cardsColor.length);

  String date = DateTime.now().toString();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  String type = "";
  String category = "";  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: Appstyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title:Text(
          "Add a new note", 
          style: TextStyle(color: Colors.black))
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField( 
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none, 
                hintText: 'Note Title',
              ),
              style: Appstyle.MainTitle,
            ),
            SizedBox(height: 8.0,),
            Text(date, style:Appstyle.MainDate),
            SizedBox(height: 28.0),

            TextFormField( 
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none, 
                hintText: 'Note Content',
              ),
              style: Appstyle.MainBody,
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton( 
        backgroundColor: Appstyle.accentColor,
        onPressed: () async {
          FirebaseFirestore.instance.collection('notesapp').add({
            "note_title": _titleController.text,
            "creation_date": date,
            "note_content": _mainController.text, 
            "color_id": color_id, 
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError((error)=> print("Failed to add new note due to $error"));
        },
        child: Icon(Icons.save),
    ),
    );
  }
}