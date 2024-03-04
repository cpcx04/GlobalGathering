class CommentDto {
  String? username;
  String? content;
  String? relatedPost;

  CommentDto({this.username, this.content, this.relatedPost});

  CommentDto.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    content = json['content'];
    relatedPost = json['relatedPost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['content'] = this.content;
    data['relatedPost'] = this.relatedPost;
    return data;
  }
}
