import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_app/Helpers/AppConstants.dart';
import 'package:news_app/Helpers/LayoutHelper.dart';
import 'package:news_app/UI/SearchScreen.dart';
import 'package:news_app/UI/TopHeadlinesScreen.dart';

class BottomNavigationBarMenu extends StatefulWidget {
  final int index;

  const BottomNavigationBarMenu({Key key, this.index}) : super(key: key);

  @override
  BottomNavigationBarMenuState createState() => BottomNavigationBarMenuState();
}

class BottomNavigationBarMenuState extends State<BottomNavigationBarMenu> {
  int _selectedIndex;
  double width, height;

  @override
  void initState() {
    _selectedIndex = widget.index;
  }

  List<Widget> widgets = [TopHeadlinesScreen(), SearchScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> comfirmExitFromUser() {
    return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: new Text(
              'Confirm',
            ),
            content: new Text('Do you want to exit this app ?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Cancel',
                    style: boldTxtStyle.copyWith(fontSize: 18)),
              ),
              new FlatButton(
                textColor: Colors.red,
                onPressed: () {
                  Navigator.pop(context);
                  exit(0);
                },
                child: new Text(
                  'Exit',
                  style: boldTxtStyle.copyWith(color: Colors.red, fontSize: 20),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
          child: Scaffold(
        body: widgets[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Headlines',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: BLUE_TEXT_COLOR,
          onTap: _onItemTapped,
        ),
      )),
      onWillPop: () {
        if (_selectedIndex != 1) {
          setState(() {
            _selectedIndex = 1;
          });
        } else {
          comfirmExitFromUser();
        }
      },
    );
  }
}
