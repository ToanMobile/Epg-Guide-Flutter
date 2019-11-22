import 'package:flutter/material.dart';

import 'library_epg/bidirectional_scroll_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EPGView(),
    );
  }
}

class EPGView extends StatefulWidget {
  @override
  EPGViewState createState() => new EPGViewState();
}

class EPGViewState extends State<EPGView> {
  ScrollController _scrollControllerChannel;
  ScrollController _scrollControllerTimeline;
  ScrollController _scrollControllerEpgHorizal;
  ScrollController _scrollControllerEpgVetical;
  final itemSize = 150.0;
  final itemSizeChannel = 50.0;
  BidirectionalScrollViewPlugin _plugin;

  @override
  void initState() {
    super.initState();
    _scrollControllerEpgVetical = ScrollController();
    _scrollControllerEpgHorizal = ScrollController();
    _scrollControllerTimeline = ScrollController();
    _scrollControllerChannel = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_plugin == null) {
      _plugin =BidirectionalScrollViewPlugin(
        childWidth: MediaQuery.of(context).size.width,
        childHeight: MediaQuery.of(context).size.height,
        child: listViewEpgHorizalNew(),
        velocityFactor: 2.0,
        scrollListener: (offset) {
          print("----------");
          print("new x and y scroll offset: " + offset.dx.toString() + " " + offset.dy.toString());
          print("x and y scroll offset getters: " + _plugin.x.toString() + " " + _plugin.y.toString());
          print("height and width of overscrolled widget: " + _plugin.height.toString() + " " + _plugin.width.toString());
          print("height and width of the container: " + _plugin.containerHeight.toString() + " " + _plugin.containerWidth.toString());
          print("----------");
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _plugin/*SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildChannel(context),
                Column(
                  children: <Widget>[
                    buildTimeLine(context),
                    _plugin
                  ],
                )
              ],
            ),
          ),*/
      ),
    );
  }

  Widget buildTimeLine(BuildContext context) {
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
      width: MediaQuery.of(context).size.width - 150,
      height: 50,
      child: ListView.builder(
          controller: _scrollControllerTimeline,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemExtent: itemSize,
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

  Widget buildChannel(BuildContext context) {
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
      height: MediaQuery.of(context).size.height - 50,
      child: ListView.builder(
        controller: _scrollControllerChannel,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemExtent: itemSizeChannel,
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

  Widget buildEpg() => SizedBox(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        controller: _scrollControllerEpgVetical,
        itemExtent: itemSize,
        itemCount: listEpg.length,
        itemBuilder: (context, position) {
          return listViewEpgHorizal();
        }),
  ); //listViewEpg();

  _onStartScroll(ScrollMetrics metrics) {
    setState(() {
      //message = "Scroll Start";
    });
  }

  _onHorizoneScroll(ScrollMetrics metrics) {
    //print(_scrollControllerEpgHori.offset);
    _scrollControllerTimeline.jumpTo(_scrollControllerEpgHorizal.offset);
  }

  _onVeticalScroll(ScrollMetrics metrics) {
    print(_scrollControllerEpgVetical.offset);
    _scrollControllerChannel.jumpTo(_scrollControllerEpgVetical.offset);
  }

  _onEndScroll(ScrollMetrics metrics) {
    setState(() {
      //message = "Scroll End";
    });
  }

  final listEpg = [
    "Cupcake",
    "Donut",
    "Eclair",
    "Froyo",
    "Gingerbread",
    "Honeycomb",
    "Ice Cream Sandwich",
    "Jellybean",
    "Kitkat",
    "Lollipop",
    "Marshmallow",
    "Nougat",
    "Oreo",
    "Pie",
    "Honeycomb",
    "Ice Cream Sandwich",
    "Jellybean",
    "Kitkat",
    "Lollipop",
    "Marshmallow",
    "Nougat",
    "Oreo",
    "Pie"
  ];

  Widget listViewEpgHorizal() => ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    scrollDirection: Axis.horizontal,
    itemExtent: itemSize,
    shrinkWrap: true,
    itemBuilder: (context, position) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
            child: Text(
              listEpg[position],
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
    itemCount: listEpg.length,
  );

  Widget listViewEpg() => NotificationListener<ScrollNotification>(
    child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollControllerEpgHorizal,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 3,
          height: MediaQuery.of(context).size.height - 210,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            controller: _scrollControllerEpgVetical,
            itemExtent: itemSize,
            itemCount: listEpg.length,
            itemBuilder: (context, position) {
              return listViewEpgHorizal();
            },
          ),
        )),
    onNotification: (ScrollNotification scrollInfo) {
      if (scrollInfo is ScrollStartNotification) {
        _onStartScroll(scrollInfo.metrics);
      } else if (scrollInfo is ScrollUpdateNotification) {
        _onVeticalScroll(scrollInfo.metrics);
      } else if (scrollInfo is ScrollEndNotification) {
        _onEndScroll(scrollInfo.metrics);
      }
    },
  );

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
    _scrollControllerEpgVetical.dispose();
    _scrollControllerEpgHorizal.dispose();
    _scrollControllerTimeline.dispose();
    super.dispose();
  }
}
