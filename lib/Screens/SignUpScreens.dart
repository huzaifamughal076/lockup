import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lock_up/Models/UserModel.dart';
import 'HomeScreens.dart';

class SignUpScreens extends StatefulWidget {
  const SignUpScreens({Key? key}) : super(key: key);
  @override
  State<SignUpScreens> createState() => _SignUpScreensState();
}

class _SignUpScreensState extends State<SignUpScreens> {

  String? name,email,phone,password,confirm_password;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();


  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
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
                          return "Name Required";
                        }
                        else
                        {
                          name = nameController;
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Name",
                        label: Text("Name"),
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

                  //Phone Field

                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(

                      validator: (phoneController)
                      {
                        if(phoneController!.isEmpty||phoneController==null)
                        {
                          return "Phone Required";
                        }
                        else
                        {
                          phone = phoneController;
                          return null;
                        }
                      },

                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        label: Text("Phone Number"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
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
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextFormField(

                      validator: (confirmpasswordController)
                      {
                        if(confirmpasswordController!.isEmpty||confirmpasswordController==null)
                        {
                          return "Confirm Password Required";
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
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                  ),

                  ElevatedButton.icon(
                    onPressed: () {

                      if(formKey.currentState!=null && formKey.currentState!.validate())
                      {
                        SignUpFunction();
                      }
                      else{
                        return;
                      }
                    },
                    label: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    icon: Icon(
                      Icons.login_sharp,
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
  Future SignUpFunction()async{
    await Firebase.initializeApp();

    final databaseReference =await FirebaseDatabase.instance.reference().child("Users");

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword
        (email: email!, password: password!);

      UserModel users = UserModel(name: "huzaifa", email: "huzaifa@gmail.com", phone: "0000000000");

      await databaseReference.child(userCredential.user!.uid).set(users.toMap());

      Navigator.pushAndRemoveUntil<void>(context,
        MaterialPageRoute<void>(builder: (BuildContext context) => HomeScreens(userCredential.user!.displayName,userCredential.user!.uid)),
        ModalRoute.withName('/'),
      );
    } on FirebaseAuthException catch(error)
    {

      print(error);
    }
  }
}