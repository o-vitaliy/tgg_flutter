import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:tgg/ui/routes.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  State createState() => new OnBoardingState();
}

class OnBoardingState extends State<OnBoardingPage> {
  static onTap(index) {
    print("$index selected.");
  }

  final List<Widget> _pages = <Widget>[
    new FlutterLogo(colors: Colors.blue),
    new FlutterLogo(style: FlutterLogoStyle.stacked, colors: Colors.red),
    new FlutterLogo(style: FlutterLogoStyle.stacked, colors: Colors.green),
  ];
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new PageView.builder(
            physics: new AlwaysScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: _pages.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildPage(index, index == _pages.length - 1);
            },
            onPageChanged: (int index) {
              _currentPageNotifier.value = index;
            }),
        new Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: new Container(
            padding: const EdgeInsets.all(20.0),
            child: new Center(
              child: new CirclePageIndicator(
                  itemCount: _pages.length,
                  currentPageNotifier: _currentPageNotifier),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPage(int index, bool isLast) {
    if (isLast) {
      return Stack(
        fit : StackFit.expand,
        children: <Widget>[
          Container(
            child: _pages[index],
          ),
          new Align(
            alignment: Alignment.bottomRight,
            child: RaisedButton(
              onPressed: onCloseOnbording,
              child: Text("close onbording"),
            ),
          )
        ],
      );
    } else {
      return _pages[index];
    }
  }

  void onCloseOnbording() {
    Navigator.pushNamed(context, ROUTE_MAIN);
  }
}
