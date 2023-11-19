class MeetUser {
  MeetUser({
    required this.image,
    required this.name,
    required this.createdAt,
    required this.id,
    required this.email,
    required this.method ,
  });
  late String image;
  late String name;
  late String createdAt;
  late String id;
  late String email;
  late String method ;

  MeetUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    id = json['id'] ?? '';
    email = json['email'] ?? '';
    method = json['method'] ?? '';

  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['email'] = email;
    data['method'] = method;
    return data;
  }
}