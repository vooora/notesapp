import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/style/app_style.dart';



class noteCard extends StatelessWidget {
  const noteCard(this.title, this.date, this.content, this.color_id, {super.key});

  final String title;
  final String date;
  final String content;
  final int color_id;
 
  @override
  Widget build(BuildContext context) {
    return Container( 
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Appstyle.cardsColor[color_id],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Appstyle.MainTitle),
          SizedBox(height:4.0),
          Text(date, style: Appstyle.MainDate),
          SizedBox(height:8.0),
          Text(content, style: Appstyle.MainBody, overflow: TextOverflow.ellipsis,),
          
        ],
      ),
    );


  }
}

/*
Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {

  return InkWell(
    onTap: onTap,
    child: Container( 
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Appstyle.cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doc["note_title"], style: Appstyle.MainTitle),
          SizedBox(height:4.0),
          Text(doc["creation_date"], style: Appstyle.MainDate),
          SizedBox(height:8.0),
          Text(doc["note_content"], style: Appstyle.MainBody, overflow: TextOverflow.ellipsis,),
          
        ],
      ),
    ),


  );

} */