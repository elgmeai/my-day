
import 'package:firebase_auth/firebase_auth.dart';



import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_day/component/botton.dart';
import 'package:my_day/component/textfield.dart';
import 'package:my_day/view/homescreen.dart';
import 'package:my_day/view/register.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
// Future<UserCredential> signInWithFacebook() async {
//   // Trigger the sign-in flow
//   final LoginResult loginResult = await FacebookAuth.instance.login();

//   // Create a credential from the access token
//   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
  

//   // Once signed in, return the UserCredential
//   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//}
bool loadihg =false;
 
Future<UserCredential> signInWithGoogle() async {

  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
   


  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> sinin() async {
   try {
    loadihg =true;
    setState(() {
      
    });
         await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: name.text, password: password.text);
          
          loadihg =false;
          setState(() {
            
          });
      if (FirebaseAuth.instance.currentUser != null 
      &&
          FirebaseAuth.instance.currentUser!.emailVerified
          ) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage(title: 'my day',),));
        
      } else {FirebaseAuth.instance.currentUser!.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('we send message to verefy your email')));
            
      }
    } on FirebaseAuthException catch (e) {
      loadihg=false;
      setState(() {
        
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The password or an email is not correct')));
          print(e);
      if (e.code == 'invalid-credential') {}
    }
  }

  @override
  Widget build(BuildContext context) {
    // GlobalKey formkey = GlobalKey();
    MediaQueryData mediaquerydata = MediaQuery.of(context);
    var height = mediaquerydata.size.height;
    var width = mediaquerydata.size.width;
    return Scaffold(
      body: ListView(
        children: [
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height / 12,
                ),
                Icon(
                  Icons.account_box_rounded,
                  size: width / 2.5,
                ),
                SizedBox(
                  height: height / 10,
                ),
                MyWidget(
                  control: name,
                  hint: 'Enter your name',
                  $val: (vaue) {
                    return null;
                  },
                ),
                SizedBox(
                  height: height / 20,
                ),
                MyWidget(
                  control: password,
                  hint: 'Enter your password',
                  $val: (value) {
                    return null;
                  },
                ),
                TextButton(
                    onPressed: ()async {
       if (name.text!='') {
                        await FirebaseAuth.instance
    .sendPasswordResetEmail(email: name.text);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('we send message to reset password your email')));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('you must insert yor email frist')));
              }
       },
                        
                    child: const Text('do you forgit tha password')),
                SizedBox(
                  height: height / 40,
                ),
                Bottonn(
                  $colorbotton: Colors.brown,
                  onPressedd: () => sinin(),
                  $chiledbotton:loadihg==false? const Text('Sign in'):const Text('loading.....'),
                  $border: BorderRadius.all(Radius.circular(width / 14)),
                ),
                SizedBox(
                  height: height / 40,
                ),
                Bottonn(
                  $colorbotton: Colors.red,
                  onPressedd: () 
                    async{try{
                    await signInWithGoogle();
                    
                    if (context.mounted) {
                      Navigator.of(context).pushNamed('homepage');
                    }
                  } catch(e){print(e);}

                  },
                  $chiledbotton: const Text('Sign up with google'),
                  $border: BorderRadius.all(Radius.circular(width / 14)),
                ),
                SizedBox(
                  height: height / 40,
                ),
                Bottonn(
                  $colorbotton: Colors.amber,
                  onPressedd: () => null,
                  $chiledbotton: const Text('Sign up with phone number'),
                  $border: BorderRadius.all(Radius.circular(width / 14)),
                ),
                SizedBox(
                  height: height / 40,
                ),
                Bottonn(
                  $colorbotton: Colors.blue,
                  onPressedd: () {}
                  // async{try{
                  //   final UserCredential userCredential=await signInWithFacebook();
                  //   if (context.mounted) {
                  //     Navigator.of(context).pushNamed('homepage');
                  //   }
                  // } catch(e){print(e);}

                ,
                  
                  $chiledbotton: const Text('Sign up with FaceBook'),
                  $border: BorderRadius.all(Radius.circular(width / 14)),
                  
                 ),
                SizedBox(
                  height: height / 40,
                ),
                TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Regester(),)),
                    child: const Text('dont have an email!'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
