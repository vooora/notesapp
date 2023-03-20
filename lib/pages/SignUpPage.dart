import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_application_1/pages/SignInPage.dart';
import 'package:flutter_application_1/pages/homePage.dart';
import 'package:flutter_application_1/services/Auth_Service.dart';
import 'package:flutter_svg/flutter_svg.dart';



class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController(); 
  bool circular = false;
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container( 
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black, 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up", 
                style: TextStyle(
                  fontSize: 35, 
                  color:Colors.white,
                  fontWeight: FontWeight.bold)
              ),
              SizedBox( 
                height: 20,
              ),
              // buttonItem("assets/googleimage.png", "  Continue with Google", 25 ),
               //() async {
               // await authClass.googleSignIn(context); } //plus inside buttonItem
              // SizedBox(
              //   height: 15,
              // ),
              // buttonItem("assets/phoneimage.png", "  Continue with phone number", 25,), //() {}
              // SizedBox(
              //   height: 15
              // ),
              // Text( 
              //   "Or",
              //   style: TextStyle(color: Colors.white, fontSize: 15),
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              textItem("Email...", _emailController, false),
              SizedBox(
                height: 15,
              ),
              textItem("Password...", _pwdController, true),
              SizedBox(
                height: 30,
              ),
              ColorButton(),
               SizedBox(
                height: 20,
              ),
              Row( 
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => SignInPage(),), (route) => false);
                  },
                  child: Text(
                    "Already have an account?  Login.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                ]
              ),
            ],
          ),         
        ),
      ),

      
    );
  }

  Widget ColorButton()
  {
    return InkWell(
      onTap: () async {
        setState(() {
          circular = true;
        });
        try{
        firebase_auth.UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _pwdController.text
          );
          print(userCredential.user?.email);
          setState(() {
            circular = false;
          });
          Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(builder: (builder) => HomePage()), 
            (route) => false);           
        }
        catch(e)
        {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container( 
        width: MediaQuery.of(context).size.width-100,
        height: 60,
        decoration: BoxDecoration( 
          borderRadius: BorderRadius.circular(20 ),
          gradient: LinearGradient(colors: [Color(0xfffd746c), Color(0xffff9068), Color(0xfffd746c)])
        ),
        child: Center(
          child: circular
          ? CircularProgressIndicator() 
          : Text( 
            "Sign Up",
            style: TextStyle( 
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }



  Widget buttonItem(String imagepath, String buttonname, double size) {
    return InkWell (
      //onTap: () => onTap(), above add Function onTap
              child: 
              Container(
                  width: MediaQuery.of(context).size.width-60,
                  height: 60,
                  child: Card( 
                    color: Colors.black,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        width: 1,
                        color: Colors.grey, 
                      ),
                      ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ 
                        Image(
                          image: AssetImage(imagepath),
                          height: size,
                          width: size,
                        ),  
                        Text(
                          buttonname, 
                          style: TextStyle(
                            color:Colors.white, 
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(width: 15,)    
                      ],  
                    ),
                  ),
                ),
    );
  }

  
  Widget textItem(String label_text, TextEditingController controller, bool obscureText ) {
    return Container(
      width: MediaQuery.of(context).size.width-60,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText:  obscureText,
        style: TextStyle(fontSize: 17, color: Colors.white),
        decoration: InputDecoration(
          labelText: label_text, 
          labelStyle: TextStyle(fontSize: 17, color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.amber,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey, 
          ),
        ), 
      ),
    ) );
  }
}



