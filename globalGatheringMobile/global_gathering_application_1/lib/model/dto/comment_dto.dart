class CommentDto {
  String? content;
  String? relatedPost;

  CommentDto({this.content, this.relatedPost});

  CommentDto.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    relatedPost = json['relatedPost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['relatedPost'] = this.relatedPost;
    return data;
  }
}
