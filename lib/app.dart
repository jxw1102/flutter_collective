import 'package:flutter/material.dart';

import 'product_page.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Vestiaire Collective',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.copyWith(
          title: TextStyle(fontSize: 50.0, fontFamily: 'Quarto', fontWeight: FontWeight.w300, letterSpacing: -0.74),
          headline: TextStyle(fontSize: 18.0, fontFamily: 'HKGrotesk', letterSpacing: 1.5),
          body1: TextStyle(fontSize: 18.0, fontFamily: 'HKGrotesk', fontWeight: FontWeight.normal),
          body2: TextStyle(fontSize: 18.0, fontFamily: 'HKGrotesk', fontWeight: FontWeight.w500),
        )
      ),
      home: ProductPage(),
    );
  }
}
