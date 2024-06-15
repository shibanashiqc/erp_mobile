class ChatModel { 
  int? id;
  String? message;
  String? sender;
  String? time;
  List? files;
  String? profile;

  ChatModel({
    this.id,
    this.message,
    this.sender,
    this.time,
    this.files,
    this.profile,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    sender = json['sender'];
    time = json['time'];
    files = json['files'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['sender'] = sender;
    data['time'] = time;
    data['files'] = files;
    data['profile'] = profile;
    return data;
  }
}