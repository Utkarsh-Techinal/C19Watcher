import 'package:flutter/material.dart';
import 'signin.dart';
import 'signup.dart';
import 'ui/Dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ui/Profile.dart';
import 'ui/LiveWatcher.dart';
import 'ui/Search.dart';
import 'ui/Details.dart';
import 'ui/Employers.dart';
import 'ui/LiveWatcherDetails.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
            Signin.id : (context) => Signin(),
        SignupPage.id: (context) => SignupPage(),
        HomePage.id: (context) => HomePage(),
        ProfilePage.id: (context) => ProfilePage(),
        LiveWatcher.id: (context) => LiveWatcher(),
        MySearchPage.id: (context) => MySearchPage(),
        Details.id: (context) => Details(),
        Employers.id: (context) =>  Employers(),
        LiveDetails.id : (context) => LiveDetails()
      },
      home: FutureBuilder(
        future: getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return Signin();
          }
        },
      ),
    );
  }
}


