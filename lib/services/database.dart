// import 'package:cloud_firestore/cloud_firestore.dart';


// class DatabaseService {

//   final String uid;
//   DatabaseService({required this.uid})

//   final CollectionReference brewCollection = FirebaseFirestore.instance.collection('notesapp');
  
//   Future updateUserData(String content, String date, int color_id, String title) async {
//     return await brewCollection.document(uid).setData({
//       'color_id' : color_id,
//       'creation_date': date,
//       'note_content': content,
//       'note_title': title,
//     });

//   }

// }

