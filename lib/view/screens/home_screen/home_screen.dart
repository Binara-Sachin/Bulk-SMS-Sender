import 'package:bulk_sms_sender/view/widgets/bottomAppBarIcon.dart';
import 'package:flutter/material.dart';

import 'pages/campaigns_page.dart';
import 'pages/instructions_page.dart';
import 'pages/settings_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;
  int _animationDuration = 500;

  PageController _pageController = PageController(initialPage: 0);

  void _animateToPage(int index) {
    setState(() {
      _pageIndex = index;
      _pageController.animateToPage(_pageIndex,
          curve: Curves.ease,
          duration: Duration(milliseconds: _animationDuration));
    });
  }

  void _onPageChange(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      print(_pageController.page.toString());
      if (_pageIndex != _pageController.page.round()) {
        setState(() {
          _pageIndex = _pageController.page.round();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            _onPageChange(index);
            //! setState() or markNeedsBuild() called during build.
          },
          children: <Widget>[
            CampaignsPage(),
            InstructionsPage(),
            SettingsPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              BottomAppBarIcon(
                index: 0,
                pageIndex: _pageIndex,
                icon: Icons.home_outlined,
                title: "Campaigns",
                showText: true,
                onPressed: () {
                  _animateToPage(0);
                },
              ),
              BottomAppBarIcon(
                index: 1,
                pageIndex: _pageIndex,
                icon: Icons.help_outline,
                title: "Instructions",
                showText: true,
                onPressed: () {
                  _animateToPage(1);
                },
              ),
              BottomAppBarIcon(
                index: 2,
                pageIndex: _pageIndex,
                icon: Icons.menu,
                title: "Settings",
                showText: false,
                onPressed: () {
                  _animateToPage(2);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
