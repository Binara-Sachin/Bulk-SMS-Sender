import 'package:bulk_sms_sender/core/provider/campaigns_model.dart';
import 'package:bulk_sms_sender/core/provider/sender_model.dart';
import 'package:bulk_sms_sender/core/provider/settings_model.dart';
import 'package:bulk_sms_sender/view/screens/campaign_screens/new_edit_campaign.dart';
import 'package:bulk_sms_sender/view/screens/campaign_screens/ongoing_campaign.dart';
import 'package:bulk_sms_sender/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'view/screens/home_screen/home_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: Colors.blue, // status bar color
  ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SenderModel()),
        ChangeNotifierProvider(create: (context) => CampaignsModel()),
        ChangeNotifierProvider(create: (context) => SettingsModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bulk SMS',
      theme: ThemeData(
        primarySwatch: AppColors.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/new': (context) => NewEditCampaign(),
        '/run': (context) => OngoingCampaign(),
      },
    );
  }
}
