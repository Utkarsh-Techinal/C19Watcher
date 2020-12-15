import 'dart:async';
import 'Dashboard.dart';
import 'Profile.dart';
import 'LiveWatcher.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:firebase_database/firebase_database.dart';


class LiveDetails extends StatefulWidget {
  static String id = 'livedetails';

  @override
  _LiveDetailsState createState() => _LiveDetailsState();
}

class _LiveDetailsState extends State<LiveDetails> {

  void launchWhatsApp(
      {@required String phone,
        @required String message,
      }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?   phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }
  Timer _timmerInstance;
  int _start = 0;
  String _timmer = '';
  bool _isInit = true;
  var title = '';
  var url='';
  var alert = '';
  final dbRef = FirebaseDatabase.instance.reference().child("Employers");
  List<Map<dynamic, dynamic>> lists = [];
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
      // routeArgs == 'takeImage' ? takeImage() : chooseFile();
      title = routeArgs['title'];
      url = routeArgs['url'];
      alert = routeArgs['alert'];

      _isInit = false;
    }
  }
  void startTimmer() {
    var oneSec = Duration(seconds: 1);
    _timmerInstance = Timer.periodic(
        oneSec,
            (Timer timer) => setState(() {
          if (_start < 0) {
            _timmerInstance.cancel();
          } else {
            _start = _start + 1;
            _timmer = getTimerTime(_start);
          }
        }));
  }


  String getTimerTime(int start) {
    int minutes = (start ~/ 60);
    String sMinute = '';
    if (minutes.toString().length == 1) {
      sMinute = '0' + minutes.toString();
    } else
      sMinute = minutes.toString();

    int seconds = (start % 60);
    String sSeconds = '';
    if (seconds.toString().length == 1) {
      sSeconds = '0' + seconds.toString();
    } else
      sSeconds = seconds.toString();

    return sMinute + ':' + sSeconds;
  }

  @override
  void initState() {
    super.initState();
    startTimmer();
  }

  @override
  void dispose() {
    _timmerInstance.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int currentTab = 4; // to keep track of active tab index
    final List<Widget> screens = [
      HomePage(),
      ProfilePage(),
      ProfilePage(),
      ProfilePage(),
    ]; // to store nested tabs
    final PageStorageBucket bucket = PageStorageBucket();
    Widget currentScreen = ProfilePage(); // Our first view in viewport
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
            Text('Alert', style: TextStyle(
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
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[


                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, color: Colors.redAccent),
                    Text(
                      '$title',
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                Image.asset('assets/$alert',
                  width: 50,),
                SizedBox(
                  height: 10,
                ),

                ClipRRect(
                  child: Image.network(
                    '$url',
                    height: 400.0,
                    width: 400.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                    future: dbRef.once(),
                    builder: (context, AsyncSnapshot<DataSnapshot> snapshot){
                      if(snapshot.hasData){
                        lists.clear();
                        Map<dynamic, dynamic> values = snapshot.data.value;
                        values.forEach((key, values) {
                          lists.add(values);
                        });
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            FunctionalButton(
                              title: 'Sent Alert',
                              icon: Icons.warning,
                              onPressed: (){
                                // FlutterOpenWhatsapp.sendSingleMessage("${lists[0]["Phone"]}", "Hello $title You have been captured by the C19_Watcher for not wearing Face Mask/violating Social Distancing.\n If you are caught again,you are liable to further disciplinary actions.");
                              },
                            ),

                          ],
                        );
                      }
                      else{
                        return Text('loading..');
                      }
                    }

                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FunctionalButton extends StatefulWidget {
  final title;
  final icon;
  final Function() onPressed;

  const FunctionalButton({Key key, this.title, this.icon, this.onPressed})
      : super(key: key);

  @override
  _FunctionalButtonState createState() => _FunctionalButtonState();
}

class _FunctionalButtonState extends State<FunctionalButton> {
  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RawMaterialButton(
          onPressed: widget.onPressed,
          splashColor: Colors.greenAccent,
          fillColor: Colors.white,
          elevation: 10.0,
          shape: CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(
              widget.icon,
              size: 50.0,
              color: Colors.red,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 20.0, color: Colors.red),
          ),
        )
      ],
    );
  }
}