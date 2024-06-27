import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_day/component/botton.dart';
import 'package:my_day/component/textfield.dart';

class Regester extends StatefulWidget {
  const Regester({super.key});

  @override
  State<Regester> createState() => _RegesterState();
}

class _RegesterState extends State<Regester> {
  TextEditingController namereg = TextEditingController();
  TextEditingController passwordreg = TextEditingController();
  TextEditingController emailreg = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  bool isValidEmail(email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  String? validatePassword(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }









  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaquerydata = MediaQuery.of(context);
    var height = mediaquerydata.size.height;
    // var width =mediaquerydata.size.width;
    return Scaffold(floatingActionButton:MaterialButton(child: Icon(Icons.chevron_left_rounded,size: 50,color: Colors.red,),
      onPressed: () =>  Navigator.pop(context),) ,
      body: Container(
        color: const Color.fromARGB(255, 255, 247, 224),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height / 15,
                ),
                Text(
                  'Register',
                  style: GoogleFonts.robotoSlab(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: height / 10,
                ),
                MyWidget(
                  control: namereg,
                  hint: 'Enter your name',
                  $val: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height / 20,
                ),
                MyWidget(
                  control: emailreg,
                  hint: 'Enter your Gmail',
                  $val: (value) =>
                      isValidEmail(value) ? null : "Check your email",
                ),
                SizedBox(
                  height: height / 20,
                ),
                MyWidget(
                  control: passwordreg,
                  hint: 'Enter your password',
                  $val: (value) {
                    return validatePassword(value!);
                  },
                ),
                SizedBox(
                  height: height / 20,
                ),
                Bottonn(
                  $colorbotton: Colors.black,
                  onPressedd: onPressedd,
                  $chiledbotton: const Text(
                    'creat',
                    style: TextStyle(color: Colors.white),
                  ),
                  $border: null,
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> onPressedd() async {
    if (_formKey.currentState!.validate()) {
      try {
        
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailreg.text,
          password: passwordreg.text,
        );
      if (FirebaseAuth.instance.currentUser != null) {
         FirebaseAuth.instance.currentUser!.sendEmailVerification();
      }
          FirebaseAuth.instance.currentUser!.sendEmailVerification();
        
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('we send message to verefy your email and retern to login page')));
        }
        
    


        
       on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('The password provided is too weak.')));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('The account already exists for that email.')));
        }
      } 
    }
  }
}
