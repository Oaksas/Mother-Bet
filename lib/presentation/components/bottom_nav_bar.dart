import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mother_bet/presentation/home/home.dart';
import 'package:mother_bet/presentation/mapDisplay/map_view.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatefulWidget {
  int number;
  BottomNavBar(this.number, {Key? key}) : super(key: key);
  @override
  _BottomNavBarState createState() => _BottomNavBarState(number);
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  _BottomNavBarState(this._page);

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,

      height: 60,
      color: const Color(0XFF6A62B7),
      buttonBackgroundColor: const Color(0XFF6A62B7),
      backgroundColor: Colors.transparent,
      // animationDuration: Duration(seconds: 1),
      // animationCurve: Curves.bounceOut,
      items: const <Widget>[
        Icon(Icons.home, color: Colors.white),
        Icon(Icons.search, color: Colors.white),
      ],
      onTap: (i) {
        setState(() {
          _page = i;
        });
        if (i == 0) {
          Navigator.of(context).pushNamed(HomeScreen.routeName);
        }
        if (i == 1) {
          Navigator.of(context).pushNamed(MapScreen.routeName);
        }
      },
    );
  }
}
