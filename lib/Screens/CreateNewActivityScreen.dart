import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../Models/ActivityModel.dart';

class CreateNewActivityScreen extends StatefulWidget {
  String? uid;
  CreateNewActivityScreen(this.uid,{Key? key}) : super(key: key);

  @override
  State<CreateNewActivityScreen> createState() => _CreateNewActivityScreenState();
}

class _CreateNewActivityScreenState extends State<CreateNewActivityScreen> {

  bool _passwordVisible = true;
  bool _confirm_passwordVisible = true;

  String? name,password,confirm_password;

  TextEditingController ActivityNameController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  TextEditingController ConfirmPasswordController =TextEditingController();

  final databaseReference = FirebaseDatabase.instance.reference().child("Activities");


  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Align(
              alignment: Alignment.centerLeft,
              child: Text("Create New Activity",)),
        ),
        body: Form(
          key: formKey,
          child: Container(
            child: Column(
              children: [

                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    validator: (ActivityNameController)
                    {
                      if(ActivityNameController!.isEmpty||ActivityNameController==null)
                      {
                        return "Activity Name Required";
                      }
                      else
                      {
                        name = ActivityNameController;
                        return null;
                      }
                    },

                    decoration: InputDecoration(
                      hintText: "Activity Name",
                      label: Text("Activity Name"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.name,
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
                      }else if(passwordController.length<6){
                        return "Password should be greater than 6 characters";
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
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    validator: (ConfirmPasswordController)
                    {
                      if(ConfirmPasswordController!.isEmpty||ConfirmPasswordController==null)
                      {
                        return "Confirm Password Required";
                      }else if(ConfirmPasswordController!=password){
                        return "Confirm Password does not matched";

                      }
                      else
                      {
                        confirm_password = ConfirmPasswordController;
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "ConfirmPassword",
                      label: Text("Confirm Password"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _confirm_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _confirm_passwordVisible = !_confirm_passwordVisible;
                          });
                        },
                      ),

                    ),
                    keyboardType: TextInputType.text,
                    obscureText: _confirm_passwordVisible,
                  ),
                ),

                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(onPressed: (){

                          if(formKey.currentState!=null && formKey.currentState!.validate())
                          {
                            int RandomID=RandomNumber();
                            databaseReference.once().then((value){
                              if(!value.snapshot.child(RandomID.toString()).exists)
                              {
                                ActivityModel activity_model = ActivityModel(id: RandomID.toString(), name: name!,manager:widget.uid, password: password!);
                                databaseReference.child(RandomID.toString()).set(activity_model.toMap());
                                Navigator.pop(context);
                              }
                            });

                            print("Random Number: "+ RandomID.toString());
                          }
                          else{
                            return;
                          }


                        }, child: Text("Create Activity")),
                      ),

                      Expanded(
                        child: FlatButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Cancel")),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int RandomNumber(){
    var rng = new Random();
    var code = rng.nextInt(90000) + 10000;
    return code;
  }
}