class CommentResponse {
  String? avatar;
  String? username;
  String? content;

  CommentResponse({this.avatar, this.username, this.content});

  CommentResponse.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    username = json['username'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['username'] = this.username;
    data['content'] = this.content;
    return data;
  }
}
