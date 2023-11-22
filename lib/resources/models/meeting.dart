class Meeting {
  Meeting({
    required this.name,
    required this.docId,
    required this.hostName,
    required this.hostEmail,
    required this.date,
    required this.meetingId,
  });
  late String name;
  late String docId;
  late String meetingId;
  late String hostName;
  late String date ;
  late String hostEmail ;


  Meeting.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    docId = json['docId'] ?? '';
    hostEmail = json['hostEmail'] ?? '';
    meetingId = json['meetingId'] ?? '';
    hostName =  json['hostName'] ;
    date =  json['date'] ;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['docId'] = docId;
    data['host_Email'] = hostEmail;
    data['meetingId'] = meetingId;
    data['hostName'] = hostName;
    data['date'] = date;
    return data;
  }
}