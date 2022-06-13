import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetScreens extends StatefulWidget {
  const ForgetScreens({Key? key}) : super(key: key);

  @override
  State<ForgetScreens> createState() => _ForgetScreensState();
}


class _ForgetScreensState extends State<ForgetScreens> {

  final formkey = GlobalKey<FormState>();
  String? email;

  TextEditingController ForgetEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Align(
              alignment: Alignment.centerLeft,
              child: Text("Forget Password")),
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 300,
                  child: Image.asset('assets/images/image2.png',width: double.infinity,height: 200,),
                ),
                Form(
                  key: formkey,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10,10,10,10),
                    child: TextFormField(
                      validator:  (ForgetEmailController)
                      {
                        if(ForgetEmailController!.isEmpty||ForgetEmailController==null)
                          {
                            return "Email Required";
                          }
                        else{
                          email = ForgetEmailController;
                          return null;
                        }

                      },
                      decoration: InputDecoration(
                        hintText: "Email Address",
                        label: Text("Email Address"),
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),

                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 15, 0, 0),
                    child: Row(
                      children: [
                        RaisedButton(
                            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                            color: Color(0xFF002d56),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                            onPressed: () {
                              if (formkey.currentState != null &&
                                  formkey.currentState!.validate()) {
                                //SignInFunc(Email, Password);
                                resetPassword();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Icon(
                                    Icons.email_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future resetPassword()async{
    await Firebase.initializeApp();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);

      Fluttertoast.showToast(msg: "An email has been sent. Check inbox");

    }on FirebaseAuthException catch (e){
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }

}