import 'package:flutter/material.dart';

import 'data/epg.dart';

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
    ];
    return Container(
      width: 100,
      margin: EdgeInsets.only(top: 60),
      child: ListView.builder(
        controller: _scrollControllerChannel,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemExtent: 62,
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
                    fontSize: 20.0,
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _createTextColum(50),
        ),
      ),
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollStartNotification) {
        } else if (scrollInfo is ScrollUpdateNotification) {
          print(_scrollControllerVetical.offset);
          _scrollControllerChannel.jumpTo(_scrollControllerVetical.offset);
        } else if (scrollInfo is ScrollEndNotification) {}
      },
    );
  }

  List<Widget> _createTextColum(int i) {
    List<Widget> widgets = [];
    for (int r = 0; r <= i; r++) {
      widgets.add(Row(
        children: _createText(50),
      ));
    }
    return widgets;
  }

  List<Widget> _createText(int i) {
    List<Widget> widgets = [];
    var listData = _createDataTest();
    for (int r = 0; r <= i; r++) {
      listData..shuffle();
      widgets.add(newCell(listData[r]));
    }
    return widgets;
  }

  Widget newCell(EPGEntity data) {
    print(((data.end - data.start)).toDouble().toString());
    return Container(
        width: ((data.end - data.start)).toDouble(),
        height: 55,
        color: Colors.blueAccent,
        margin: EdgeInsets.all(3),
        child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: Text(
                data.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            )));
  }

  List<EPGEntity> _createDataTest() {
    List<EPGEntity> dataList = List();
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 80, "program1"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 80, "program2"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 100, "program3"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 200, "program4"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 40, "program5"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 300, "program6"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 40, "program7"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 100, "program8"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 70, "program4"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 90, "program5"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 30, "program1"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 40, "program2"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 50, "program3"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 70, "program4"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 40, "program5"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 100, "program1"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 40, "program2"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 50, "program3"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 150, "program4"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 100, "program5"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 30, "program1"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 40, "program2"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 50, "program3"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 40, "program4"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 150, "program5"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 30, "program1"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 40, "program2"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 50, "program3"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 40, "program4"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 80, "program5"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 30, "program1"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 100, "program2"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 50, "program3"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 200, "program4"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 70, "program5"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 100, "program1"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 40, "program2"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 50, "program3"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 40, "program4"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 150, "program5"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 30, "program1"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 40, "program2"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 50, "program3"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 80, "program4"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 40, "program5"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 30, "program1"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 100, "program2"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 50, "program3"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 150, "program4"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 80, "program5"));
    dataList.add(EPGEntity(1574401834307, 1574401834307 + 200, "program6"));
    return dataList;
  }

  @override
  void dispose() {
    _scrollControllerVetical.dispose();
    _scrollControllerChannel.dispose();
    _scrollControllerTimeline.dispose();
    super.dispose();
  }
}
