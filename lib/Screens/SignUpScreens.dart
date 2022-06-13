import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lock_up/Models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeScreens.dart';

class SignUpScreens extends StatefulWidget {
  const SignUpScreens({Key? key}) : super(key: key);
  @override
  State<SignUpScreens> createState() => _SignUpScreensState();
}

class _SignUpScreensState extends State<SignUpScreens> {

  String? name,email,phone,password,confirm_password;

  bool _passwordVisible = false;
  bool _c_passwordVisible = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  String? Language = "hello";

  String errorMessageName = "Name Required";
  String errorMessageEmail = "Email Required";
  String errorMessagePassword = "Password Required";
  String errorMessagePasswordLimit = "Password should be greater than 6 characters";
  String errorMessageConfirmPassword = "Confirm Password Required";
  String errorMessageConfirmPasswordMatch = "Confirm Password does not match";
  String errorMessagePhoneNumber = "Phone Required";

  String emailHintMessageEng = "Email";
  String nameHintMessageEng = "Name";
  String passwordHintMessageEng = "Password";
  String cpasswordHintMessageEng = "Confirm Password";
  String phoneHintMessageEng = "Phone Number";
  String register="Register";
  String already="Already have an account?";
  String loginNow="Login now!";

  final formKey = new GlobalKey<FormState>();
  bool showLoading=false;


  @override
  void initState() {
    getSharedPrefs();
  }
  void getSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    Language = prefs.getString('Language');
    // Fluttertoast.showToast(msg: Language!);
    if (Language == "English") {
      setState(() async {
        errorMessageName = "Name Required";
        errorMessageEmail = "Email Required";
        errorMessagePassword = "Password Required";
        errorMessageConfirmPassword = "Confirm Password Required";
        errorMessagePhoneNumber = "Phone Required";

        emailHintMessageEng = "Email";
        nameHintMessageEng = "Name";
        passwordHintMessageEng = "Password";
        cpasswordHintMessageEng = "Confirm Password";
        phoneHintMessageEng = "Phone Number";
        register="Register";
        already="Already have an account?";
        loginNow="Login now!";
      });
    } else {
      setState(() {
        errorMessageName = "שם (חובה";
        errorMessageEmail = "מייל (דרוש";
        errorMessagePassword = "סיסמה נדרשת";
        errorMessageConfirmPassword = "אשר סיסמה נדרשת";
        errorMessagePhoneNumber = "נדרש טלפון";

        emailHintMessageEng = "אימייל";
        nameHintMessageEng = "שֵׁם";
        passwordHintMessageEng = "סיסמה";
        cpasswordHintMessageEng = "אשר סיסמה";
        phoneHintMessageEng = "מספר טלפון";
        register="הירשם";
        already="כבר יש לך חשבון?";
        loginNow="התחבר עכשיו!";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        "WELCOME TO LOCK UP",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/lock.png',
                        width: 200,
                        height: 200,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),


                    //Name Field
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(

                        validator: (nameController)
                        {
                          if(nameController!.isEmpty||nameController==null)
                          {
                            return errorMessageName;
                          }
                          else
                          {
                            name = nameController;
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: nameHintMessageEng,
                          label: Text(nameHintMessageEng),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.name,
                      ),
                    ),

                    //Email Field
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        validator: (emailController)
                        {
                          if(emailController!.isEmpty||emailController==null)
                          {
                            return errorMessageEmail;
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
                            return errorMessagePassword;
                          }else if(passwordController.length<6){
                            return errorMessagePasswordLimit;
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
                      child: TextFormField(

                        validator: (confirmpasswordController)
                        {
                          if(confirmpasswordController!.isEmpty||confirmpasswordController==null)
                          {
                            return errorMessageConfirmPassword;
                          }else if(confirmpasswordController!=password){
                            return errorMessageConfirmPasswordMatch;

                          }
                          else
                          {
                            confirm_password = confirmpasswordController;
                            return null;
                          }
                        },

                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          label: Text("Confirm Password"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _c_passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _c_passwordVisible = !_c_passwordVisible;
                              });
                            },
                          ),

                        ),
                        keyboardType: TextInputType.text,
                        obscureText: _c_passwordVisible,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(

                        validator: (phoneController)
                        {
                          if(phoneController!.isEmpty||phoneController==null)
                          {
                            return errorMessagePhoneNumber;
                          }
                          else
                          {
                            phone = phoneController;
                            return null;
                          }
                        },

                        decoration: InputDecoration(
                          hintText: phoneHintMessageEng,
                          label: Text(phoneHintMessageEng),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                maximumSize: const Size(170.0, 90.0),
                                minimumSize: const Size(170.0, 60.0),
                                primary: Color(0xFF002d56),
                                shape: const StadiumBorder(),
                              ),
                              onPressed: () {
                                if (formKey.currentState != null &&
                                    formKey.currentState!.validate()) {
                                  SignUpFunction();
                                } else
                                  return;
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(register),
                                  Icon(
                                    Icons.content_paste_rounded,
                                    color: Colors.white,
                                  ),
                                ],
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
      ),
        Visibility(
          visible: showLoading,
          child: SpinKitWave(
            color: Colors.blueAccent,
          ),
        )
      ],
    );
  }
  Future SignUpFunction()async{
    await Firebase.initializeApp();
    final databaseReference =await FirebaseDatabase.instance.reference().child("Users");

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword
        (email: email!, password: password!);

      setState(() {showLoading=false;});
      UserModel users = UserModel(name: name!,id: userCredential.user!.uid, email: email!, phone: phone!);

      await databaseReference.child(userCredential.user!.uid).set(users.toMap());

      Navigator.pushAndRemoveUntil<void>(context,
        MaterialPageRoute<void>(builder: (BuildContext context) => HomeScreens(users.name,userCredential.user!.uid)),
        ModalRoute.withName('/'),
      );
    } on FirebaseAuthException catch(error)
    {
      setState(() {showLoading=false;});
      Fluttertoast.showToast(msg: error.message.toString());
      print(error);
    }
  }
}