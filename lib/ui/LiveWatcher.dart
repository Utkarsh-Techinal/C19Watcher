import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'Dashboard.dart';
import 'package:page_transition/page_transition.dart';
import 'Profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'LiveWatcherDetails.dart';

class LiveWatcher extends StatefulWidget {
  static String id = 'LiveWatcher';

  @override
  _LiveWatcherState createState() => _LiveWatcherState();
}

class _LiveWatcherState extends State<LiveWatcher> {


  final List<String> _listItem = [
    'assets/wiht background.png',
    'assets/wiht background.png',
    'assets/wiht background.png',
    'assets/wiht background.png',

  ];
  int currentTab = 2; // to keep track of active tab index
  final List<Widget> screens = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = LiveWatcher();
  final dbRef = FirebaseDatabase.instance.reference().child("SocialDistancing");
  List<Map<dynamic, dynamic>> lists = [];

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
            Text('Live Watcher', style: TextStyle(
              color: Colors.black
            ),),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 36,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10)
              ),
              child: FutureBuilder(
                  future: dbRef.once(),
    builder: (context, AsyncSnapshot<DataSnapshot> snapshot){
                    if(snapshot.hasData){
                      return Center(child: Text("${lists.length}"));
                    }
                    else{
                      return Center(child: Text("."));
                    }
    }

    ),
            ),
          )
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

      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),

                ),
                child: ListView(


                  children: <Widget>[


                    SizedBox(height: 15.0),


                    CarouselSlider(
                      height: 200.0,


                      enlargeCenterPage: true,


                      autoPlay: true,


                      aspectRatio: 16 / 9,


                      autoPlayCurve: Curves.fastOutSlowIn,


                      enableInfiniteScroll: true,


                      autoPlayAnimationDuration: Duration(milliseconds: 800),


                      viewportFraction: 0.8,




                      items: [


                        Container(


                          margin: EdgeInsets.all(5.0),


                          decoration: BoxDecoration(


                            borderRadius: BorderRadius.circular(10.0),


                            image: DecorationImage(


                              image: AssetImage('assets/lycs-architecture-U2BI3GMnSSE-unsplash.jpg'),


                              fit: BoxFit.cover,


                            ),


                          ),


                          child: Column(


                            mainAxisAlignment: MainAxisAlignment.center,


                            crossAxisAlignment: CrossAxisAlignment.center,


                            children: <Widget>[


                              Text(


                                'BASEMENT',


                                style: TextStyle(


                                  color: Colors.white,


                                  fontWeight: FontWeight.bold,


                                  fontSize: 18.0,


                                ),


                              ),



                              Padding(


                                padding: const EdgeInsets.all(15.0),


                                child: Text(


                                  'Lorem Ipsum is simply dummy text use for printing and type script',


                                  style: TextStyle(


                                    color: Colors.white,


                                    fontSize: 15.0,


                                  ),


                                  textAlign: TextAlign.center,


                                ),


                              ),


                            ],


                          ),


                        ),



                        Container(


                          margin: EdgeInsets.all(5.0),


                          decoration: BoxDecoration(


                            borderRadius: BorderRadius.circular(10.0),


                            image: DecorationImage(


                              image: AssetImage('assets/lycs-architecture-U2BI3GMnSSE-unsplash.jpg'),


                              fit: BoxFit.cover,


                            ),


                          ),


                          child: Column(


                            mainAxisAlignment: MainAxisAlignment.center,


                            crossAxisAlignment: CrossAxisAlignment.center,


                            children: <Widget>[


                              Text(


                                'MEETING HALL',


                                style: TextStyle(


                                  color: Colors.white,


                                  fontWeight: FontWeight.bold,


                                  fontSize: 18.0,


                                ),


                              ),



                              Padding(


                                padding: const EdgeInsets.all(15.0),


                                child: Text(


                                  'Lorem Ipsum is simply dummy text use for printing and type script',


                                  style: TextStyle(


                                    color: Colors.white,


                                    fontSize: 15.0,


                                  ),


                                  textAlign: TextAlign.center,


                                ),


                              ),


                            ],


                          ),


                        ),



                        Container(


                          margin: EdgeInsets.all(5.0),


                          decoration: BoxDecoration(


                            borderRadius: BorderRadius.circular(10.0),


                            image: DecorationImage(


                              image: AssetImage('assets/blog.jpg'),


                              fit: BoxFit.cover,


                            ),


                          ),


                          child: Column(


                            mainAxisAlignment: MainAxisAlignment.center,


                            crossAxisAlignment: CrossAxisAlignment.center,


                            children: <Widget>[


                              Text(


                                'CAFETERIA',


                                style: TextStyle(


                                  color: Colors.white,


                                  fontWeight: FontWeight.bold,


                                  fontSize: 18.0,


                                ),


                              ),



                              Padding(


                                padding: const EdgeInsets.all(15.0),


                                child: Text(


                                  'Lorem Ipsum is simply dummy text use for printing and type script',


                                  style: TextStyle(


                                    color: Colors.white,


                                    fontSize: 15.0,


                                  ),


                                  textAlign: TextAlign.center,


                                ),


                              ),


                            ],


                          ),


                        ),


                      ],


                    ),
                    SizedBox(height: 15.0),

                  ],


                ),
              ),
              SizedBox(height: 15.0),

              FutureBuilder(
                future: dbRef.once(),
    builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
      if (snapshot.hasData) {
        lists.clear();
        Map<dynamic, dynamic> values = snapshot.data.value;
        values.forEach((key, values) {
          lists.add(values);
        });
        return Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              shrinkWrap: true,
              itemCount: lists.length,
    itemBuilder: (BuildContext context, int index) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(
          LiveDetails.id,
          arguments: {
            'title': 'Basement',
            'url' :  '${lists[index]["ImageUrl"]}',
            'alert': 'Group 1933.png'
          },
        );
      },
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage('${lists[index]["ImageUrl"]}'),
                  fit: BoxFit.cover
              )
          ),
          child: Transform.translate(
            offset: Offset(70, 65),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 63),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),

              ),
              child: Row(

                children: <Widget>[
                  Image.asset('assets/Group 1933.png',
                    width: 30,
                  ),

                  // RatingBar(rating: items[index].rating),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    }

            )
        );
      }
      else{
        return Text('Loading');
      }
    }


              )
            ],
          ),
        ),
      ),
    );
  }
}