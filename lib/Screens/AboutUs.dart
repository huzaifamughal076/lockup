import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {


  String? Language = "hello";

  String AboutUs = "About Us";
  String TeamMembers = "Team Members";
  String RelatedToApp = "Some info related to this App";

  void getSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    Language = prefs.getString('Language');

    if (Language == "English") {
      setState(() async {

        AboutUs = "About Us";
        TeamMembers = "Team Members";
        RelatedToApp = "Some info related to this App";


      });
    } else {
      setState(() {
        AboutUs = "עלינו ";
        TeamMembers = "חברי צוות";
        RelatedToApp = "קצת מידע הקשור לאפליקציה הזו";
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
          title: Text(AboutUs,style: TextStyle(fontWeight: FontWeight.bold),),
        ),

        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                width: double.infinity,
                child: Center(child: Text(AboutUs,style: TextStyle(fontWeight: FontWeight.bold),)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(RelatedToApp)),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/aboutUsbg.png"),
                            fit: BoxFit.fill
                        )
                    ),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top:80),
                            child: Text(
                              "Team Members",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white),
                            )),

                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius:30,
                                      backgroundImage: AssetImage(
                                          'assets/images/sampleImage1.jpg'),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Owner",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius:30,
                                      backgroundImage: AssetImage(
                                          'assets/images/sampleImage2.jpg'),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Invester",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius:30,
                                      backgroundImage: AssetImage(
                                          'assets/images/sampleImage3.jpg'),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "(CEO)",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),

                              ),


                            ],
                          ),
                        )



                      ],
                    ),


                  ),
                ),
              ),

            ],
          ),


        ),
      ),

    );
  }
}