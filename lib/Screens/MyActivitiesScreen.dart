import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lock_up/Screens/CreateNewActivityScreen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/ActivityModel.dart';
import 'EditActivityScreen.dart';

class MyActivitiesScreen extends StatefulWidget {
  final String uid, userName;

  const MyActivitiesScreen(this.uid, this.userName, {Key? key})
      : super(key: key);

  @override
  State<MyActivitiesScreen> createState() => _MyActivitiesScreenState();
}

class _MyActivitiesScreenState extends State<MyActivitiesScreen> {
  List<ActivityModel> allActivities = [];
  List<ActivityModel> myActivities = [];
  List<int> NumberOfMembers = [];

  var _counter = 0;

  final databaseReference = FirebaseDatabase.instance.reference().child("Activities");
  final databaseReference2 = FirebaseDatabase.instance.reference().child("Deleted");
  // final test = FirebaseDatabase.instance.reference().child("Activities");
  final formKey = GlobalKey<FormState>();
  TextEditingController activityName = TextEditingController();
  TextEditingController activityPassword = TextEditingController();
  late String name, password;

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

  Future _handleRefresh()async {
    _counter --;
    await getAllActivities();
  }

  @override
  void initState() {
    getAllActivities();
    super.initState();
  }

  Future getAllActivities() async {
    try {
      await databaseReference.once().then((event) {
        allActivities.clear();
        for (final entity in event.snapshot.children) {
          String name = entity
              .child("name")
              .value
              .toString();
          String manager = entity
              .child("manager")
              .value
              .toString();
          String id = entity
              .child("id")
              .value
              .toString();
          String password = entity
              .child("password")
              .value
              .toString();

          ActivityModel activitymodel = ActivityModel(
              name: name, manager: manager, password: password, id: id);
          allActivities.add(activitymodel);
        }
        print("all activities length: " + allActivities.length.toString());
        print("all activities length: " + allActivities.length.toString());
        myActivities.clear();
        myActivities = getMyActivities(allActivities);

      });
    }on FirebaseAuthException catch(error)
    {
      Fluttertoast.showToast(msg: error.message.toString());
      print(error);
    }
    await getMembersLength();

    if(_counter ==0)
    {
      if(myActivities.length==0)
      {
        Fluttertoast.showToast(msg: "No Activity Found");
        _counter ++;
      }
    }
  }


  getMembersLength() async {
    int count = 0;
    NumberOfMembers.clear();
    try {
      for (int i = 0; i < myActivities.length; i++) {
        await databaseReference.child(myActivities[i].id!).once().then((value) {
          if (value.snapshot
              .child("Members")
              .exists) {
            count = value.snapshot
                .child("Members")
                .children
                .length;
            NumberOfMembers.add(count);
          } else {
            NumberOfMembers.add(0);
          }
        });
      }
    }on FirebaseAuthException catch(error)
    {
      Fluttertoast.showToast(msg: error.message.toString());
      print(error);
    }

  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text('My Activities'),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateNewActivityScreen(widget.uid)));

            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: LiquidPullToRefresh(
            onRefresh: _handleRefresh,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: SafeArea(
                top: true,
                child: FutureBuilder(
                      future: getAllActivities(),
                      builder: (context, projectSnap) {
                        if (projectSnap.connectionState == ConnectionState.none &&
                            projectSnap.hasData == null) {
                          //print('project snapshot data is: ${projectSnap.data}');
                          return Container(
                            margin: EdgeInsets.only(top: 12),
                            child: Text('You have no active activities'),
                          );
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: myActivities.length,
                            itemBuilder: (context, index) {
                              var currentItem = myActivities[index];
                              if (myActivities.length < 1 ||
                                  myActivities.length == null) {
                                return Container(
                                  margin: EdgeInsets.only(top: 12),
                                  child: Text('You have no active activities'),
                                );
                              } else
                                return Container(
                                  width: double.infinity,
                                  height: 170,
                                  padding: new EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => ActivityScreen(
                                      //             myActivities[index].id, widget.uid)));
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      color: Colors.white,
                                      elevation: 10,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Align(
                                              alignment: Alignment.centerRight,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  Text(currentItem.name!,
                                                      style: TextStyle(fontSize: 24.0)),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Icon(Icons.location_city, size: 40),
                                                ],
                                              ),
                                            ),
                                            subtitle: Container(
                                              margin: EdgeInsets.only(right: 20),
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                    "Members : " +
                                                        NumberOfMembers[index]
                                                            .toString() ??
                                                        "0",
                                                    style: TextStyle(fontSize: 15.0)),
                                              ),
                                            ),
                                          ),
                                          ButtonBar(
                                            alignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (BuildContext context) =>
                                                    new CupertinoAlertDialog(
                                                      title: new Text("Are you Sure",
                                                          style: TextStyle(
                                                              fontSize: 19,
                                                              color: Colors.black)),
                                                      content: new Text(
                                                          "You want to Delete."),
                                                      actions: [
                                                        CupertinoDialogAction(
                                                            isDefaultAction: true,
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            },
                                                            child: new Text("Close")),
                                                        CupertinoDialogAction(
                                                            isDefaultAction: true,
                                                            onPressed: () {
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                  "Deleted Successfully.");
                                                              Navigator.pop(context);
                                                              myActivities
                                                                  .removeAt(index -1);
                                                              DeleteActivity(
                                                                  myActivities[
                                                                  index -1]);

                                                            },
                                                            child: new Text("Delete"))
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.share),
                                                onPressed: () {
                                                  Share.share("Activity Created By: " +
                                                      widget.userName +
                                                      "\n\nActivity ID: " +
                                                      currentItem.id! +
                                                      "\nActivity pass: " +
                                                      currentItem.password!);
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditActivityScreen(
                                                                currentItem.id!,
                                                                currentItem.name!,
                                                                currentItem.password!)),
                                                  );
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.qr_code_scanner),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return StatefulBuilder(
                                                          builder: (BuildContext
                                                          context,
                                                              StateSetter setState) {
                                                            return Dialog(
                                                              shape:
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      20.0)),
                                                              //this right here
                                                              child: Container(
                                                                height: 300,
                                                                width: 300,
                                                                child: Align(
                                                                  alignment:
                                                                  Alignment.center,
                                                                  child: QrImage(
                                                                    data:
                                                                    currentItem.id!,
                                                                    version:
                                                                    QrVersions.auto,
                                                                    size: 200.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                            },
                          );
                        }
                      }),
              ),
            ),
          ),
          ),
    );
  }

  getMyActivities(List<ActivityModel> allActivities) {
    // List<ActivityModel> myActivities = [];
    myActivities.clear();
    try {
      for (var activity in allActivities) {
        if (activity.manager == widget.uid) {
          myActivities.add(activity);
        }
      }
    }catch(error)
    {
      Fluttertoast.showToast(msg: error.toString());
    }
    return myActivities;
  }

  void DeleteActivity(ActivityModel myActiviti) async {
    print(myActiviti.id!);
    try {
      await databaseReference.child(myActiviti.id!).remove();
      await databaseReference2
          .child(myActiviti.id!)
          .child("id")
          .set(myActiviti.id!);
      await databaseReference2
          .child(myActiviti.id!)
          .child("manager")
          .set(myActiviti.manager);
      await databaseReference2
          .child(myActiviti.id!)
          .child("name")
          .set(myActiviti.name);
      await databaseReference2
          .child(myActiviti.id!)
          .child("password")
          .set(myActiviti.password);


    }on FirebaseAuthException catch(error)
    {
      Fluttertoast.showToast(msg: error.message.toString());
      print(error.message.toString());
    }

    return;
  }
}