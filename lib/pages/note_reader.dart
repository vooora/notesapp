//page that pops up every time the note is revisited
// now used to update any information

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/HomePage.dart';
import 'package:flutter_application_1/style/app_style.dart';
import 'package:flutter_application_1/widgets/note_card.dart';
import 'package:flutter_application_1/pages/note_editor.dart';


class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.document, {super.key, String? id});
  //QueryDocumentSnapshot doc; 
  final Map<String, dynamic> document;
  String? get id => null;
 

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {

  String date = DateTime.now().toString();
  late TextEditingController _titleController;
  TextEditingController _mainController = TextEditingController();
  bool edit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String title= widget.document["note_title"]==null?"":widget.document["note_title"];
    _titleController = TextEditingController(text: title);
    String content= widget.document["note_content"]==null?"":widget.document["note_content"];
    _mainController = TextEditingController(text:content);
    int color_id = widget.document["color_id"];
  }

  @override
  Widget build(BuildContext context) {
    int color_id = widget.document['color_id'];
    return Scaffold(
      backgroundColor: Appstyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: Appstyle.cardsColor[color_id],
        elevation: 0,
        leading: IconButton(onPressed:() {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);} ,icon: Icon(Icons.arrow_back,)),
        actions: [
          Row(children: [
            IconButton(
            onPressed: () {
              FirebaseFirestore.instance
              .collection('notesapp')
              .doc(widget.id)
              .delete()
              .then((value) => {
                Navigator.pop(context),
              });
            },
            icon: Icon(
              Icons.delete,
              color: Colors.white, 
              size: 30,
            ),
          ),
            IconButton(
            onPressed: () {
              if (!mounted) return;
              setState(() {
                edit = !edit;
              });
            },
            icon: Icon(
              Icons.edit,
              color: edit? Colors.blueGrey: Colors.white,
              size: 30,
            ),
          ),

          ],)
          
        ],

      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),  
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller : _titleController,
              enabled: edit,
              style: Appstyle.MainTitle, 
            ),
            SizedBox(height:4.0),
            Text(widget.document["creation_date"], style: Appstyle.MainDate),
            SizedBox(height:30.0),
            TextFormField(
              controller : _mainController,
              enabled: edit,
              style: Appstyle.MainBody, 
            ),
          ],
        ),   
      ),

      floatingActionButton: FloatingActionButton( 
        backgroundColor: Appstyle.accentColor,
        onPressed: () {
          FirebaseFirestore.instance.collection('notesapp').doc(widget.id).update({
            "note_title": _titleController.text,
            "creation_date": date,
            "note_content": _mainController.text, 
            "color_id": color_id, 
          });
            Navigator.pop(context);    
        },
        child: Icon(Icons.save),
    ),

    );
  }
}
