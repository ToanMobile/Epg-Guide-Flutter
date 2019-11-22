import 'package:flutter/material.dart';

import 'library_epg/bidirectional_scroll_view.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BidirectionalScrollViewPlugin _plugin;
  ScrollController _scrollControllerChannel;
  ScrollController _scrollControllerTimeline;

  @override
  void initState() {
    super.initState();
    _scrollControllerTimeline = ScrollController();
    _scrollControllerChannel = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_plugin == null) {
      _plugin = BidirectionalScrollViewPlugin(
        /* childWidth: MediaQuery.of(context).size.width - 100,
        childHeight: MediaQuery.of(context).size.height - 100,*/
        child: listViewEpgHorizalNew(),
        scrollListener: (offset) {
          _scrollControllerTimeline.jumpTo(offset.dx);
          _scrollControllerChannel.jumpTo(offset.dy);
          print("----------");
          print("new x and y scroll offset: " +
              offset.dx.toString() +
              " " +
              offset.dy.toString());
          print("x and y scroll offset getters: " +
              _plugin.x.toString() +
              " " +
              _plugin.y.toString());
          print("height and width of overscrolled widget: " +
              _plugin.height.toString() +
              " " +
              _plugin.width.toString());
          print("height and width of the container: " +
              _plugin.containerHeight.toString() +
              " " +
              _plugin.containerWidth.toString());
          print("----------");
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: new Text('Bidirectional ScrollView Plugin'),
        ),
        body: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: buildChannel(),
              ),
              Expanded(
                flex: 10,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: buildTimeLine(),
                    ),
                    Expanded(
                      flex: 10,
                      child: _plugin,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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

  Widget listViewEpgHorizalNew() => Column(
    children: _createTextColum(50),
  );

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
    _scrollControllerChannel.dispose();
    _scrollControllerTimeline.dispose();
    super.dispose();
  }
}
