
import 'package:flutter/material.dart';

import 'package:cinemapp/src/pages/home_page.dart';
import 'package:cinemapp/src/pages/movie_details_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CinemApp',
      initialRoute: '/',
      routes: {
        '/'       :   (BuildContext context) => HomePage(),
        'details' :   (BuildContext context) => MovieDetailsPage(),
      },
    );
  }
}
