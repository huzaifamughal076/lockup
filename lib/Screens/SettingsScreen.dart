import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {


  String? Language = "hello";

  String SettingsText = "Settings";

  void getSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    Language = prefs.getString('Language');

    if (Language == "English") {
      setState(() async {

        SettingsText = "Settings";

      });
    } else {
      setState(() {
        SettingsText = " הגדרות ";
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
            title: Text(SettingsText),
          ),
          body: Center(child: Text(SettingsText)) ,
        )
    );
  }
}