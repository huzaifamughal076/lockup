import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

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
            title: Text("Contact Us"),
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
                              child: Text("Contact Us",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),

                          Container(
                            margin: EdgeInsets.fromLTRB(10,0,10,0),
                            child: TextFormField(
                              validator: (emailController){
                                if(emailController!.isEmpty ||
                                    emailController == null)
                                  {
                                    return "Email Required";
                                  }
                                else{
                                  email = emailController;
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Email",
                                label: Text("Email"),
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
                                    return "Subject Required";
                                  }
                                else{
                                  subject = subjectController;
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Subject",
                                label: Text("Subject"),
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
                                  return "Subject Required";
                                }
                                else{
                                  message = messageController;
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Message",
                                label: Text("Message"),
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
                  ElevatedButton.icon(
                      onPressed: (){

                      }, icon: Icon(Icons.send,color: Colors.white,textDirection: TextDirection.ltr),
                      label: Text("Send",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
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