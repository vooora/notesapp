import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_application_1/pages/HomePage.dart';
import 'package:flutter_application_1/pages/SignUpPage.dart';
import 'package:flutter_application_1/pages/SignInPage.dart';
import 'package:flutter_application_1/services/Auth_Service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  Widget currentPage = SignUpPage();
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    if (token!=null){
      setState(() {
        currentPage = HomePage();
      });
    }
  }

  void signup() async
  {
    try{
      await firebaseAuth.createUserWithEmailAndPassword(email: 'akhilvoora9@gmail.com', password: '123456');    
    } catch(e) {
      print(e);
    }
  } 
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: currentPage, //used to say SignUpPage(),
    );
  }
} 





