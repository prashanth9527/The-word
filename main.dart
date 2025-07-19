import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'chapter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<Map<String, dynamic>> loadBible() async {
    String data = await rootBundle.loadString('lib/biblejson/NKJV_bible.json');
    return json.decode(data);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Offline Bible',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<Map<String, dynamic>>(
        future: loadBible(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage(bibleData: snapshot.data!);
          } else {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
