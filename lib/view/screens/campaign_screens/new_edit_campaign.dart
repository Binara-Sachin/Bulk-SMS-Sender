import 'package:bulk_sms_sender/core/model/campaign.dart';
import 'package:bulk_sms_sender/core/provider/campaigns_model.dart';
import 'package:bulk_sms_sender/core/provider/sender_model.dart';
import 'package:bulk_sms_sender/core/services/csv_import.dart';
import 'package:bulk_sms_sender/view/screens/campaign_screens/ongoing_campaign.dart';
import 'package:bulk_sms_sender/view/theme/textStyles.dart';
import 'package:bulk_sms_sender/view/widgets/appAlertDialogs.dart';
import 'package:bulk_sms_sender/view/widgets/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:provider/provider.dart';

class NewEditCampaign extends StatefulWidget {
  final Campaign campaign;
  // final int head;

  const NewEditCampaign({Key key, this.campaign}) : super(key: key);

  @override
  _NewEditCampaignState createState() => _NewEditCampaignState();
}

class _NewEditCampaignState extends State<NewEditCampaign> {
  bool _editing = true;

  int _campaignID;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  List<String> _addressList;
  double _delayValue;

  @override
  void initState() {
    super.initState();

    _campaignID = widget.campaign.id;
    _nameController.text = widget.campaign.campaignName;
    _messageController.text = widget.campaign.msg;
    _addressList = widget.campaign.addresses;
    _delayValue = widget.campaign.delayDuration.inSeconds.toDouble();

    if (_campaignID == -1) {
      _editing = false;
      if (Provider.of<CampaignsModel>(context, listen: false).savedCampaigns.isEmpty) {
        _campaignID = 0;
      } else {
        _campaignID = Provider.of<CampaignsModel>(context, listen: false).savedCampaigns.last.id + 1;
      }
    }
  }

  void clearNumbers() {
    setState(() {
      _addressList = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          _editing ? "Edit Campaign" : "New Campaign",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 8.0, left: 18.0, right: 18.0, bottom: 18.0),
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Campaign Name",
                border: OutlineInputBorder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Name of the campaign is just used for identifying the campaign later.",
                style: AppTextStyles.grey_body02,
              ),
            ),
            Divider(),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7.0),
                  child: Container(
                    height: _height * 0.4,
                    width: _width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey, width: 1.0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: _addressList == null
                        ? Center(
                            child: Text(
                              "Import mobile numbers",
                              style: AppTextStyles.grey_body02,
                            ),
                          )
                        : ListView.builder(
                            itemCount: _addressList.length,
                            itemExtent: 38,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Dismissible(
                                background: Container(color: Colors.red),
                                key: Key(_addressList[index].toString()),
                                onDismissed: (direction) {
                                  setState(() {
                                    _addressList.removeAt(index);
                                  });
                                },
                                child: ListTile(
                                  title: Text(
                                    _addressList[index],
                                    style: AppTextStyles.grey_body02,
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 12.0,
                    ),
                    Container(
                      color: Colors.white,
                      child: Text(
                        "Mobile Numbers",
                        style: AppTextStyles.grey_body02,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: RoundedButton(
            //     title: "Import CSV File",
            //     onPressed: () {},
            //   ),
            // ),
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
                      showClearDialog(context, () {
                        clearNumbers();
                      });
                    },
                  ),
                ),
                RoundedButton(
                  title: "Import CSV File",
                  onPressed: () async {
                    await importCSVFile().then((value) => _addressList = value);
                    setState(() {});
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Please read the instructions carefully before importing the CSV file.",
                style: AppTextStyles.red_body02,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "You can remove imported numbers individually by sliding",
                style: AppTextStyles.grey_body02,
              ),
            ),
            Divider(),
            Text(
              "Delay Duration",
              style: AppTextStyles.grey_body01,
            ),
            FlutterSlider(
              values: [_delayValue],
              max: 600,
              min: 0,
              step: FlutterSliderStep(step: 1.0),
              handler: FlutterSliderHandler(
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.blue,
                  size: 24,
                ),
              ),
              onDragging: (handlerIndex, lowerValue, upperValue) {
                _delayValue = lowerValue;
                // _upperValue = upperValue;
                setState(() {});
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delay : " + _delayValue.toString() + " seconds\n",
                    style: AppTextStyles.grey_body01,
                  ),
                  Text(
                    "This is the delay between each sms.\nPlease note that a random value will be added to the set duration to prevent the service provider from banning you from sending sms.",
                    style: AppTextStyles.grey_body02,
                  ),
                ],
              ),
            ),
            Divider(),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: "Message",
                border: OutlineInputBorder(),
                counterText: "Characters\t" +
                    _messageController.text.length.toString() +
                    "\nSMS Count\t" +
                    (_messageController.text.length ~/ 160 + 1).toString(),
              ),
              maxLines: null,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Maximum length of a SMS is 160 characters. Exceeding that limit will increase the operation cost.",
                style: AppTextStyles.grey_body02,
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedButton(
                  title: "Save",
                  onPressed: () {
                    if (_nameController.text == "") {
                      showErrorDialog(context, "Campaign name cannot be empty");
                    } else if (_addressList == null || _addressList.length == 0) {
                      showErrorDialog(context, "Please import mobile numbers");
                    } else {
                      Provider.of<CampaignsModel>(context, listen: false).saveCampaign(
                        Campaign(
                          id: _campaignID,
                          campaignName: _nameController.text,
                          msg: _messageController.text,
                          delayDuration: Duration(seconds: _delayValue ~/ 1),
                          addresses: _addressList,
                          lastRun: widget.campaign.lastRun == null ? DateTime.now() : widget.campaign.lastRun == null,
                        ),
                      );
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Campaign Saved"),
                      ));
                    }
                  },
                ),
                RoundedButton(
                  title: "Send",
                  onPressed: () {
                    if (_addressList == null || _addressList.length == 0) {
                      showErrorDialog(context, "Please import mobile numbers");
                    } else if (_messageController.text == "") {
                      showErrorDialog(context, "Please type a message to be sent");
                    } else {
                      Provider.of<SenderModel>(context, listen: false).setCampaign(
                          Campaign(
                            id: _campaignID,
                            campaignName: _nameController.text,
                            msg: _messageController.text,
                            delayDuration: Duration(seconds: _delayValue ~/ 1),
                            addresses: _addressList,
                            lastRun: widget.campaign.lastRun == null ? DateTime.now() : widget.campaign.lastRun == null,
                          ),
                          0);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => OngoingCampaign()), (Route<dynamic> route) => false);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
