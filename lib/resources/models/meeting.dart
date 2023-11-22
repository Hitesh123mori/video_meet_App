class Meeting {
  Meeting({
    required this.name,
    required this.hostName,
    required this.hostEmail,
    required this.date,
    required this.meetingId,
    required this.password,
  });
  late String name;
  late String meetingId;
  late String hostName;
  late String date ;
  late String hostEmail ;
  late String password ;


  Meeting.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    hostEmail = json['hostEmail'] ?? '';
    meetingId = json['meetingId'] ?? '';
    hostName =  json['hostName'] ;
    date =  json['date'] ;
    password  = json['password'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['hostEmail'] = hostEmail;
    data['meetingId'] = meetingId;
    data['hostName'] = hostName;
    data['date'] = date;
    data['password'] = password ;
    return data;
  }
}