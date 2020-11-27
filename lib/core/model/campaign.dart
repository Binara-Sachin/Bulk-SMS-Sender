class Campaign {
  final int id;
  final String campaignName;
  final String msg;
  final Duration delayDuration;
  final List<String> addresses;
  final DateTime lastRun;

  Campaign({
    this.id,
    this.campaignName,
    this.msg,
    this.delayDuration,
    this.addresses,
    this.lastRun,
  });
}

final Campaign cleanCampaign = Campaign(
  id: -1,
  campaignName: "",
  msg: "",
  addresses: null,
  delayDuration: Duration(seconds: 10),
  lastRun: null,
);
