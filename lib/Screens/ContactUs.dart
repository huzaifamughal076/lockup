import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {


  String? Language = "hello";

  String ContactUs = "Contact Us";
  String EmailHintMessage = "Email";
  String SubjectHintMessage = "Subject";
  String MessageHintMessage = "Message";
  String SendText = "Send";

  String errorEmailRequired = "Email Required";
  String errorSubjectRequired = "Subject Required";
  String errorMessageRequired = "Message Required";

  void getSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    Language = prefs.getString('Language');

    if (Language == "English") {
      setState(() async {

        ContactUs = "Contact Us";
        EmailHintMessage = "Email";
        SubjectHintMessage = "Subject";
        MessageHintMessage = "Message";
        SendText = "Send";

        errorEmailRequired = "Email Required";
        errorSubjectRequired = "Subject Required";
        errorMessageRequired = "Message Required";

      });
    } else {
      setState(() {
        ContactUs = "צור קשר";
        EmailHintMessage = "אימייל";
        SubjectHintMessage = "נושא";
        MessageHintMessage = "הוֹדָעָה";
        SendText = "לִשְׁלוֹחַ";

        errorEmailRequired = "מייל (דרוש";
        errorSubjectRequired = "נושא חובה";
        errorMessageRequired = "דרושה הודעה";

      });
    }
  }


  @override
  void initState() {
    getSharedPrefs();
  }


  late GoogleMapController mapController;

  final formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  String? email,subject,message;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(ContactUs),
          ),
          body:  SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 300,
                    width: double.infinity,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(31.496922,74.246421),
                        zoom: 11.0,
                      ),

                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15,10,15,10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    child:Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text(ContactUs,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),

                          Container(
                            margin: EdgeInsets.fromLTRB(10,0,10,0),
                            child: TextFormField(
                              validator: (emailController){
                                if(emailController!.isEmpty ||
                                    emailController == null)
                                  {
                                    return errorEmailRequired;
                                  }
                                else{
                                  email = emailController;
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: EmailHintMessage,
                                label: Text(EmailHintMessage),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.fromLTRB(10,10,10,0),
                            child: TextFormField(
                              validator: (subjectController)
                              {
                                if(subjectController!.isEmpty ||
                                    subjectController == null)
                                  {
                                    return errorSubjectRequired;
                                  }
                                else{
                                  subject = subjectController;
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: SubjectHintMessage,
                                label: Text(SubjectHintMessage),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10,10,10,10),
                            child: TextFormField(
                              validator: (messageController)
                              {
                                if(messageController!.isEmpty ||
                                    messageController == null)
                                {
                                  return errorMessageRequired;
                                }
                                else{
                                  message = messageController;
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: MessageHintMessage,
                                label: Text(MessageHintMessage),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                              padding:
                              const EdgeInsets.fromLTRB(30, 20, 30, 20),
                              color: Color(0xFF002d56),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                              onPressed: () {
                                if (formkey.currentState != null &&
                                    formkey.currentState!.validate()) {

                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    SendText,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}