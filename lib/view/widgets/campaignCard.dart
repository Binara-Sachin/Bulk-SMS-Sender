import 'package:bulk_sms_sender/core/model/campaign.dart';
import 'package:bulk_sms_sender/core/provider/sender_model.dart';
import 'package:bulk_sms_sender/view/screens/campaign_screens/new_edit_campaign.dart';
import 'package:bulk_sms_sender/view/screens/campaign_screens/ongoing_campaign.dart';
import 'package:bulk_sms_sender/view/theme/textStyles.dart';
import 'package:bulk_sms_sender/view/widgets/appAlertDialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'roundedButton.dart';

class CampaignCard extends StatelessWidget {
  final Campaign campaign;

  const CampaignCard({Key key, this.campaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(campaign.campaignName),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: EdgeInsets.only(left: 12.0, right: 12.0),
        children: [
          Text(
            "Message",
            style: AppTextStyles.grey_body01,
          ),
          Text(
            campaign.msg,
            style: AppTextStyles.black_body01,
          ),
          Divider(),
          Text(
            "Delay Duration",
            style: AppTextStyles.grey_body01,
          ),
          Text(
            campaign.delayDuration.inSeconds.toString() + " seconds",
            style: AppTextStyles.black_body01,
          ),
          Divider(),
          Text(
            "Contact Numbers",
            style: AppTextStyles.grey_body01,
          ),
          Text(
            campaign.addresses.toString(),
            style: AppTextStyles.black_body02,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  color: Colors.white,
                  iconSize: 20,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDeleteDialog(context, campaign);
                    // showAboutDialog(context: context);
                  },
                ),
              ),
              Container(
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  color: Colors.white,
                  iconSize: 20,
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewEditCampaign(campaign: campaign),
                      ),
                    );
                  },
                ),
              ),
              RoundedButton(
                title: "Send",
                onPressed: () {
                  Provider.of<SenderModel>(context, listen: false)
                      .setCampaign(campaign);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => OngoingCampaign()),
                      (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}
