import 'package:flutter/material.dart';

class VersePage extends StatelessWidget {
  final String bookName;
  final String chapterNumber;
  final Map<String, dynamic> verses;

  const VersePage({
    super.key,
    required this.bookName,
    required this.chapterNumber,
    required this.verses,
  });

  @override
  Widget build(BuildContext context) {
    final verseNumbers = verses.keys.toList();

    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20, // 👈 adjust size here (default is 24)
          ),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "$bookName Chapter $chapterNumber",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: ListView.builder(
        itemCount: verseNumbers.length,
        itemBuilder: (_, index) {
          final verseNum = verseNumbers[index];
          final text = verses[verseNum].toString(); // ensure it's a String

          return Card(
            color: Colors.blueGrey[900],
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$verseNum",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    text,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 168, 199, 250),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
