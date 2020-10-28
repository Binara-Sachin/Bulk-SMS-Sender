import 'package:bulk_sms_sender/core/model/mobile_number.dart';
import 'package:bulk_sms_sender/core/provider/sender_model.dart';
import 'package:bulk_sms_sender/view/screens/home_screen/home_screen.dart';
import 'package:bulk_sms_sender/view/theme/colors.dart';
import 'package:bulk_sms_sender/view/theme/textStyles.dart';
import 'package:bulk_sms_sender/view/widgets/appAlertDialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OngoingCampaign extends StatefulWidget {
  @override
  _OngoingCampaignState createState() => _OngoingCampaignState();
}

class _OngoingCampaignState extends State<OngoingCampaign> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SenderModel>(
      builder: (context, sender, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.exit_to_app_sharp,
                            size: 22,
                          ),
                          onPressed: () {
                            if (sender.operationStatus !=
                                OperationStatus.Sending) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                  (Route<dynamic> route) => false);
                            }
                          },
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              sender.campaignName,
                              style: AppTextStyles.blue_heading01,
                            ),
                            Text(
                              (() {
                                if (sender.operationStatus ==
                                    OperationStatus.Null) {
                                  return "Not Started";
                                } else if (sender.operationStatus ==
                                    OperationStatus.Sending) {
                                  return "Running...";
                                } else if (sender.operationStatus ==
                                    OperationStatus.Paused) {
                                  return "Paused";
                                } else if (sender.operationStatus ==
                                    OperationStatus.Complete) {
                                  showCompleteDialog(context);
                                  return "Operation Complete";
                                }
                                return "Something is Wrong";
                              })(),
                              style: AppTextStyles.grey_body01,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: sender.mobileNumbers.length,
                      itemExtent: 50,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    sender.mobileNumbers[index].number,
                                    style: AppTextStyles.black_body01,
                                  ),
                                  Text(
                                    (() {
                                      if (sender.mobileNumbers[index]
                                              .mobileNumberState ==
                                          MobileNumberState.NULL) {
                                        return "Waiting...";
                                      } else if (sender.mobileNumbers[index]
                                              .mobileNumberState ==
                                          MobileNumberState.Processing) {
                                        return "Processing...";
                                      } else if (sender.mobileNumbers[index]
                                              .mobileNumberState ==
                                          MobileNumberState.Sent) {
                                        return "Sent";
                                      }
                                      return "Something is Wrong";
                                    })(),
                                    style: AppTextStyles.grey_body02,
                                  ),
                                ]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 75,
              padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Operation " +
                            (100 * sender.head / sender.mobileNumbers.length)
                                .toString() +
                            "% complete",
                        style: AppTextStyles.grey_body01,
                      ),
                      AnimatedContainer(
                        height: 2.0,
                        width:
                            250.0 * sender.head / sender.mobileNumbers.length,
                        color: Colors.blue,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.fastOutSlowIn,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      sender.operationStatus == OperationStatus.Sending
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: AppColors.secondaryColor,
                      size: 50.0,
                    ),
                    onPressed: () {
                      if (sender.operationStatus == OperationStatus.Null) {
                        sender.initiateSending();
                      } else {
                        sender.startPauseOperation();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
