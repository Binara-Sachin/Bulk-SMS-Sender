import 'package:bulk_sms_sender/core/model/campaign.dart';
import 'package:bulk_sms_sender/core/provider/campaigns_model.dart';
import 'package:bulk_sms_sender/core/provider/sender_model.dart';
import 'package:bulk_sms_sender/view/screens/campaign_screens/ongoing_campaign.dart';
import 'package:bulk_sms_sender/view/theme/colors.dart';
import 'package:bulk_sms_sender/view/theme/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResumeCampaignCard extends StatelessWidget {
  const ResumeCampaignCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CampaignsModel>(builder: (context, campaigns, child) {
      Campaign resumeCampaign;

      for (var c in campaigns.savedCampaigns) {
        if (c.id == campaigns.ongoingCampaign) {
          resumeCampaign = c;
        }
      }

      return Card(
        color: AppColors.primaryColor,
        child: ListTile(
          title: Text(
            "Resume Campaign",
            // style: AppTextStyles.white_heading03,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            resumeCampaign.campaignName +
                "\n" +
                campaigns.ongoingHead.toString() +
                " Sent \t" +
                (resumeCampaign.addresses.length - campaigns.ongoingHead).toString() +
                " Remaining",
            style: AppTextStyles.white_body02,
            // style: TextStyle(
            //   color: Colors.white,
            // ),
          ),
          trailing: Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
          onTap: () {
            Provider.of<SenderModel>(context, listen: false).setCampaign(resumeCampaign, campaigns.ongoingHead);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => OngoingCampaign()), (Route<dynamic> route) => false);
          },
        ),
      );
    });
  }
}
