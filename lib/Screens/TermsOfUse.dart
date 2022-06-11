import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsOfUse extends StatefulWidget {
  const TermsOfUse({Key? key}) : super(key: key);

  @override
  State<TermsOfUse> createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Align(
              alignment: Alignment.centerLeft,
              child: Text("Terms Of Use",style: TextStyle(fontWeight: FontWeight.bold),)),
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  width: double.infinity,
                  child: Center(child: Text("Terms Of Use",style: TextStyle(fontWeight: FontWeight.bold),)),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("A paragraph (from Ancient Greek παράγραφος (parágraphos) 'to write beside') is a self-contained unit of discourse in writing dealing with a particular point or idea. A paragraph consists of one or more sentences.[1] Though not required by the syntax of any language, paragraphs are usually an expected part of formal writing, used to organize longer prose.",
                        textDirection: TextDirection.ltr,)),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}