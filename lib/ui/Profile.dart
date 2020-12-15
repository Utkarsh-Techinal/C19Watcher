import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math' as math;
import 'package:getwidget/getwidget.dart';
import 'package:page_transition/page_transition.dart';
import 'Dashboard.dart';
import 'package:flutter_ui_login/signin.dart';

class ProfilePage extends StatefulWidget {
  static String id = 'profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

int _currentIndex = 4;
String userID = '';
String name = '';
String email = '';
bool showSpinner = false;
bool isActive = false;

var healthProfile = {};

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  getCurrentUser() async {}

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  int currentTab = 3; // to keep track of active tab index
  final List<Widget> screens = [
    HomePage(),
    ProfilePage(),
    ProfilePage(),
    ProfilePage(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = ProfilePage(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        elevation: 4,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/without background.png',
              height: 80,
              width: 80,
            ),
            SizedBox(
              width: 15,
            ),
            Text('Profile', style: TextStyle(
                color: Colors.black
            ),),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
          )
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Image.asset('assets/Group 1926.png'),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        Navigator.pushReplacementNamed(context, 'dash');
                        currentScreen =
                            HomePage(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        Navigator.pushReplacementNamed(context, 'search');

                        currentScreen =
                            HomePage(); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        Navigator.pushReplacementNamed(context, 'LiveWatcher');

                        currentScreen =
                            HomePage(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.videocam,
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Live',
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        Navigator.pushReplacementNamed(context, 'profile');
                        currentScreen =
                            ProfilePage(); // if user taps on this dashboard tab will be active
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: currentTab == 3 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: getapi(),
            builder: (context, snapshot) {
              Map content = snapshot.data;
              print(content);
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 25.0, bottom: 15.0),
                          child: Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60.0),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3.0,
                                    offset: Offset(0, 1.5),
                                    color: Colors.black38),
                              ],
                              image: DecorationImage(
                                image: AssetImage(
                                  "images/female.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15.0,
                            left: 5.0,
                            right: 15.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${loggedInUser.displayName}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "${loggedInUser.email}",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black45,
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Account",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Divider(
                        height: 15,
                        thickness: 2,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GFAccordion(
                      title: "User Settings",
                      titlePadding: EdgeInsets.only(
                        top: 10.0,
                        left: 10.0,
                        right: 10.0,
                        bottom: 10.0,
                      ),
                      expandedIcon: Icon(Icons.close),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      contentBorder: Border.all(color: Colors.black12),
                      contentChild: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      left: 10.0,
                                      right: 10.0,
                                      bottom: 15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                        color: Colors.black38,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Text(
                                          '',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      left: 10.0,
                                      right: 10.0,
                                      bottom: 15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                        color: Colors.black38,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Text(
                                          '',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      left: 10.0,
                                      right: 10.0,
                                      bottom: 15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                        color: Colors.black38,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Text(
                                          '',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      left: 10.0,
                                      right: 10.0,
                                      bottom: 15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                        color: Colors.black38,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Text(
                                          ' cm',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0,
                                      left: 10.0,
                                      right: 10.0,
                                      bottom: 15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                        color: Colors.black38,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Text(
                                          'BMI:',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    buildAccountOptionRow(context, "Edit Profile", 1),
                    buildAccountOptionRow(context, "Change password", 2),
                    buildAccountOptionRow(context, "Language", 3),
                    buildAccountOptionRow(context, "Privacy and security", 4),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Notifications",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Divider(
                        height: 15,
                        thickness: 2,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildNotificationOptionRow("Updates and Reminders",
                            (value) {
                          setState(() {
                            isActive = value;
                          });
                        }),

                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                              bottom: 20.0,
                            ),
                            child: OutlineButton(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {},
                              child: Text("REPORT",
                                  style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 1.5,
                                      color: Colors.black)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                              bottom: 20.0,
                            ),
                            child: OutlineButton(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                Navigator.pushNamed(context, 'signin');
                                    _auth.signOut();
                              },
                              child: Text("SIGN OUT",
                                  style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 1.5,
                                      color: Colors.black)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Future<Map> getapi() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        userID = loggedInUser.uid;
        print(loggedInUser.uid);
        name = loggedInUser.displayName;
        print(loggedInUser.displayName);
        email = loggedInUser.email;
        print(loggedInUser.email);
        print(loggedInUser.photoUrl);
        print(userID);
        String api =
            'https://419kmxl3nc.execute-api.ap-south-1.amazonaws.com/v1Ad/userid/$userID';
        http.Response response = await http.get(api);
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}

Padding buildNotificationOptionRow(String title, Function onChanged) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 15.0,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: onChanged,
            ))
      ],
    ),
  );
}

GestureDetector buildAccountOptionRow(
    BuildContext context, String title, int flag) {
  return GestureDetector(
    onTap: () {
      if (flag == 1) {
        // CupertinoScaffold
        //     .showCupertinoModalBottomSheet(
        //   expand: true,
        //   context: context,
        //   backgroundColor: Colors.transparent,
        //   builder: (context, scrollController) =>
        //       Stack(
        //         children: <Widget>[
        //
        //           Positioned(
        //             height: 40,
        //             left: 40,
        //             right: 40,
        //             bottom: 20,
        //             child: MaterialButton(
        //               onPressed: () => Navigator.of(
        //                   context)
        //                   .popUntil((route) =>
        //               route.settings.name == '/'),
        //               child: Text('Pop back home'),
        //             ),
        //           )
        //         ],
        //       ),
        // )
        Navigator.pushNamed(context, '/update_profile');
      }
      if (flag == 2) {
        print("2 pressed");
        Navigator.pushNamed(context, '/update_profile');
      }
      if (flag == 3) {
        print("hello");
      }
      if (flag == 4) {
        print("hello");
      }
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 19.0,
        horizontal: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 15.0,
          ),
        ],
      ),
    ),
  );
}