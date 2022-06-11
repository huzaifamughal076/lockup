import 'package:flutter/material.dart';

class JoinedActivitiesScreen extends StatefulWidget {
  const JoinedActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<JoinedActivitiesScreen> createState() => _JoinedActivitiesScreenState();
}

class _JoinedActivitiesScreenState extends State<JoinedActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Align(
                alignment: Alignment.centerLeft,
                child: Text("Joined Activities")),
          ),
          body: Center(child: Text('Joined Activities')) ,
        )
    );
  }
}