import 'package:bulk_sms_sender/core/provider/settings_model.dart';
import 'package:bulk_sms_sender/view/theme/const.dart';
import 'package:bulk_sms_sender/view/theme/textStyles.dart';
import 'package:bulk_sms_sender/view/widgets/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({
    Key key,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _countryCodeController = TextEditingController();

  int _selectedSIM = 1;

  final Uri _mail = Uri(
    scheme: 'mailto',
    path: 'rioralk@gmail.com',
    query: 'subject=Bulk SMS App Feedback&body=App Version 0.1.0',
  );

  _launchURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Could not launch $url"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<SettingsModel>(context, listen: false).getValues();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(
      builder: (context, settings, child) {
        _userNameController.text = settings.userName;
        _countryCodeController.text = settings.countryCode;
        if (settings.loading) {
          return Center(
            child: Text(
              "Loading...",
              style: AppTextStyles.blue_heading03,
            ),
          );
        } else {
          return ListView(
            padding: pageViewPadding,
            children: [
              Text(
                'Settings',
                style: AppTextStyles.blue_heading01,
              ),
              Text(
                'Edit app settings here',
                style: AppTextStyles.blue_body01,
              ),
              Divider(),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: "User Name",
                  border: OutlineInputBorder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Your name can be used to add signature to SMS if needed.\nType your preferred SMS signature here.",
                  style: AppTextStyles.grey_body02,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: _countryCodeController,
                decoration: InputDecoration(
                  labelText: "Default Country Code",
                  border: OutlineInputBorder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Country calling codes or country dial-in codes are telephone number prefixes for reaching telephone subscribers in the networks of the member countries or regions of the International Telecommunication Union (ITU).",
                      style: AppTextStyles.grey_body02,
                    ),
                    Text(
                      "If you don't know your country code you can find it below.",
                      style: AppTextStyles.grey_body02,
                    ),
                    GestureDetector(
                      child: Text(
                        "https://countrycode.org/",
                        style: AppTextStyles.blue_body02,
                      ),
                      onTap: () {
                        _launchURL(context, "https://countrycode.org/");
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Preferred SIM",
                  style: AppTextStyles.grey_body01,
                ),
              ),
              RadioListTile(
                value: 1,
                groupValue: _selectedSIM,
                onChanged: (ind) => setState(() => _selectedSIM = ind),
                title: Row(
                  children: [
                    Icon(
                      Icons.sim_card_outlined,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "SIM 1",
                      style: AppTextStyles.grey_body01,
                    ),
                  ],
                ),
              ),
              RadioListTile(
                value: 2,
                groupValue: _selectedSIM,
                onChanged: (ind) => setState(() => _selectedSIM = ind),
                title: Row(
                  children: [
                    Icon(
                      Icons.sim_card_outlined,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "SIM 2",
                      style: AppTextStyles.grey_body01,
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedButton(
                    title: "Discard",
                    onPressed: () {
                      _userNameController.text = settings.userName;
                      _countryCodeController.text = settings.countryCode;
                    },
                  ),
                  RoundedButton(
                    title: "Save",
                    onPressed: () {
                      settings.setUserName(_userNameController.text);
                      settings.setCountryCode(_countryCodeController.text);
                    },
                  ),
                ],
              ),
              Divider(),
              Text(
                "About Us",
                style: AppTextStyles.grey_body01,
              ),
              ListTile(
                title: Text(
                  "Developed By",
                  style: AppTextStyles.grey_body02,
                ),
                subtitle: Text(
                  "Riora Innovations",
                  style: AppTextStyles.grey_heading03,
                ),
              ),
              ListTile(
                title: Text(
                  "Check our other apps",
                  style: AppTextStyles.grey_body01,
                ),
                leading: Icon(
                  Icons.link,
                  size: 20.0,
                ),
                onTap: () {
                  _launchURL(context, "https://play.google.com/store/apps/developer?id=Riora+Inc.&hl=en_US");
                },
              ),
              Text(
                "E-mail us regarding any problem in the app\nWe will be happy to hear your feedback and suggestions as well",
                style: AppTextStyles.grey_body01,
              ),
              ListTile(
                title: Text(
                  "Contact Developer",
                  style: AppTextStyles.grey_body01,
                ),
                leading: Icon(
                  Icons.mail_outline,
                  size: 20.0,
                ),
                onTap: () {
                  _launchURL(context, _mail.toString());
                },
              ),
            ],
          );
        }
      },
    );
  }
}
