import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lock_up/Screens/AboutUs.dart';
import 'package:lock_up/Screens/ContactUs.dart';
import 'package:lock_up/Screens/LoginScreens.dart';
import 'package:lock_up/Screens/TermsOfUse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'JoinedActivitiesScreen.dart';
import 'MyActivitiesScreen.dart';
import 'ScanScreen.dart';
import 'SettingsScreen.dart';

class HomeScreens extends StatefulWidget {
  String ?UserName,uid;
  HomeScreens(this.UserName,this.uid,{Key? key}) : super(key: key);

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {

  bool _passwordVisible = false;

  String? activity_ID,activity_Password;
  var activityList = [];

  TextEditingController ActivityIdController = TextEditingController();
  TextEditingController ActivityPasswordController = TextEditingController();

  DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Activities");

  final formKey = new GlobalKey<FormState>();
  String? Language = "hello";

  String WelcomeMessageText = "Welcome";
  String RecentActivitiesText = "Recent Activities";
  String JoinAnActivityText = "Join An Activity";

  String MyActivitiesText = "My Activities";
  String JoinedActivitiesText = "Joined Activities";
  String SettingsText = "Settings";
  String AboutUsText = "About Us";
  String TermsOfUseText = "Terms of Use";
  String ContactUsText = "Contact Us";
  String LogOutText = "Log Out";

  String ActivityIDText = "Activity ID";
  String ActivityPasswordText = "Password";
  String JoinText = "Join";
  String CancelText = "Cancel";


  String errorMessageActivityID = "Activity ID Required";
  String errorMessageActivityPassword = "Password Required";
  String errorMessageActivityPasswordMatch = "Password Should be greater than 6 characters";

  String AreYouSure = "Are you Sure";
  String YouWantToDelete = "You want to Delete";

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
         WelcomeMessageText = "Welcome";
         RecentActivitiesText = "Recent Activities";
         JoinAnActivityText = "Join An Activity";

        JoinedActivitiesText = "Joined Activities";
        MyActivitiesText = "My Activities";
        SettingsText = "Settings";
        AboutUsText = "About Us";
        TermsOfUseText = "Terms of Use";
        ContactUsText = "Contact Us";
        LogOutText = "Log Out";

        ActivityIDText = "Activity ID";
        ActivityPasswordText = "Password";
        JoinText = "Join";
        CancelText = "Cancel";


        errorMessageActivityID = "Activity ID Required";
        errorMessageActivityPassword = "Password Required";
        errorMessageActivityPasswordMatch = "Password Should be greater than 6 characters";

        AreYouSure = "Are you Sure";
        YouWantToDelete = "You want to Delete";

      });
    } else {
      setState(() {
         WelcomeMessageText = "ברוך הבא";
         RecentActivitiesText = "פעילויות אחרונות";
         JoinAnActivityText = "הצטרף לפעילות";

         MyActivitiesText = "הפעילויות שלי";
         JoinedActivitiesText = "הצטרפו לפעילויות";
         SettingsText = "הגדרות";
         AboutUsText = "עלינו";
         TermsOfUseText = "תנאי שימוש";
         ContactUsText = "צור קשר";
         LogOutText = "להתנתק";

         ActivityIDText = "מזהה פעילות";
         ActivityPasswordText = "סיסמה";
         JoinText = "לְהִצְטַרֵף";
         CancelText = "לְבַטֵל";

         errorMessageActivityID = "נדרש מזהה פעילות";
         errorMessageActivityPassword = "סיסמה נדרשת";
         errorMessageActivityPasswordMatch = "הסיסמה צריכה להיות יותר מ-6 תווים";

         AreYouSure = "האם אתה בטוח";
         YouWantToDelete = "אתה רוצה למחוק";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Text(widget.UserName! +" "+WelcomeMessageText)),
      ),
      body:
      SafeArea(
        top: true,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: CarouselSlider(
                options: CarouselOptions(height: 150.0),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.amber),
                          child: Text(
                            'text $i',
                            style: TextStyle(fontSize: 16.0),
                          ));
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    RecentActivitiesText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  )),
            ),
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Form(
                          key: formKey,
                          child: Container(
                            height: 250,
                            width: 500,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: TextFormField(
                                    validator: (ActivityIdController)
                                    {
                                      if(ActivityIdController!.isEmpty||ActivityIdController==null) {
                                        return errorMessageActivityID;
                                      }else
                                      {
                                        activity_ID=ActivityIdController;
                                        return null;
                                      }
                                    },

                                    decoration: InputDecoration(
                                      hintText: ActivityIDText,
                                      label: Text(ActivityIDText),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: TextFormField(
                                    validator: (ActivityPasswordController)
                                    {
                                      if(ActivityPasswordController!.isEmpty||
                                          ActivityPasswordController==null) {
                                        return errorMessageActivityPassword;
                                      }else if(ActivityPasswordController.length<6){
                                        return errorMessageActivityPasswordMatch;
                                      } else
                                      {
                                        activity_Password=ActivityPasswordController;
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
                                  padding: EdgeInsets.only(left: 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    textDirection: TextDirection.ltr,
                                    children: [
                                      ElevatedButton(onPressed: ()async{

                                        if(formKey.currentState!=null && formKey.currentState!.validate())
                                        {
                                          activityList.clear;
                                          await databaseReference.once().then((value){

                                            if(value.snapshot.child(activity_ID!).exists) {
                                              String pass = value.snapshot.child(activity_ID!).child("password")
                                                  .value
                                                  .toString();
                                              print(widget.uid);
                                              print(value.snapshot.child("manager")
                                                  .value
                                                  .toString());
                                              if (widget.uid == value.snapshot.child(activity_ID!).child("manager").value.toString()!) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                    "You are the manager of this activity. Can't join as user");
                                                return;
                                              } else if (activity_Password == pass) {
                                                joinActivity(activity_ID.toString());
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          JoinedActivitiesScreen(widget.uid!,widget.UserName!,JoinedActivitiesText)),
                                                );
                                                Fluttertoast.showToast(msg: "You Added");

                                              }else {
                                                Fluttertoast.showToast(
                                                    msg: "Wrong Password");
                                                return;
                                              }
                                            }else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                  "No such activity found.");
                                              return;
                                            }
                                          });
                                        }
                                        else{
                                          return;
                                        }


                                      }, child: Text(JoinText)),

                                      FlatButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: Text(CancelText)),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            icon: Icon(Icons.qr_code_scanner), onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ScanScreen(widget.uid!)),
                                            );
                                          },
                                          ),
                                        ),
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
                  },
                );
              },
            );
          },
          label: Text(JoinAnActivityText)
      ),
      //BUTTON LOCATION
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

      endDrawer: SafeArea(
        top: true,
        child: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
            ListTile(
              title: Text(
                MyActivitiesText,
                textAlign: TextAlign.end,
              ),
              trailing: Icon(Icons.add_business_outlined),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyActivitiesScreen(widget.uid!,widget.UserName!)));
              },
            ),
            ListTile(
              title: Text(
                JoinedActivitiesText,
                textAlign: TextAlign.end,
              ),
              trailing: Icon(Icons.add_box_outlined),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => JoinedActivitiesScreen(widget.uid!,widget.UserName!,JoinedActivitiesText)));
              },
            ),
            ListTile(
              title: Text(
                SettingsText,
                textAlign: TextAlign.end,
              ),
              trailing: Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
            ),
            ListTile(
              title: Text(
                AboutUsText,
                textAlign: TextAlign.end,
              ),
              trailing: Icon(Icons.account_circle_outlined),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
            ListTile(
              title: Text(
                TermsOfUseText,
                textAlign: TextAlign.end,
              ),
              trailing: Icon(Icons.add_moderator),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TermsOfUse()));
              },
            ),
            ListTile(
              title: Text(
                  ContactUsText,
                textAlign: TextAlign.end,
              ),
              trailing: Icon(Icons.contact_mail),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs()));
              },
            ),
            ListTile(
              title: Text(LogOutText,
                textAlign: TextAlign.end,),
              trailing: Icon(Icons.exit_to_app_outlined),
              onTap: (){
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => new CupertinoAlertDialog(
                    title: Text(AreYouSure,style: TextStyle(fontSize: 19,color: Colors.black)),

                    content: Text(YouWantToDelete),
                    actions: [
                      CupertinoDialogAction(isDefaultAction: true,
                          onPressed: ()
                          {Navigator.pop(context);}, child: new Text(CancelText)),


                      CupertinoDialogAction(isDefaultAction: true,
                          onPressed: ()
                          {
                            Navigator.pop(context);
                            Navigator.pushAndRemoveUntil<dynamic>(context,
                              MaterialPageRoute<dynamic>(builder: (BuildContext context) => LoginScreens()
                              ),(route)=>false,
                            );
                          }, child: new Text(LogOutText))
                    ],
                  ),
                );
              },

            )
          ]),
        ),
      ),
    );
  }

  joinActivity(String id) async {
    String currentTime = DateTime.now().toString();

    await databaseReference
        .child(id)
        .child("Members")
        .child(widget.uid!)
        .child("Last Opened")
        .set(currentTime);
    Fluttertoast.showToast(msg: "Joined successfully");
  }

}