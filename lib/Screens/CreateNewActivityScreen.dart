import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  String? Language = "hello";

  String CreateNewActivityText = "Create New Activity";
  String ActivityNameText = "Activity Name";
  String ActivityPasswordText = "Password";
  String ActivityConfirmPasswordText = "Confirm Password";
  String CancelText = "Cancel";
  String CreateActivity = "Create Activity";

  String errorMessageActivityName = "Activity Name Required";
  String errorMessageActivityPassword = "Password Required";
  String errorMessageActivityPasswordMatch = "Password Should be greater than 6 characters";
  String errorMessageActivityConfirmPassword= "Confirm Password Required";
  String errorMessageActivityConfirmPasswordMatch= "Confirm Password does not match";


  void getSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    Language = prefs.getString('Language');
    // Fluttertoast.showToast(msg: Language!);

    if (Language == "English") {
      setState(() async {
        CreateNewActivityText = "Create New Activity";
        ActivityNameText = "Activity Name";
        ActivityPasswordText = "Password";
        ActivityConfirmPasswordText = "Confirm Password";
        CancelText = "Cancel";
        CreateActivity = "Create Activity";

        errorMessageActivityName = "Activity Name Required";
        errorMessageActivityPassword = "Password Required";
        errorMessageActivityPasswordMatch = "Password Should be greater than 6 characters";
        errorMessageActivityConfirmPassword= "Confirm Password Required";
        errorMessageActivityConfirmPasswordMatch= "Confirm Password does not match"; });
    } else {
      setState(() {
        CreateNewActivityText = "?????? ???????????? ????????";
        ActivityNameText = "???? ??????????????";
        ActivityPasswordText = "??????????";
        ActivityConfirmPasswordText = "?????? ??????????";
        CancelText = "??????????????";
        CreateActivity = "?????? ????????????";

        errorMessageActivityName = "???????? ???? ????????????";
        errorMessageActivityPassword = "?????????? ??????????";
        errorMessageActivityPasswordMatch = "???????????? ?????????? ?????????? ???????? ??-6 ??????????";
        errorMessageActivityConfirmPassword= "?????? ?????????? ??????????";
        errorMessageActivityConfirmPasswordMatch= "?????? ?????????????? ???????? ??????????";

      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(CreateNewActivityText),
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
                        return errorMessageActivityName;
                      }
                      else
                      {
                        name = ActivityNameController;
                        return null;
                      }
                    },

                    decoration: InputDecoration(
                      hintText: ActivityNameText,
                      label: Text(ActivityNameText),
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
                        return ActivityPasswordText;
                      }else if(passwordController.length<6){
                        return errorMessageActivityPasswordMatch ;
                      }
                      else
                      {
                        password = passwordController;
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: ActivityPasswordText,
                      label: Text(ActivityPasswordText),
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
                        return errorMessageActivityConfirmPassword;
                      }else if(ConfirmPasswordController!=password){
                        return errorMessageActivityConfirmPasswordMatch;

                      }
                      else
                      {
                        confirm_password = ConfirmPasswordController;
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: ActivityConfirmPasswordText,
                      label: Text(ActivityConfirmPasswordText),
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


                        }, child: Text(CreateActivity)),
                      ),

                      Expanded(
                        child: FlatButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text(CancelText)),
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