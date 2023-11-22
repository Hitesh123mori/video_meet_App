class MeetUser {
  MeetUser({
    required this.image,
    required this.name,
    required this.createdAt,
    required this.id,
    required this.email,
    required this.method ,
    required this.meetingId ,
    required this.isAudioConnect,
    required this.isSpeakerOn,
    required this.isVideoOn,
  });
  late String image;
  late String name;
  late String createdAt;
  late String id;
  late String email;
  late String method ;
  late String meetingId ;
  late bool isAudioConnect ;
  late bool isSpeakerOn ;
  late bool isVideoOn ;


  MeetUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    id = json['id'] ?? '';
    email = json['email'] ?? '';
    method = json['method'] ?? '';
    meetingId = json['meetingId'] ?? '';
    isAudioConnect =  json['isAudioConnect'] ;
    isSpeakerOn =  json['isSpeakerOn'] ;
    isVideoOn =  json['isVideoOn'] ;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['email'] = email;
    data['method'] = method;
    data['meetingId'] = meetingId ;
    data['isAudioConnect'] = isAudioConnect;
    data['isSpeakerOn'] = isSpeakerOn;
    data['isVideoOn'] = isVideoOn;
    return data;
  }
}