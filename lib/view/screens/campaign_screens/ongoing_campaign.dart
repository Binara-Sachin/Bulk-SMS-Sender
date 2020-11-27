import 'package:bulk_sms_sender/core/model/enums.dart';
import 'package:bulk_sms_sender/core/model/mobile_number.dart';
import 'package:bulk_sms_sender/core/provider/sender_model.dart';
import 'package:bulk_sms_sender/view/theme/colors.dart';
import 'package:bulk_sms_sender/view/theme/textStyles.dart';
import 'package:bulk_sms_sender/view/widgets/appAlertDialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class OngoingCampaign extends StatefulWidget {
  @override
  _OngoingCampaignState createState() => _OngoingCampaignState();
}

class _OngoingCampaignState extends State<OngoingCampaign> {
  @override
  void dispose() {
    print("Dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: Consumer<SenderModel>(
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
                              showExitDialog(context);
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
                                  if (sender.operationStatus == OperationStatus.Null) {
                                    return "Not Started";
                                  } else if (sender.operationStatus == OperationStatus.Sending) {
                                    return "Running...";
                                  } else if (sender.operationStatus == OperationStatus.Paused) {
                                    return "Paused";
                                  } else if (sender.operationStatus == OperationStatus.Complete) {
                                    // showCompleteDialog(context);
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
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Please do not close the app while running.\nClosing the app will stop the operation",
                        style: AppTextStyles.red_body02,
                      ),
                    ),
                    Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: sender.mobileNumbers.length,
                        itemExtent: 50,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Text(
                                  sender.mobileNumbers[index].number,
                                  style: AppTextStyles.black_body01,
                                ),
                                Text(
                                  (() {
                                    if (sender.mobileNumbers[index].mobileNumberState == MobileNumberState.NULL) {
                                      return "Waiting...";
                                    } else if (sender.mobileNumbers[index].mobileNumberState ==
                                        MobileNumberState.Processing) {
                                      return "Processing...";
                                    } else if (sender.mobileNumbers[index].mobileNumberState ==
                                        MobileNumberState.Sent) {
                                      return "Sent";
                                    } else if (sender.mobileNumbers[index].mobileNumberState ==
                                        MobileNumberState.Delivered) {
                                      return "Delivered";
                                    } else if (sender.mobileNumbers[index].mobileNumberState ==
                                        MobileNumberState.Failed) {
                                      return "Failed";
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
                height: 65,
                padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          (100 * sender.head ~/ sender.mobileNumbers.length).toString() + "% complete",
                          style: AppTextStyles.grey_body01,
                        ),
                        Container(
                          width: _width * 0.7,
                          child: StepProgressIndicator(
                            totalSteps: sender.mobileNumbers.length,
                            currentStep: sender.head,
                            size: 20,
                            // padding: 0.5,
                            selectedColor: Colors.blue,
                            unselectedColor: Color(0xFFB8C7CB),
                            roundedEdges: Radius.circular(10),
                            // unselectedGradientColor: LinearGradient(
                            //   begin: Alignment.topLeft,
                            //   end: Alignment.bottomRight,
                            //   colors: [Colors.blue, Colors.white],
                            // ),
                          ),
                        ),
                      ],
                    ),

                    // RoundedButton(
                    //   title: sender.operationStatus == OperationStatus.Sending
                    //       ? "Pause"
                    //       : "Send",
                    //   onPressed: () {
                    //     if (sender.operationStatus == OperationStatus.Null) {
                    //       sender.initiateSending();
                    //     } else {
                    //       sender.startPauseOperation();
                    //     }
                    //   },
                    // ),

                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        color: Colors.white,
                        iconSize: 20,
                        icon: Icon(
                          sender.operationStatus == OperationStatus.Sending ? Icons.pause : Icons.play_arrow,
                          color: AppColors.tertiaryColor,
                          // size: 50.0,
                        ),
                        onPressed: () {
                          if (sender.operationStatus == OperationStatus.Null) {
                            sender.initiateSending();
                          } else {
                            sender.startPauseOperation();
                          }
                          // showAboutDialog(context: context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
