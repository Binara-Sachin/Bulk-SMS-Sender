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

  List<Widget> _pages = [
    CampaignsPage(),
    InstructionsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_pageIndex]),
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
                  setState(() {
                    _pageIndex = 0;
                  });
                },
              ),
              BottomAppBarIcon(
                index: 1,
                pageIndex: _pageIndex,
                icon: Icons.help_outline,
                title: "Instructions",
                showText: true,
                onPressed: () {
                  setState(() {
                    _pageIndex = 1;
                  });
                },
              ),
              BottomAppBarIcon(
                index: 2,
                pageIndex: _pageIndex,
                icon: Icons.menu,
                title: "Settings",
                showText: false,
                onPressed: () {
                  setState(() {
                    _pageIndex = 2;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
