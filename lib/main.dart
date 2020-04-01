import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class Trip {
  String TripTitle;
  String TripDate;
  String TripAdress;
  String Tripprice;
  Trip({this.TripTitle, this.Tripprice, this.TripDate, this.TripAdress});

  factory Trip.fromJson(Map<String, dynamic> parsedJson) {
    return Trip(
      TripTitle: parsedJson['title'],
      TripDate: parsedJson['date'],
      TripAdress: parsedJson['address'],
      Tripprice: parsedJson['price'],
    );
  }
}

Future<String> _loadATripAsset() async {
  return await rootBundle.loadString('assets/a.json');
}

Future<Trip> loadTrip() async {
  await wait(5);
  String jsonString = await _loadATripAsset();
  final jsonResponse = json.decode(jsonString);
  return new Trip.fromJson(jsonResponse);
}

Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Widget futureWidget() {
    return new FutureBuilder<Trip>(
      future: loadTrip(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new Column(
              // padding: new EdgeInsets.all(20.0),
              children: <Widget>[
                new Flexible(
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: Stack(
                          children: <Widget>[
                            c(),
                            Positioned(
                              left: 20.0,
                              top: 20.0,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star_border,
                                    color: Colors.white,
                                  ),
                                  Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                                right: 20.0,
                                top: 20.0,
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                      Card(
                        
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'سفارى#',
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${snapshot.data.TripTitle}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                       
                      ),
                      Card(
                      
                        child: Column(
                          children: <Widget>[
                            ListTile(
                                trailing: Icon(Icons.calendar_today),
                                title: Align(
                                  child: Text('${snapshot.data.TripDate}'),
                                  alignment: Alignment.centerRight,
                                )),
                            ListTile(
                              trailing: Icon(Icons.add_location),
                              title: Align(
                                  child: Text('${snapshot.data.TripAdress}'),
                                  alignment: Alignment.centerRight),
                            ),
                          ],
                        ),
                        color: Colors.white,
                      ),
                      Card(
                        color: Colors.white,
                       
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'مغامروا الهايك',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),

                              trailing: CircleAvatar(
                                backgroundImage:
                                    ExactAssetImage('assets/1.jpg'),
                                minRadius: 20,
                                maxRadius: 20,
                              ),
                              
                            ),
                            ListTile(
                              title: Align(
                                child: Text(
                                  '  خبره اكثر من عشر سنوات بهذا المجال',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        
                        child: Column(
                          children: <Widget>[
                            ListTile(
                                trailing: Text('التفاصيل',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ))),
                            ListTile(
                              title: Align(
                                  child: Text(
                                      'القراءه بشكل جيد    و بهذه الطؤيقع التى تؤدى الى هذا النص هو مثال لنص يمكن ان يستبدل فى نفس المساحه زو بهذا الشكل'),
                                  alignment: Alignment.centerRight),
                            ),
                          ],
                        ),
                        color: Colors.white,
                      ),
                      Card(
                      
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              trailing: Text(
                                'تكلفه الرحله',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              trailing: Text(
                                'السعر',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              title: Text('${snapshot.data.Tripprice}'),
                            ),
                          ],
                        ),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                new SafeArea(
                  bottom: true,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.transparent,
                    ),
                    child: RaisedButton(
                      child: Text(
                        'قم بالحجز الان',
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.purple,
                      splashColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      onPressed: () {},
                    ),
                  ),
                ),
              ]);
        } else if (snapshot.hasError) {
          return new Text("${snapshot.error}");
        }
        return new CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(body: new Container(child: futureWidget())));
  }
}

class c extends StatefulWidget {
  @override
  _cState createState() => _cState();
}

class _cState extends State<c> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        child: Carousel(
          images: [
            ExactAssetImage("assets/1.jpg"),
            ExactAssetImage("assets/2.jpg"),
          ],
        ));
  }
}
