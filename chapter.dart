import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'verse_page.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> bibleData;
  const HomePage({super.key, required this.bibleData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final Map<String, bool> _open = {};
  final ScrollController _scrollController = ScrollController();
  late final List<GlobalKey> _itemKeys;

  @override
  void initState() {
    super.initState();
    _itemKeys = List.generate(
      widget.bibleData.length,
      (_) => GlobalKey(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookNames = widget.bibleData.keys.toList();

    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        title: Text(
          "Bible study",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: bookNames.length,
        itemBuilder: (context, index) {
          final book = bookNames[index];
          final chapters =
              (widget.bibleData[book] as Map<String, dynamic>).keys.toList();
          return Column(
            key: _itemKeys[index],
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                splashFactory: InkSplash.splashFactory,
                highlightColor: Colors.blueGrey[600],
                onTap: () {
                  setState(() {
                    if (_open[book] == true) {
                      _open.clear();
                    } else {
                      _open.clear();
                      _open[book] = true;

                      // Wait for the frame to finish building
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        // You can add logic here if you want to use the context in the future
                      });
                    }
                  });
                },
                child: Card(
                  color: Colors.blueGrey[900],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          book,
                          style: TextStyle(
                            color: Color.fromARGB(255, 168, 199, 250),
                          ),
                        ),
                        AnimatedRotation(
                          turns: _open[book] == true ? 0.5 : 0.0,
                          duration: Duration(milliseconds: 300),
                          // child: Icon(
                          //   Icons.expand_more,
                          //   color: Colors.white,
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AnimatedSize(
                duration: Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: (_open[book] == true)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 4.0),
                        child: AnimatedOpacity(
                          opacity: 1.0,
                          duration: Duration(milliseconds: 250),
                          child: Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            children: chapters.map<Widget>((chapter) {
                              return Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.blueAccent.withOpacity(0.18),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(50, 50),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1, vertical: 1),
                                    backgroundColor: Colors.blueGrey[700],
                                    foregroundColor: Colors.white,
                                    textStyle: TextStyle(fontSize: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => VersePage(
                                          bookName: book,
                                          chapterNumber: chapter,
                                          verses: (widget.bibleData[book]
                                              as Map<String, dynamic>)[chapter],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(chapter),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
            ],
          );
        },
      ),
    );
  }
}
