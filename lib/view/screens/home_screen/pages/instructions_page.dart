import 'package:bulk_sms_sender/view/theme/const.dart';
import 'package:bulk_sms_sender/view/theme/textStyles.dart';
import 'package:flutter/material.dart';

class InstructionsPage extends StatelessWidget {
  const InstructionsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: pageViewPadding,
      children: [
        Text(
          'Instructions',
          style: AppTextStyles.blue_heading01,
        ),
        Text(
          'Please read the following set of instructions carefully before using the app',
          style: AppTextStyles.blue_body01,
          // textAlign: TextAlign.center,
        ),
        Divider(),
        Text(
          "App Overview\n",
          style: AppTextStyles.grey_heading03,
        ),
        Text(
          "This app sends....",
          style: AppTextStyles.black_body01,
        ),
        Text(
          "\nMobile Number format\n",
          style: AppTextStyles.grey_heading03,
        ),
        Text(
          "Importing Numbers should be in the following format",
          style: AppTextStyles.black_body01,
        ),
        Text(
          "\t\t+94767102855",
          style: AppTextStyles.grey_body01,
        ),
        Text(
          "\t\t94767102855",
          style: AppTextStyles.grey_body01,
        ),
        Text(
          "Where, +94 or 94 is the country code",
          style: AppTextStyles.black_body01,
        ),
        Text(
          "76 is the area code",
          style: AppTextStyles.black_body01,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Placeholder(
            fallbackHeight: 100.0,
          ),
        ),
        Text(
          "And ",
          style: AppTextStyles.black_body01,
        ),
        Text(
          "\nInstructions for importing CSV file\n",
          style: AppTextStyles.grey_heading03,
        ),
        Text(
          "CSV file type is...",
          style: AppTextStyles.black_body01,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Placeholder(
            fallbackHeight: 100.0,
          ),
        ),
      ],
    );
  }
}
