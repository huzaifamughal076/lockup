import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("About Us",style: TextStyle(fontWeight: FontWeight.bold),),
        ),

        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                width: double.infinity,
                child: Center(child: Text("About Us",style: TextStyle(fontWeight: FontWeight.bold),)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Text("Some info related to this App")),
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