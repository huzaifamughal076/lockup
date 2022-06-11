import 'package:flutter/material.dart';

class ForgetScreens extends StatefulWidget {
  const ForgetScreens({Key? key}) : super(key: key);

  @override
  State<ForgetScreens> createState() => _ForgetScreensState();
}

class _ForgetScreensState extends State<ForgetScreens> {
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
                Container(
                  margin: EdgeInsets.fromLTRB(10,10,10,10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      label: Text("Email Address"),
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),

                ElevatedButton.icon(onPressed: (){},label: Text("Forget Password",style: TextStyle(fontSize: 15),),
                  icon: Icon(Icons.phone_android_sharp),)

              ],
            ),
          ),
        ),
      ),
    );
  }
}