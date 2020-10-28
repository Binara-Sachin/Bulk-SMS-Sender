import 'package:bulk_sms_sender/core/model/campaign.dart';
import 'package:bulk_sms_sender/core/provider/campaigns_model.dart';
import 'package:bulk_sms_sender/view/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

showDeleteDialog(BuildContext context, Campaign campaign) {
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text(
      "Delete",
      style: TextStyle(color: Colors.red),
    ),
    onPressed: () {
      Navigator.of(context).pop();
      Provider.of<CampaignsModel>(context, listen: false)
          .deleteCampaign(campaign);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Bulk SMS"),
    content: Text("Are you sure you want to delete this campaign ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showClearDialog(BuildContext context, Function onPressed) {
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text(
      "Clear",
      style: TextStyle(color: Colors.red),
    ),
    onPressed: () {
      onPressed();
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Bulk SMS"),
    content: Text("Are you sure you want to remove all imported numbers ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showErrorDialog(BuildContext context, String errorMessage) {
  Widget okayButton = FlatButton(
    child: Text("Okay"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Bulk SMS"),
    content: Text(errorMessage),
    actions: [
      okayButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showCompleteDialog(BuildContext context) {
  Widget cancelButton = FlatButton(
    child: Text("Okay"),
    onPressed: () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false);
    },
  );
  Widget continueButton = FlatButton(
    child: Text(
      "ViewReport",
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Bulk SMS"),
    content: Text("Are you sure you want to delete this campaign ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
