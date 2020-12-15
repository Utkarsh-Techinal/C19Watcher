import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'Profile.dart';
import 'package:page_transition/page_transition.dart';
import 'LiveWatcher.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Details.dart';


class Employers extends StatefulWidget {
  static String id = 'employers';

  @override
  _EmployersState createState() => _EmployersState();
}

class _EmployersState extends State<Employers> {
  final double _borderRadius = 24;
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Employers(),
    Employers(),
    Employers(),
    Employers(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Employers();
  final dbRef = FirebaseDatabase.instance.reference().child("Employers");
  List<Map<dynamic, dynamic>> lists = [];// Our first view in viewport

  //
  // var items = [
  //   PlaceInfo('Dubai Mall Food Court', Color(0xff6DC8F3), Color(0xff73A1F9),
  //       4.4, 'Dubai · In The Dubai Mall', 'Cosy · Casual · Good for kids'),
  //   PlaceInfo('Hamriyah Food Court', Color(0xffFFB157), Color(0xffFFA057), 3.7,
  //       'Sharjah', 'All you can eat · Casual · Groups'),
  //   PlaceInfo('Gate of Food Court', Color(0xffFF5B95), Color(0xffF8556D), 4.5,
  //       'Dubai · Near Dubai Aquarium', 'Casual · Groups'),
  //   PlaceInfo('Express Food Court', Color(0xffD76EF5), Color(0xff8F7AFE), 4.1,
  //       'Dubai', 'Casual · Good for kids · Delivery'),
  //   PlaceInfo('BurJuman Food Court', Color(0xff42E695), Color(0xff3BB2B8), 4.2,
  //       'Dubai · In BurJuman', '...'),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          elevation: 4,
          backgroundColor: Colors.white,
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
              Text('Employers', style: TextStyle(
                  color: Colors.black
              ),),
            ],
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.pushReplacementNamed(context, 'LiveWatcher');


              },
              child: Image.asset('assets/group-of-people.png'),
            ),

            SizedBox(
              width: 5,
            ),

          ],
        ),
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
                              Employers(); // if user taps on this dashboard tab will be active
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
                              Employers(); // if user taps on this dashboard tab will be active
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
                              Employers(); // if user taps on this dashboard tab will be active
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


        body:FutureBuilder(
          future: dbRef.once(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if(snapshot.hasData){
              lists.clear();
              Map<dynamic, dynamic> values = snapshot.data.value;
              values.forEach((key, values) {
                lists.add(values);
              });
              return  ListView.builder(
                  shrinkWrap: true,
                  itemCount: lists.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed(
                          Details.id,
                          arguments: {
                            'title': '${lists[index]["Name"]}',
                            'url' :  '${lists[index]["imageurl"]}',
                            'alert': 'none'
                          },
                        );
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(_borderRadius),
                                  gradient: LinearGradient(colors: [
                                    Color(0XffD2FCEF),
                                    Color(0XffD2FCEF)
                                    // Color(0Xff06BF86)
                                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white10,
                                      blurRadius: 12,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                top: 0,
                                child: CustomPaint(
                                  size: Size(100, 150),
                                  painter: CustomCardShapePainter(_borderRadius,
                                      Color(0Xff06BF86), Color(0XffD2FCEF)),
                                ),
                              ),
                              Positioned.fill(
                                child: Row(

                                  children: <Widget>[
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(

                                      child: Image.network(
                                        '${lists[index]["imageurl"]}',
                                        height: 64,
                                        width: 64,
                                      ),
                                      flex: 2,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            lists[index]["Name"],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontFamily: 'Avenir',
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.red,
                                                size: 16,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  'C19 Watcher.pvt.ltd',
                                                  style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontFamily: 'Avenir',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );

                  });

            }
            else{
              return Center(
                child: Text("Loading..."),
              );
            }
          },

        ));

  }
}

class PlaceInfo {
  final String name;
  final String category;
  final String location;
  final double rating;
  final Color startColor;
  final Color endColor;

  PlaceInfo(this.name, this.startColor, this.endColor, this.rating,
      this.location, this.category);
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}