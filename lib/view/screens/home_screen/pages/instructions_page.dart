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
          "This app is used to send SMS messages in a bulk.\nBut unlike other apps in this category this ap sends SMS from your mobile sim.",
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
          "\n        442071838750 or +442071838750",
          style: AppTextStyles.grey_body01,
        ),
        Text(
          "\nHere are the instructions for converting mobile numbers from your local formatting to E.164 Mobile Number formatting:",
          style: AppTextStyles.black_body01,
        ),
        Text(
          "\nFor example, here’s a UK-based number in standard local formatting: ",
          style: AppTextStyles.black_body01,
        ),
        Text(
          "\n        020 7183 8750\n",
          style: AppTextStyles.grey_body01,
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Placeholder(
        //     fallbackHeight: 100.0,
        //   ),
        // ),
        // FadeInImage.assetNetwork(
        //   placeholder: "assets/into/01.png",
        //   image: "assets/into/01.png",
        // ),
        Image(image: AssetImage("assets/images/intro/01.png")),
        Text(
          "\nHere’s the same phone number in E.164 formatting:",
          style: AppTextStyles.black_body01,
        ),
        Text(
          "\n        +442071838750\n",
          style: AppTextStyles.grey_body01,
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Placeholder(
        //     fallbackHeight: 100.0,
        //   ),
        // ),
        Image(image: AssetImage("assets/images/intro/02.png")),
        Text(
          "\nYou can import number as:",
          style: AppTextStyles.black_body01,
        ),
        Text(
          "\n        +442071838750 or 442071838750",
          style: AppTextStyles.grey_body01,
        ),
        Text(
          "\nInstructions for importing CSV file\n",
          style: AppTextStyles.grey_heading03,
        ),
        Text(
          "\nA CSV is a comma-separated values file, which allows data to be saved in a tabular format. CSVs look like a garden-variety spreadsheet but with a \'.csv\' extension. CSV files can be used with most any spreadsheet program, such as Microsoft Excel or Google Spreadsheets.",
          style: AppTextStyles.black_body01,
        ),
        Text(
          "\nYou can just go to MS Excel or Google Spreadsheets and input your numbers as shown below",
          style: AppTextStyles.black_body01,
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Placeholder(
        //     fallbackHeight: 100.0,
        //   ),
        // ),
        Image(image: AssetImage("assets/images/intro/03.png")),
        Text(
          "\nFinally, save the file in the CSV format and import it to the app in New or Edit campaign page.",
          style: AppTextStyles.black_body01,
        ),
      ],
    );
  }
}
