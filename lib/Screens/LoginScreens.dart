import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lock_up/Screens/HomeScreens.dart';
import 'package:lock_up/Screens/SignUpScreens.dart';
import '../Models/UserModel.dart';
import 'ForgetScreens.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({Key? key}) : super(key: key);

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {

  String? email,password;
  bool _passwordVisible = false;
  final formKey = new GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        // add this
        textDirection: TextDirection.rtl, // set this property
        child: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Text(
                      "WELCOME TO LOCK UP",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: Image.asset(
                      'assets/images/lock.png',
                      width: 200,
                      height: 100,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      validator: (emailController)
                      {
                        if(emailController!.isEmpty||emailController==null)
                        {
                          return "Email Required";
                        }
                        else
                        {
                          email = emailController;
                          return null;
                        }
                      },

                      decoration: InputDecoration(
                        hintText: "Email",
                        label: Text("Email"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),

                  //Password Field

                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      validator: (passwordController)
                      {
                        if(passwordController!.isEmpty||passwordController==null)
                        {
                          return "Password Required";
                        }
                        else
                        {
                          password = passwordController;
                          return null;
                        }
                      },

                      decoration: InputDecoration(
                        hintText: "Password",
                        label: Text("Password"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),

                      ),
                      keyboardType: TextInputType.text,
                      obscureText: _passwordVisible,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgetScreens()),
                          );
                        },
                        child: new Text(
                          "Forget Password",
                          style: TextStyle(
                              fontSize: 15, wordSpacing: 1, color: Colors.blue),
                        ),
                      ),
                    ),
                  ),

                  ElevatedButton.icon(
                    onPressed: () {

                      if(formKey.currentState!=null && formKey.currentState!.validate())
                      {
                        SignIn();

                        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreens()));
                      }
                      else{
                        return;
                      }

                    },
                    label: Text(
                      "Login",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    icon: Icon(
                      Icons.login_sharp,
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        "-------Or-------",
                        style: TextStyle(fontSize: 15, color: Colors.black26),
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        "Continue with:",
                        style: TextStyle(fontSize: 13, wordSpacing: 1),
                      )),

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Image.asset(
                            'assets/images/facebookicon.png',
                            width: 35,
                            height: 35,
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: GestureDetector(
                            child:Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Image.asset(
                                'assets/images/googleicon.png',
                                width: 35,
                                height: 35,
                              ),
                            ),
                            onTap: (){
                              SignInWithGoogle();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreens()),
                              );
                            },
                            child: new Text(
                              "Become our new Member",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  wordSpacing: 1),
                            ),
                          ),
                        ),
                        Container(
                            child: Text(
                              " ?New Here  ",
                              style: TextStyle(fontSize: 13, wordSpacing: 1),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future SignIn()async{
    try {
      FirebaseAuth _auth = await FirebaseAuth.instance;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);

      Navigator.pushAndRemoveUntil<void>(context,
        MaterialPageRoute<void>(builder: (BuildContext context) => HomeScreens(userCredential.user!.displayName,userCredential.user!.uid)),
        ModalRoute.withName('/'),
      );

    }on FirebaseAuthException catch(error)
    {

    }

  }

  Future SignInWithGoogle() async{

    // await Firebase.initializeApp();
    await Firebase.initializeApp();
    final FirebaseAuth _auth = await FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try{
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
      await googleSignInAccount?.authentication;
      AuthCredential authCredential = await GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken,
      );

      UserCredential result = await _auth.signInWithCredential(authCredential);
      User? user = result.user;

      final databaseReference = await FirebaseDatabase.instance.reference()
          .child("Users")
          .child(result.user!.uid);

      // print("User UID:   "+result.user!.uid);
      // print(result.user!.email.toString());
      // print(result.user!.displayName.toString());
      // print(result.user!.phoneNumber.toString());

      UserModel users = UserModel(name: result.user!.displayName, email: result.user!.email, phone: result.user!.phoneNumber);

      await databaseReference.set(users.toMap());

      if(result!=null)
      {
        Navigator.pushAndRemoveUntil<void>(context,
          MaterialPageRoute<void>(builder: (BuildContext context) => HomeScreens(result.user!.displayName,result.user!.uid)),
          ModalRoute.withName('/'),
        );
      }
      else{
        return "Somthing is wrong";
      }



    }catch(error)
    {

    }


  }
}