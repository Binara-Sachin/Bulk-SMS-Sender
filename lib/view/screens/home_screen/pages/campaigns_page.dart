import 'package:bulk_sms_sender/core/model/campaign.dart';
import 'package:bulk_sms_sender/core/provider/campaigns_model.dart';
import 'package:bulk_sms_sender/view/screens/campaign_screens/new_edit_campaign.dart';
import 'package:bulk_sms_sender/view/theme/colors.dart';
import 'package:bulk_sms_sender/view/theme/textStyles.dart';
import 'package:bulk_sms_sender/view/theme/const.dart';
import 'package:bulk_sms_sender/view/widgets/campaignCard.dart';
import 'package:bulk_sms_sender/view/widgets/resumeCampaignCard.dart';
import 'package:bulk_sms_sender/view/widgets/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CampaignsPage extends StatelessWidget {
  const CampaignsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<CampaignsModel>(context, listen: false).readCampaigns();

    return Consumer<CampaignsModel>(
      builder: (context, campaigns, child) {
        bool resumeCampaign = false;

        for (var c in campaigns.savedCampaigns) {
          if (c.id == campaigns.ongoingCampaign) {
            resumeCampaign = true;
            break;
          }
        }

        if (campaigns.loading) {
          return Center(
            child: Text(
              "Loading...",
              style: AppTextStyles.blue_heading03,
            ),
          );
          // } else if (campaigns.savedCampaigns.isEmpty) {
          //   return Container(child: Text("Add Campaigns"),);
        } else {
          print("ongoing " + campaigns.ongoingCampaign.toString());
          return Padding(
            padding: pageViewPadding,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Existing Campaigns",
                  style: AppTextStyles.blue_heading02,
                ),
                Text(
                  campaigns.savedCampaigns.isEmpty
                      ? "There are No Existing Campaigns"
                      : "There are ${campaigns.savedCampaigns.length} Existing Campaigns",
                  style: AppTextStyles.blue_body02,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: resumeCampaign ? ResumeCampaignCard() : Container(),
                ),
                campaigns.savedCampaigns.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: campaigns.savedCampaigns.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CampaignCard(
                              campaign: campaigns.savedCampaigns[index],
                            );
                          },
                        ),
                      )
                    : Expanded(
                        child: Center(
                          child: Text("You don't have any saved campaigns"),
                        ),
                      ),
                // Center(
                //   child: RoundedButton(
                //     title: "Add test Campaigns",
                //     onPressed: () {
                //       campaigns.testCampaign();
                //     },
                //   ),
                // ),
                Center(
                  child: RoundedButton(
                    title: "New Campaign",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewEditCampaign(campaign: cleanCampaign),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
