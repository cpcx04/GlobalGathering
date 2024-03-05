class CommentResponse {
  String? uuid;
  String? avatar;
  String? username;
  String? content;

  CommentResponse({this.avatar, this.username, this.content, this.uuid});

  CommentResponse.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    avatar = json['avatar'];
    username = json['username'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['avatar'] = this.avatar;
    data['username'] = this.username;
    data['content'] = this.content;
    return data;
  }
}
