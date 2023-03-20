//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/SignUpPage.dart';
import 'package:flutter_application_1/pages/note_editor.dart';
import 'package:flutter_application_1/pages/note_reader.dart';
import 'package:flutter_application_1/services/Auth_Service.dart';
import 'package:flutter_application_1/style/app_style.dart';
import 'package:flutter_application_1/widgets/note_card.dart';
import 'package:google_fonts/google_fonts.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> _stream= FirebaseFirestore.instance.collection("notesapp").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.bgColor,
      appBar: AppBar( 
        elevation: 2.0,
        title: Text('Your notes'),
        centerTitle: true,
        backgroundColor: Appstyle.mainColor,
        actions: [
          IconButton(onPressed: ()async {
            await authClass.logout();
            Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (builder) => SignUpPage()), 
                (route) => false);   
          }, icon: Icon(Icons.logout))
        ],

      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(  
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your recent notes",
              style: GoogleFonts.roboto(color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              ),
            ),
            SizedBox( 
              height: 20.0,
            ),
            Expanded(
              child: StreamBuilder(
                stream: _stream,
                builder: (context, snapshot){
            
                  if (!snapshot.hasData) {
                    return Center (
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasData == ConnectionState.waiting) {
                    return Center (
                      child: CircularProgressIndicator(),
                    );
                  }
             
                  return Scrollbar(            
                    thickness: 20,
                    isAlwaysShown: true,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                        Map<String,dynamic> document = snapshot.data!.docs[index].data() as Map<String,dynamic>;
                        return GridTile(child: 
                          InkWell(
                            onTap: () {
                              Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (builder)=> NoteReaderScreen(
                                document,
                                id: snapshot.data?.docs[index].id,
                                ),
                              ),
                              );
                            },
                            child: noteCard(
                              document["note_title"]==null?"":document["note_title"], 
                              document["creation_date"]==null?"":document["creation_date"], 
                              document["note_content"]==null?"":document["note_content"], 
                              document["color_id"]==null?"2":document["color_id"], 
                            ),
                          ),);
                      } ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> NoteEditorScreen()));
      }, label: Text("Add Note"), icon: Icon(Icons.add)),

    );
  }
}
