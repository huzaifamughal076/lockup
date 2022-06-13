import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lock_up/Screens/HomeScreens.dart';
import 'package:lock_up/Screens/OnboardingScreen.dart';
import 'package:lock_up/Screens/SignUpScreens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  bool isSwitch=false;
  final formKey = new GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String emailHintMessageEng="Email";
  String passwordHintMessageEng="Password";
  String forgotPasswordMessageEng="Forgot Password?";
  String LoginText="Login";
  String SwitchLanguage="Switch Language";
  String Or="Or";
  String ContinueWith="Continue with";
  String newHere="New Here?";
  String becomeMember="Become a member now!";
  String emailErrorMessage="Email Required";
  String passwordErrorMessage="Password Required";
  String Language="English";

  @override
  void initState() {

    getSharedPrefs();

  }
  getSharedPrefs()async{
    final prefs = await SharedPreferences.getInstance();
    final int? counter = prefs.getInt('counter');

    if(counter!=1){
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const OnboardingScreen()),
      );
    }
  }

  bool showLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Directionality(
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
                            return emailErrorMessage;
                          }
                          else
                          {
                            email = emailController;
                            return null;
                          }
                        },

                        decoration: InputDecoration(
                          hintText: emailHintMessageEng,
                          label: Text(emailHintMessageEng),
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
                            return passwordErrorMessage;
                          }
                          else
                          {
                            password = passwordController;
                            return null;
                          }
                        },

                        decoration: InputDecoration(
                          hintText: passwordHintMessageEng,
                          label: Text(passwordHintMessageEng),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
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
                            forgotPasswordMessageEng,
                            style: TextStyle(
                                fontSize: 15, wordSpacing: 1, color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          children: [
                            RaisedButton(
                                padding:
                                const EdgeInsets.fromLTRB(30, 20, 30, 20),
                                color: Color(0xFF002d56),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                                onPressed: () {
                                  if (formKey.currentState != null &&
                                      formKey.currentState!.validate()) {
                                    SignIn();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      LoginText,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(SwitchLanguage),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                              width: 20,
                              height: 20,
                              child: Image.asset("assets/images/uk.png"),
                            )),
                        Expanded(child: Container(
                          child:Switch(
                            value: isSwitch,
                            onChanged: (val)async{
                              setState(() {
                                isSwitch=val;
                              });
                              if(val==true){

                                setState(() {
                                  emailHintMessageEng="אימייל";
                                  passwordHintMessageEng="סיסמה";
                                  forgotPasswordMessageEng="שכחת את הסיסמ?";
                                  LoginText="התחברות";
                                  SwitchLanguage="החלף שפה";
                                  Or="אוֹ";
                                  ContinueWith="להמשיך עם";
                                  newHere="חדש פה?";
                                  becomeMember="הפוך לחבר עכשיו!";
                                  emailErrorMessage="מייל(דרוש";
                                  passwordErrorMessage="סיסמה נדרשת";
                                });
                                final prefs = await SharedPreferences.getInstance();
                                await prefs.setString('Language', 'Israel');
                              }else{
                                final prefs = await SharedPreferences.getInstance();
                                await prefs.setString('Language', 'English');
                                setState(() {
                                  emailHintMessageEng="Email";
                                  passwordHintMessageEng="Password";
                                  forgotPasswordMessageEng="Forgot Password?";
                                  LoginText="LOG IN";
                                  SwitchLanguage="Switch Language";
                                  Or="Or";
                                  ContinueWith="Continue with";
                                  newHere="New Here?";
                                  becomeMember="Become a member now!";
                                  emailErrorMessage="Email Required";
                                  passwordErrorMessage="Password Required";
                                });

                              }
                            },
                          )
                          ,
                        )),
                        Expanded(
                            child: Container(
                              width: 20,
                              height: 20,
                              child: Image.asset("assets/images/israel.png"),
                            )),
                      ],
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
                          "Continue with",
                          style: TextStyle(fontSize: 15, wordSpacing: 1),
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
                                // margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: Image.asset(
                                  'assets/images/googleicon.png',
                                  width: 35,
                                  height: 35,
                                ),
                              ),
                              onTap: (){
                                setState(() {showLoading=true;});
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
          Visibility(
            visible: showLoading,
            child: SpinKitWave(
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
    );
  }

  Future SignIn()async{
    await Firebase.initializeApp();
    try {
      FirebaseAuth _auth = await FirebaseAuth.instance;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);

      setState(() {showLoading=false;});

      final  databaseReference =FirebaseDatabase.instance.reference().child("Users");
      await databaseReference.once().then((value) {
        // Fluttertoast.showToast(msg: value.snapshot.child(userCredential.user!.uid).key.toString());
        if (value.snapshot.hasChild(userCredential.user!.uid)) {
          String name =
          value.snapshot.child(userCredential.user!.uid).child("name").value.toString();

          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => HomeScreens(name,userCredential.user!.uid),
            ),
                (route) => false,
          );
        }
      });


    }on FirebaseAuthException catch(error)
    {
      Fluttertoast.showToast(msg: error.message.toString());
      setState(() {
        showLoading=false;
      });
    }

  }

  Future SignInWithGoogle() async{

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

      UserModel users = UserModel(name: result.user!.displayName, email: result.user!.email, phone: result.user!.phoneNumber, id: user!.uid);

      await databaseReference.set(users.toMap());

      if(result!=null)
      {
        setState(() {showLoading=false;});
        Navigator.pushAndRemoveUntil<void>(context,
          MaterialPageRoute<void>(builder: (BuildContext context) => HomeScreens(result.user!.displayName,result.user!.uid)),
          ModalRoute.withName('/'),
        );
      }
      else{
        setState(() {showLoading=false;});
        return "Somthing is wrong";
      }



    }on FirebaseAuthException catch(error)
    {
      setState(() {showLoading=false;});
      Fluttertoast.showToast(msg: error.message.toString());
      print(error);
    }


  }
}