import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ScrollController _scrollControllerChannel;
  ScrollController _scrollControllerTimeline;
  ScrollController _scrollControllerVetical;

  @override
  void initState() {
    super.initState();
    _scrollControllerVetical = ScrollController();
    _scrollControllerTimeline = ScrollController();
    _scrollControllerChannel = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Row(
        children: <Widget>[
          Expanded(
            child: buildChannel(),
          ),
          Expanded(
            flex: 10,
            child: SingleChildScrollView(
              primary: false,
              controller: _scrollControllerTimeline,
              scrollDirection: Axis.horizontal,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: buildTimeLine(),
                    ),
                    Expanded(
                      flex: 10,
                      child: listViewEpgHorizalNew(),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget buildTimeLine() {
    final listimeline = [
      "00:00",
      "00:30",
      "01:00",
      "01:30",
      "02:00",
      "02:30",
      "03:00",
      "03:30",
      "04:00",
      "04:30",
      "05:00",
      "05:30",
      "06:00",
      "06:30",
      "07:00",
      "07:30",
      "08:00",
      "08:30",
      "09:00",
      "09:30",
      "10:00",
      "10:30",
      "11:00",
      "11:30",
      "12:00",
      "12:30"
    ];
    return Container(
      height: 50,
      child: ListView.builder(
          controller: _scrollControllerTimeline,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemExtent: 100,
          itemCount: listimeline.length,
          itemBuilder: (context, position) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
              child: Text(
                listimeline[position],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 22.0,
                ),
              ),
            );
          }),
    );
  }

  Widget buildChannel() {
    final listChannel = [
      "acb",
      "bca",
      "enc",
      "tyb",
      "acb",
      "bca",
      "enc",
      "tyb",
      "acb",
      "bca",
      "enc",
      "tyb",
      "acb",
      "bca",
      "enc",
      "tyb",
      "acb",
      "bca",
      "enc",
      "tyb",
      "enc",
      "tyb",
      "acb",
      "bca",
      "enc",
      "tyb",
      "acb",
      "bca",
      "enc",
      "enc",
      "tyb",
      "enc",
      "tyb",
      "acb",
      "bca",
      "enc",
      "tyb",
      "acb",
      "bca",
      "enc"
    ];
    return Container(
      width: 100,
      child: ListView.builder(
        controller: _scrollControllerChannel,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemExtent: 150,
        itemBuilder: (context, position) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                child: Text(
                  listChannel[position],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Divider(
                  height: 1.0,
                  color: Colors.grey,
                ),
              )
            ],
          );
        },
        itemCount: listChannel.length,
      ),
    );
  }

  Widget listViewEpgHorizalNew() {
    return NotificationListener<ScrollNotification>(
      child: SingleChildScrollView(
        primary: false,
        controller: _scrollControllerVetical,
        scrollDirection: Axis.vertical,
        child: Column(
          children: _createTextColum(50),
        ),
      ),
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollStartNotification) {

        } else if (scrollInfo is ScrollUpdateNotification) {
          print(_scrollControllerVetical.offset);
          _scrollControllerChannel.jumpTo(_scrollControllerVetical.offset);
        } else if (scrollInfo is ScrollEndNotification) {

        }
      },
    );
  }

  List<Widget> _createTextColum(int i) {
    List<Widget> widgets = [];
    for (int r = 1; r <= i; r++) {
      widgets.add(Row(
        children: _createText(50),
      ));
      //widgets.add(newCell("Row " + r.toString() + " Column " + i.toString()));
    }
    return widgets;
  }

  List<Widget> _createText(int i) {
    List<Widget> widgets = [];
    for (int r = 1; r <= i; r++) {
      widgets.add(newCell("Row " + r.toString() + " Column " + i.toString()));
    }
    return widgets;
  }

  Widget newCell(String data) {
    return CircleAvatar(
        maxRadius: 80.0,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(data),
        ));
  }

  @override
  void dispose() {
    _scrollControllerVetical.dispose();
    _scrollControllerChannel.dispose();
    _scrollControllerTimeline.dispose();
    super.dispose();
  }
}
