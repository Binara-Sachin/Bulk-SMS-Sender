import 'package:bulk_sms_sender/core/model/campaign.dart';
import 'package:bulk_sms_sender/core/provider/campaigns_model.dart';
import 'package:bulk_sms_sender/view/screens/campaign_screens/new_edit_campaign.dart';
import 'package:bulk_sms_sender/view/theme/textStyles.dart';
import 'package:bulk_sms_sender/view/theme/const.dart';
import 'package:bulk_sms_sender/view/widgets/campaignCard.dart';
import 'package:bulk_sms_sender/view/widgets/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CampaignsPage extends StatelessWidget {
  const CampaignsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<CampaignsModel>(context, listen: false).testCampaign();

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
            "There are ${Provider.of<CampaignsModel>(context, listen: false).savedCampaigns.length} Existing Campaigns",
            style: AppTextStyles.blue_body02,
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Consumer<CampaignsModel>(
              builder: (context, campaigns, child) {
                return ListView.builder(
                  itemCount: campaigns.savedCampaigns.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CampaignCard(
                      campaign: campaigns.savedCampaigns[index],
                    );
                  },
                );
              },
            ),
          ),
          Center(
            child: RoundedButton(
              title: "New Campaign",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewEditCampaign(campaign: cleanCampaign),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
