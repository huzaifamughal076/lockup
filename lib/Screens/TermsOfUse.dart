import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsOfUse extends StatefulWidget {
  const TermsOfUse({Key? key}) : super(key: key);

  @override
  State<TermsOfUse> createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> {



  String? Language = "hello";

  String TermsOfUse = "Terms Of Use";
  String TeamMembers = "Team Members";
  String paragraphText = "A paragraph (from Ancient Greek παράγραφος (parágraphos) 'to write beside') is a self-contained unit of discourse in writing dealing with a particular point or idea. A paragraph consists of one or more sentences.[1] Though not required by the syntax of any language, paragraphs are usually an expected part of formal writing, used to organize longer prose.";
  String RelatedToApp = "Some info related to this App";

  void getSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    Language = prefs.getString('Language');

    if (Language == "English") {
      setState(() async {

        TermsOfUse = "Terms Of Use";
        TeamMembers = "Team Members";
        RelatedToApp = "Some info related to this App";
        paragraphText = "A paragraph (from Ancient Greek παράγραφος (parágraphos) 'to write beside') is a self-contained unit of discourse in writing dealing with a particular point or idea. A paragraph consists of one or more sentences.[1] Though not required by the syntax of any language, paragraphs are usually an expected part of formal writing, used to organize longer prose.";


      });
    } else {
      setState(() {
        TermsOfUse = "תנאי שימוש";
        TeamMembers = "חברי צוות";
        RelatedToApp = "קצת מידע הקשור לאפליקציה הזו";
        paragraphText = "פסקה (מיוונית עתיקה παράγραφος (paragraphos) 'לכתוב ליד') היא יחידת שיח עצמאית בכתיבה העוסקת בנקודה או רעיון מסוים. פסקה מורכבת ממשפט אחד או יותר.[1] למרות שאינן נדרשות על ידי התחביר של שפה כלשהי, פסקאות הן בדרך כלל חלק צפוי בכתיבה פורמלית, המשמשת לארגון פרוזה ארוכה יותר.";
      });
    }
  }


  @override
  void initState() {
    getSharedPrefs();
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(TermsOfUse,style: TextStyle(fontWeight: FontWeight.bold),),
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  width: double.infinity,
                  child: Center(child: Text(TermsOfUse,style: TextStyle(fontWeight: FontWeight.bold),)),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(paragraphText),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}