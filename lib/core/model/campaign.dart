class Campaign {
  final int id;
  final String campaignName;
  final String msg;
  final Duration delayDuration;
  final List<String> addresses;

  Campaign({
    this.id,
    this.campaignName,
    this.msg,
    this.delayDuration,
    this.addresses,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'campaignName': campaignName,
      'msg': msg,
      'delayDuration': delayDuration,
      'mobileNumbers': addresses,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, campaignName: $campaignName, msg: $msg,delayDuration: $delayDuration, mobileNumbers: $addresses}';
  }
}

final Campaign cleanCampaign = Campaign(
  id: -1,
  campaignName: "",
  msg: "",
  addresses: null,
  delayDuration: Duration(seconds: 10),
);
