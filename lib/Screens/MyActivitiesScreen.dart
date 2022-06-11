import 'package:flutter/material.dart';
import 'package:lock_up/Screens/CreateNewActivityScreen.dart';

class MyActivitiesScreen extends StatefulWidget {
  const MyActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<MyActivitiesScreen> createState() => _MyActivitiesScreenState();
}

class _MyActivitiesScreenState extends State<MyActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Align(
              alignment: Alignment.centerLeft,
              child: Text("My Activities")),
        ),
        body: SafeArea(
            top: true,
            child: Center(child: Text('My Activities'))),


        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNewActivityScreen()));
          },
          child: const Icon(Icons.add),
        ),
        //BUTTON LOCATION
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}