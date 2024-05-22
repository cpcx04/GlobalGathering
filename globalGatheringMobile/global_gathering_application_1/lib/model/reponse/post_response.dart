class PostResponse {
  String? uuid;
  String? comment;
  String? relatedEvent;
  String? uri;
  String? createdBy;
  String? createdAt;

  PostResponse(
      {this.uuid,
      this.comment,
      this.relatedEvent,
      this.uri,
      this.createdBy,
      this.createdAt});

  PostResponse.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    comment = json['comment'];
    relatedEvent = json['relatedEvent'];
    uri = json['uri'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['comment'] = this.comment;
    data['relatedEvent'] = this.relatedEvent;
    data['uri'] = this.uri;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
