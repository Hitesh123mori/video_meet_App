class ZoomUser {
  ZoomUser({
    required this.image,
    required this.name,
    required this.createdAt,
    required this.id,
    required this.email,
  });
  late String image;
  late String name;
  late String createdAt;
  late String id;
  late String email;

  ZoomUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    id = json['id'] ?? '';
    email = json['email'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['email'] = email;
    return data;
  }
}